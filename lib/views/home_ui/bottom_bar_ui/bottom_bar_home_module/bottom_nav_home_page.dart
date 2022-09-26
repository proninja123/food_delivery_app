import 'dart:convert';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:food_delivery/views/home_ui/bottom_bar_ui/bottom_bar.dart';
import 'package:food_delivery/utils/app_colors.dart';
import 'package:food_delivery/views/home_ui/about_order_filter_module/FilterPage.dart';
import 'package:food_delivery/views/home_ui/seller_menu_module/seller_menu_items_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter_svg/svg.dart';
import '../bottom_bar.dart';
import 'dart:math' as math;
import 'package:http/http.dart' as http;
import 'package:food_delivery/views/home_ui/seller_menu_module/RestuarentModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

int cd = 0;

class HomePage extends StatefulWidget {
  HomePage({this.show_search});

  bool show_search;

  @override
  _HomePageState createState() => _HomePageState(show_search: show_search);
}

class _HomePageState extends State<HomePage> {
  _HomePageState({this.show_search});

  bool show_search;
  FocusNode search_focus = new FocusNode();
  int currentPage = 0;
  PageController _pageController =
      new PageController(initialPage: 0, keepPage: true, viewportFraction: 0.8);
  String _selectedLocation;
  int _current = 0;

  int currentCategoryIndex = 0;
  List<String> _locations = [
    'Home (Carrera 46 #52-96)',
    'Office (Carrera 46 #52-96)',
    'Others (Carrera 46 #52-96)'
  ];
  List<Widget> carosel = new List<Widget>();
  List<Categorylist> iList = new List<Categorylist>();
  List<topickslist> tList = new List<topickslist>();
  List<restaurentlist> rList = new List<restaurentlist>();
  RestuarentModel _restuarentModel;
  var convertPost;
  List ids = [
    "102",
    "103",
    "104",
    "105",
    "106",
    "107",
    "131",
    "132",
    "133",
    "134",
    "135",
    "136",
    "137",
  ];

  Future<String> getHome() async {
    var url =
        'https://www.comiida.com/api/restaurant/search/&lat=26.399700164795&lng=-80.101676940918';

    var response = await http.get(Uri.parse(url));

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    setState(() {
      convertPost = json.decode(response.body);
      print("${convertPost["${ids[2]}"]['cover']}");
      /* var convertPost = json.decode(jssoonn);
      var jj=json.encode({"Data":convertPost});
      var cj=json.decode(jj);
      _restuarentModel=RestuarentModel.fromJson(cj);
      print(_restuarentModel.data.length);*/
    });
  }

  List<restaurantMenu> fullMenu = <restaurantMenu>[];

  Future<String> getRestaurantMenu() async {
    var url =
        'https://www.comiida.com/appapi/restaurant/search/&lat=26.399700164795&lng=-80.101676940918';

    var response = await http.get(Uri.parse(url));
    // print(response.body);
    fullMenu.clear();
    Map<String, dynamic> convertData = json.decode(response.body);
    for (var menu in convertData.keys) {
      var tempRestaurantMenu = new restaurantMenu(
          convertData[menu]['restid'],
          convertData[menu]['name'],
          convertData[menu]['cuisinid'],
          convertData[menu]['cuisine'],
          convertData[menu]['address'],
          convertData[menu]['city'],
          convertData[menu]['state'],
          convertData[menu]['distance'],
          convertData[menu]['deliverytime'],
          convertData[menu]['reviews'],
          convertData[menu]['logo'],
          convertData[menu]['cover'],
          convertData[menu]['acceptorders'],
          convertData[menu]['isOpen']);
      setState(() {
        fullMenu.add(tempRestaurantMenu);
      });
    }
    setState(() {
      print('REFRESSSSHHHHEEEDDDD');
      print(fullMenu[0].name);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timestamp) {
      // do stuff after frame is build
      if (show_search == true) {
        FocusScope.of(context).requestFocus(search_focus);
      }
      setState(() {
        timeDilation = 1;
      });
    });
    getRestaurantMenu();
    //getHome();

    addtoList();

    super.initState();
  }

  final List<int> pages = List.generate(4, (index) => index);
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      /* endDrawer:SideBar(),
    */ /*  appBar: AppBar(
        elevation: 0,
        titleSpacing: 0,
        automaticallyImplyLeading: false,
        title:   Padding(
          padding: const EdgeInsets.only(left:20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 12,height: 14,
                child: SvgPicture.asset(
                  'images/svg/_Color 1 .svg',
                    color: ThemeProvider.of(context).brightness ==
                        Brightness.light
                        ? head:Colors.white,
                    height: 14,
                  fit: BoxFit.cover,
                  matchTextDirection: false,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:8.0),
                child: new DropdownButton(
                  underline: Container(color: Colors.transparent),
                  icon: Container(

                    child: Center(child: Icon(Icons.keyboard_arrow_down_sharp,color: ThemeProvider.of(context).brightness ==
                        Brightness.light
                        ? Colors.grey:Colors.white,)),
                  ),
                  elevation: 0,

                  hint: Text('Home (Carrera 46 #52-96)', style: TextStyle(
                      fontFamily: 'Montserrat',color: ThemeProvider.of(context).brightness ==
                      Brightness.light
                      ? head:Colors.white, fontWeight: FontWeight.w500,fontSize: 16
                  ),),
                  style: TextStyle(fontSize: 16,fontFamily: 'Montserrat',color: ThemeProvider.of(context).brightness ==
                      Brightness.light
                      ? head:Colors.white,fontWeight: FontWeight.w500),
                  value: _selectedLocation,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedLocation = newValue;
                    });
                  },
                  items: _locations.map((location) {
                    return DropdownMenuItem(

                      child: new Text(location),
                      value: location,
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
        backgroundColor:  ThemeProvider.of(context).brightness ==
            Brightness.light
            ? Colors.white:Color(0xFF131824),
        actions: [
          Padding(
            padding: EdgeInsets.only(right:20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Image.asset('images/location-map.png',fit: BoxFit.contain,height: 20,),


                InkWell(
                  onTap: (){
                    _scaffoldKey.currentState.openEndDrawer();
                  },
                  child: Container(

                    child:Transform(
                      alignment: Alignment.center,
                        transform: Matrix4.rotationY(math.pi),

                        child: Icon(Icons.notes_outlined,color: head,size: 30,)),
                  ),
                ),
              ],
            ),
          ),


        ],
      ),*/
      body: RefreshIndicator(
        onRefresh: getRestaurantMenu,
        child: SingleChildScrollView(
          child: Column(
            children: [
              show_search == true
                  ? SizedBox(
                      height: 30,
                    )
                  : SizedBox(
                      height: 0.1,
                    ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 20,
                ),
                child: Container(
                    height: 47,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(24)),
                        boxShadow: [
                          BoxShadow(
                              color: ThemeProvider.of(context).brightness ==
                                      Brightness.light
                                  ? Colors.red.withOpacity(0.07)
                                  : Color(0xff222C44).withOpacity(0.07),
                              spreadRadius: 8,
                              blurRadius: 20,
                              offset: Offset(0, 7))
                        ],
                        color: ThemeProvider.of(context).brightness ==
                                Brightness.light
                            ? Colors.white
                            : Color(0xff222C44)),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0, bottom: 4),
                          child: Container(
                            width: 18,
                            height: 18,
                            margin: EdgeInsets.only(right: 10),
                            child: Image.asset(
                              "images/Group 9.png",
                              color: Color(0xffed1d1d),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            focusNode: search_focus,
                            onTap: () {
                              setState(() {
                                BottomBar.showint = 1;
                                BottomBar.showb = true;
                              });
                              Navigator.pushReplacementNamed(
                                  context, '/bottom');
                            },
                            decoration: InputDecoration(
                                hintText:
                                    "Search for restaurants, cuisines or a dish..",
                                hintStyle: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Montserrat',
                                    color:
                                        ThemeProvider.of(context).brightness ==
                                                Brightness.light
                                            ? head.withOpacity(0.5)
                                            : Colors.white.withOpacity(0.5),
                                    fontWeight: FontWeight.w500,
                                    height: 1),
                                border: InputBorder.none),
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'Montserrat',
                                color: ThemeProvider.of(context).brightness ==
                                        Brightness.light
                                    ? head
                                    : Colors.white,
                                fontWeight: FontWeight.w500,
                                height: 1),
                          ),
                        ),
                      ],
                    )),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.only(top: 35, bottom: 14),
                  child: SizedBox(
                    height: 110,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: iList.length,
                      itemBuilder: (BuildContext context, int index) => Padding(
                        padding: (index == 0)
                            ? EdgeInsets.only(left: 8)
                            : EdgeInsets.only(left: 8),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              currentCategoryIndex = index;
                            });
                          },
                          child: Container(
                            height: 50,
                            width: 80,
                            margin: EdgeInsets.only(top: 5),
                            child: Column(
                              children: [
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      color: currentCategoryIndex == index
                                          ? button_red
                                          : ThemeProvider.of(context)
                                                      .brightness ==
                                                  Brightness.light
                                              ? Colors.white
                                              : head,
                                      boxShadow: [
                                        BoxShadow(
                                            color: ThemeProvider.of(context)
                                                        .brightness ==
                                                    Brightness.light
                                                ? Colors.black.withOpacity(0.07)
                                                : Color(0xFF131824)
                                                    .withOpacity(0.13),
                                            blurRadius: 0.1,
                                            spreadRadius: 0.1,
                                            offset: Offset(3, 3))
                                      ]),
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    child: SvgPicture.asset(
                                      '${iList[index].image}',
                                      matchTextDirection: true,
                                      color: currentCategoryIndex == index
                                          ? Colors.yellow
                                          : ThemeProvider.of(context)
                                                      .brightness ==
                                                  Brightness.light
                                              ? Colors.grey
                                              : Colors.white,
                                      height: 10,
                                      fit: BoxFit.contain, //Color(0xff515970),
                                    ),
                                  ),
                                ),
                                //Image.asset('${iList[index].image}',fit: BoxFit.contain,height: 50,),
                                Padding(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: Text(
                                    '${iList[index].name}',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: 'Montserrat',
                                        color: Color(0xff535B72),
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 182,
                child: CustomPageView(
                    onPageChanged: (index) {
                      setState(() {
                        cd = index;
                      });
                    },
                    viewportDirection: false,
                    controller: PageController(viewportFraction: 0.8),
                    children: carosel),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [1, 2, 3, 4].map((i) {
                  int index = [1, 2, 3, 4].indexOf(i);
                  return Container(
                    width: cd == index ? 8.0 : 6,
                    height: cd == index ? 8.0 : 6,
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: cd == index
                          ? Colors.red
                          : ThemeProvider.of(context).brightness ==
                                  Brightness.light
                              ? Color.fromRGBO(0, 0, 0, 0.2)
                              : head,
                    ),
                  );
                }).toList(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 28.0, left: 20),
                child: Row(
                  children: [
                    Text(
                      'Top picks near you',
                      style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'Montserrat',
                          color: ThemeProvider.of(context).brightness ==
                                  Brightness.light
                              ? head
                              : Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 100,
                            childAspectRatio: 1 / 3,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 0),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: tList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: index == 0 || index == 1
                                ? EdgeInsets.only(left: 20.0, bottom: 10)
                                : EdgeInsets.only(left: 20.0, bottom: 10),
                            child: Container(
                              //margin: EdgeInsets.only(bottom: 5),
                              height: 85,
                              width: 220,
                              child: Row(
                                children: [
                                  Container(
                                    height: 85,
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: 75,
                                          width: 80,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  '${tList[index].image}'),
                                              fit: BoxFit.cover,
                                            ),
                                            color: Colors.green,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12)),
                                          ),
                                        ),
                                        Positioned(
                                            left: 0,
                                            bottom: 0,
                                            right: 0,
                                            child: Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 6),
                                              height: 20,
                                              width: 48,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(9)),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.red
                                                          .withOpacity(0.07),
                                                      spreadRadius: 2,
                                                      blurRadius: 5,
                                                      offset: Offset(0, 5))
                                                ],
                                              ),
                                              child: Center(
                                                  child: Text(
                                                '30% Off',
                                                style: TextStyle(
                                                    fontSize: 9,
                                                    fontFamily: 'Montserrat',
                                                    letterSpacing: .5,
                                                    color: Color(0xffed1d1d),
                                                    fontWeight:
                                                        FontWeight.w700),
                                              )),
                                            )),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, top: 5, bottom: 5),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${tList[index].name}",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'Montserrat',
                                              color: ThemeProvider.of(context)
                                                          .brightness ==
                                                      Brightness.light
                                                  ? head
                                                  : Colors.white,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          "45 min",
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontFamily: 'Montserrat',
                                              color: ThemeProvider.of(context)
                                                          .brightness ==
                                                      Brightness.light
                                                  ? head
                                                  : Colors.white,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                              'images/svg/star_20210401_174429079.svg',
                                              height: 13,
                                            ),
                                            SizedBox(
                                              width: 3,
                                            ),
                                            SvgPicture.asset(
                                              'images/svg/star_20210401_174429079.svg',
                                              height: 13,
                                            ),
                                            SizedBox(
                                              width: 3,
                                            ),
                                            SvgPicture.asset(
                                              'images/svg/star_20210401_174429079.svg',
                                              height: 13,
                                            ),
                                            SizedBox(
                                              width: 3,
                                            ),
                                            SvgPicture.asset(
                                              'images/svg/star_20210401_174429079.svg',
                                              height: 13,
                                            ),
                                            SizedBox(
                                              width: 3,
                                            ),
                                            SvgPicture.asset(
                                              'images/svg/star_20210401_174429079.svg',
                                              height: 13,
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "Trending",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: 'Montserrat',
                                              color: button_red,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 32.0, left: 20, bottom: 20, right: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'All \nRestaurants',
                      style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'Montserrat',
                          color: ThemeProvider.of(context).brightness ==
                                  Brightness.light
                              ? head
                              : Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  FilterScreen(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            var begin = Offset(1.0, 0.0);
                            var end = Offset.zero;
                            var curve = Curves.ease;

                            var tween = Tween(begin: begin, end: end)
                                .chain(CurveTween(curve: curve));

                            return SlideTransition(
                              position: animation.drive(tween),
                              child: child,
                            );
                          },
                        ));
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 9, horizontal: 9),
                        decoration: BoxDecoration(
                            color: ThemeProvider.of(context).brightness ==
                                    Brightness.light
                                ? Color(0xffF8F9FB)
                                : Color(0xFF222C44),
                            border: Border.all(
                                color: ThemeProvider.of(context).brightness ==
                                        Brightness.light
                                    ? Color(0xffF0F1F5)
                                    : Color(0xFF222C44),
                                width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(7))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'images/svg/Group 1 .svg',
                              matchTextDirection: true,
                              color: ThemeProvider.of(context).brightness ==
                                      Brightness.light
                                  ? Color(0xff515970)
                                  : Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Filters',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'Montserrat',
                                  color: ThemeProvider.of(context).brightness ==
                                          Brightness.light
                                      ? head
                                      : Colors.white,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: head),
                              child: Center(
                                  child: Text(
                                '3',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10),
                              )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: fullMenu.length,
                  itemBuilder: (context, index) {
                    return fullMenu.length != 0
                        ? InkWell(
                            onTap: () async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();

                              await prefs.setString(
                                  'Rname', '${fullMenu[index].name}');
                              await prefs.setString(
                                  'Rreview', '${fullMenu[index].reviews}');
                              await prefs.setString(
                                  'Rlogo', '${fullMenu[index].logo}');
                              await prefs.setString(
                                  'Rcover', '${fullMenu[index].cover}');
                              await prefs.setInt(
                                  'Risopen', fullMenu[index].isOpen);
                              await prefs.setInt(
                                  'Rdelivery', fullMenu[index].deliverytime);

                              Navigator.of(context).push(PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        RestuarentPage(),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  var begin = Offset(1.0, 0.0);
                                  var end = Offset.zero;
                                  var curve = Curves.ease;

                                  var tween = Tween(begin: begin, end: end)
                                      .chain(CurveTween(curve: curve));

                                  return SlideTransition(
                                    position: animation.drive(tween),
                                    child: child,
                                  );
                                },
                              ));
                            },
                            child: Container(
                              width: double.infinity,
                              child: Column(
                                children: [
                                  Container(
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: 186,
                                          child: Column(
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    left: 20.0,
                                                    right: 20,
                                                    bottom: 18,
                                                    top: 10),
                                                height: 150,
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(20)),
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                        '${fullMenu[index].cover}'),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 40.0),
                                                      child: Container(
                                                        height: 32,
                                                        width: 80,

                                                        /*  decoration: BoxDecoration(color: Color(0xffed1d1d),
                                                    borderRadius: BorderRadius.only(topRight:Radius.circular(8),
                                                    bottomRight: Radius.circular(8)),
                                                    boxShadow: [BoxShadow(
                                                        color: Colors.black.withOpacity(0.07),
                                                        spreadRadius:16,
                                                        blurRadius: 20,
                                                        offset: Offset(0, 7)
                                                    )],),
                                                  child: Center(
                                                    child: Text('0% Off',style:TextStyle(fontSize: 12,fontFamily: 'Montserrat',
                                                        letterSpacing: 1.15,
                                                        color: Colors.white,fontWeight: FontWeight.w700) ,),
                                                  ),*/
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 30.0),
                                                      child: Container(
                                                        height: 43,
                                                        width: 19,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          12),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          12)),
                                                        ),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      bottom:
                                                                          8.0),
                                                              child: SvgPicture
                                                                  .asset(
                                                                'images/svg/Stroke 1-4 1 .svg',
                                                                height: 13,
                                                                color:
                                                                    Colors.red,
                                                                fit: BoxFit
                                                                    .cover,
                                                                matchTextDirection:
                                                                    false,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                            bottom: 1,
                                            left: 0,
                                            right: 0,
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.all(3),
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.white,
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.07),
                                                            spreadRadius: 16,
                                                            blurRadius: 20,
                                                            offset:
                                                                Offset(0, 7))
                                                      ],
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          height: 45,
                                                          width: 45,
                                                          decoration: BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color:
                                                                  Colors.white,
                                                              image: DecorationImage(
                                                                  image: NetworkImage(
                                                                      '${fullMenu[index].logo}'))),

                                                          //child: Image.network('${fullMenu[index].logo}'),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 29,
                                                    width: 105,
                                                    decoration: BoxDecoration(
                                                      color: Color(0xffed1d1d),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  23)),
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: button_red
                                                                .withOpacity(
                                                                    0.1),
                                                            spreadRadius: 5,
                                                            blurRadius: 5,
                                                            offset:
                                                                Offset(0, 5))
                                                      ],
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        '${fullMenu[index].deliverytime} mins',
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontFamily:
                                                                'Montserrat',
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 12.0, left: 18, right: 18),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 4.0),
                                              child: Container(
                                                width: (MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        3 /
                                                        4) -
                                                    35,
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        '${fullMenu[index].name}',
                                                        style: TextStyle(
                                                            fontSize: 19,
                                                            fontFamily:
                                                                'Montserrat',
                                                            color: ThemeProvider.of(
                                                                            context)
                                                                        .brightness ==
                                                                    Brightness
                                                                        .light
                                                                ? head
                                                                : Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 4.0),
                                              child: Text(
                                                '\$0 Delivery',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontFamily: 'Montserrat',
                                                    color: ThemeProvider.of(
                                                                    context)
                                                                .brightness ==
                                                            Brightness.light
                                                        ? head
                                                        : Colors.white,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            )
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 14.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 4.0),
                                                child: Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'images/svg/star_20210401_174429079.svg',
                                                      height: 16,
                                                      fit: BoxFit.cover,
                                                      matchTextDirection: false,
                                                    ),
                                                    SizedBox(
                                                      width: 8,
                                                    ),
                                                    Text(
                                                      '${fullMenu[index].reviews}',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontFamily:
                                                              'Montserrat',
                                                          color: ThemeProvider.of(
                                                                          context)
                                                                      .brightness ==
                                                                  Brightness
                                                                      .light
                                                              ? head
                                                              : Colors.white,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    SizedBox(
                                                      width: 18,
                                                    ),
                                                    fullMenu[index].isOpen == 1
                                                        ? Text(
                                                            'Open',
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                fontFamily:
                                                                    'Montserrat',
                                                                color: ThemeProvider.of(context)
                                                                            .brightness ==
                                                                        Brightness
                                                                            .light
                                                                    ? button_green
                                                                    : Colors
                                                                        .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          )
                                                        : Text(
                                                            'Closed',
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                fontFamily:
                                                                    'Montserrat',
                                                                color: ThemeProvider.of(context)
                                                                            .brightness ==
                                                                        Brightness
                                                                            .light
                                                                    ? Color(
                                                                        0xffed1d1d)
                                                                    : Colors
                                                                        .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 4.0),
                                                child: Text(
                                                  'Modelin(10 Mi)',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontFamily: 'Montserrat',
                                                      color: ThemeProvider.of(
                                                                      context)
                                                                  .brightness ==
                                                              Brightness.light
                                                          ? head
                                                              .withOpacity(0.4)
                                                          : Colors.white
                                                              .withOpacity(0.4),
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 20),
                                            child: Divider(
                                              height: 0.5,
                                            ))
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Container();
                  })
            ],
          ),
        ),
      ),
    );
  }

  void changePage() {
    print(currentPage);
    if (currentPage == 4) {
      //  Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
    } else {
      _pageController.animateToPage(currentPage + 1,
          duration: Duration(milliseconds: 200), curve: Curves.linear);
    }
  }

  setCurrentPage(int value) {
    currentPage = value;
    setState(() {});
  }

  addtoList() {
    carosel.add(Container(
      width: 386,
      height: 182,
      margin: EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        image: DecorationImage(
            image: AssetImage(
              'images/Background.png',
            ),
            fit: BoxFit.cover),
      ),
      child: Container(
        width: 386,
        height: 182,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xffff2f17).withOpacity(0.9),
            Color(0xffff2f17).withOpacity(0),
          ], stops: [
            0,
            .6
          ], begin: Alignment.centerLeft, end: Alignment.centerRight),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 40,
                height: 30,
                child: SvgPicture.asset(
                  'images/svg/_Compound Path_.svg',
                  color: Colors.white,
                  matchTextDirection: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Text(
                  'NEW YEAR OFFER',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Montserrat',
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  '20% OFF',
                  style: TextStyle(
                      fontSize: 17,
                      fontFamily: 'Montserrat',
                      color: Colors.white,
                      letterSpacing: 1.21,
                      fontWeight: FontWeight.w700),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Explore',
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Montserrat',
                              color: Colors.white,
                              letterSpacing: 1.15,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.white,
                          size: 14,
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      width: 60,
                      child: Divider(
                        color: Colors.white,
                        height: 1,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
    carosel.add(Container(
      width: 386,
      height: 182,
      margin: EdgeInsets.only(left: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        image: DecorationImage(
            image: AssetImage(
              'images/Background.png',
            ),
            fit: BoxFit.cover),
      ),
      child: Container(
        width: 386,
        height: 182,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xffff2f17).withOpacity(0.9),
            Color(0xffff2f17).withOpacity(0),
          ], stops: [
            0,
            .6
          ], begin: Alignment.centerLeft, end: Alignment.centerRight),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 40,
                height: 30,
                child: SvgPicture.asset(
                  'images/svg/_Compound Path_.svg',
                  color: Colors.white,
                  matchTextDirection: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Text(
                  'NEW YEAR OFFER',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Montserrat',
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  '20% OFF',
                  style: TextStyle(
                      fontSize: 17,
                      fontFamily: 'Montserrat',
                      color: Colors.white,
                      letterSpacing: 1.21,
                      fontWeight: FontWeight.w700),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Explore',
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Montserrat',
                              color: Colors.white,
                              letterSpacing: 1.15,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.white,
                          size: 14,
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      width: 60,
                      child: Divider(
                        color: Colors.white,
                        height: 1,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
    carosel.add(Container(
      width: 386,
      height: 182,
      margin: EdgeInsets.only(left: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        image: DecorationImage(
            image: AssetImage(
              'images/Background.png',
            ),
            fit: BoxFit.cover),
      ),
      child: Container(
        width: 386,
        height: 182,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xffff2f17).withOpacity(0.9),
            Color(0xffff2f17).withOpacity(0),
          ], stops: [
            0,
            .6
          ], begin: Alignment.centerLeft, end: Alignment.centerRight),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 40,
                height: 30,
                child: SvgPicture.asset(
                  'images/svg/_Compound Path_.svg',
                  color: Colors.white,
                  matchTextDirection: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Text(
                  'NEW YEAR OFFER',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Montserrat',
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  '20% OFF',
                  style: TextStyle(
                      fontSize: 17,
                      fontFamily: 'Montserrat',
                      color: Colors.white,
                      letterSpacing: 1.21,
                      fontWeight: FontWeight.w700),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Explore',
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Montserrat',
                              color: Colors.white,
                              letterSpacing: 1.15,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.white,
                          size: 14,
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      width: 60,
                      child: Divider(
                        color: Colors.white,
                        height: 1,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
    carosel.add(Container(
      width: 386,
      height: 182,
      margin: EdgeInsets.only(left: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        image: DecorationImage(
            image: AssetImage(
              'images/Background.png',
            ),
            fit: BoxFit.cover),
      ),
      child: Container(
        width: 386,
        height: 182,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xffff2f17).withOpacity(0.9),
            Color(0xffff2f17).withOpacity(0),
          ], stops: [
            0,
            .6
          ], begin: Alignment.centerLeft, end: Alignment.centerRight),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 40,
                height: 30,
                child: SvgPicture.asset(
                  'images/svg/_Compound Path_.svg',
                  color: Colors.white,
                  matchTextDirection: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Text(
                  'NEW YEAR OFFER',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Montserrat',
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  '20% OFF',
                  style: TextStyle(
                      fontSize: 17,
                      fontFamily: 'Montserrat',
                      color: Colors.white,
                      letterSpacing: 1.21,
                      fontWeight: FontWeight.w700),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Explore',
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Montserrat',
                              color: Colors.white,
                              letterSpacing: 1.15,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.white,
                          size: 14,
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      width: 60,
                      child: Divider(
                        color: Colors.white,
                        height: 1,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));

    iList.add(Categorylist(image: 'images/svg/hamburger.svg', name: 'Pizza'));
    iList.add(Categorylist(image: 'images/svg/hot dog.svg', name: 'Burgers'));
    iList.add(Categorylist(image: 'images/svg/noodle.svg', name: 'Tacos'));
    iList.add(
        Categorylist(image: 'images/svg/pizza slice.svg', name: 'Beverages'));

    iList.add(Categorylist(image: 'images/svg/hamburger.svg', name: 'Pizza'));
    iList.add(Categorylist(image: 'images/svg/hot dog.svg', name: 'Burgers'));
    iList.add(Categorylist(image: 'images/svg/noodle.svg', name: 'Tacos'));
    iList.add(
        Categorylist(image: 'images/svg/pizza slice.svg', name: 'Beverages'));

    tList.add(topickslist(
        image: 'images/bon-vivant-qom5MPOER-I-unsplash 1 .png',
        name: "Sam's Chinese"));
    tList.add(topickslist(
        image: 'images/jordan-nix-61wG5-SAF Y-unsplash 1 .png',
        name: "Taco Bell"));
    tList.add(topickslist(
        image: 'images/tai-s-captures-JiRSy0GfqPA-unsplash 2 .png',
        name: "Mexican"));
    tList.add(topickslist(
        image: 'images/lior-shapira-GKxsKNTfZd8-unsplash 1 .png',
        name: "Indian"));
    tList.add(topickslist(
        image: 'images/bon-vivant-qom5MPOER-I-unsplash 1 .png',
        name: "Sam's Chinese"));
    tList.add(topickslist(
        image: 'images/jordan-nix-61wG5-SAF Y-unsplash 1 .png',
        name: "Taco Bell"));
    tList.add(topickslist(
        image: 'images/tai-s-captures-JiRSy0GfqPA-unsplash 2 .png',
        name: "Mexican"));
    tList.add(topickslist(
        image: 'images/lior-shapira-GKxsKNTfZd8-unsplash 1 .png',
        name: "Indian"));
    tList.add(topickslist(
        image: 'images/bon-vivant-qom5MPOER-I-unsplash 1 .png',
        name: "Sam's Chinese"));
    tList.add(topickslist(
        image: 'images/jordan-nix-61wG5-SAF Y-unsplash 1 .png',
        name: "Taco Bell"));
    tList.add(topickslist(
        image: 'images/tai-s-captures-JiRSy0GfqPA-unsplash 2 .png',
        name: "Mexican"));
    tList.add(topickslist(
        image: 'images/lior-shapira-GKxsKNTfZd8-unsplash 1 .png',
        name: "Indian"));
    tList.add(topickslist(
        image: 'images/bon-vivant-qom5MPOER-I-unsplash 1 .png',
        name: "Sam's Chinese"));
    tList.add(topickslist(
        image: 'images/jordan-nix-61wG5-SAF Y-unsplash 1 .png',
        name: "Taco Bell"));
    tList.add(topickslist(
        image: 'images/tai-s-captures-JiRSy0GfqPA-unsplash 2 .png',
        name: "Mexican"));
    tList.add(topickslist(
        image: 'images/lior-shapira-GKxsKNTfZd8-unsplash 1 .png',
        name: "Indian"));
    rList.add(restaurentlist(
        image: 'images/vitalii-chernopyskyi-Oxb84ENcFfU-unsplash-2 2 .png',
        name: "Pizza Hut (Outlet)"));
    rList.add(restaurentlist(
        image: 'images/Background (2).png', name: " Burger King"));
    rList.add(restaurentlist(
        image: 'images/vitalii-chernopyskyi-Oxb84ENcFfU-unsplash-2 2 .png',
        name: "Pizza Hut (Outlet)"));
    rList.add(restaurentlist(
        image: 'images/Background (2).png', name: " Burger King"));
  }

  var jssoonn = json.encode([
    {
      "restid": 102,
      "name": "Chow Thai Cuisine",
      "cuisinid": 8,
      "cuisine": "Thai",
      "address": "23034 Sandalfoot Plaza Dr",
      "city": "Boca Raton",
      "state": "FL",
      "distance": 8,
      "deliverytime": 0,
      "reviews": "4.9 (284)",
      "logo": null,
      "cover": null,
      "acceptorders": 0,
      "isOpen": 0
    },
    {
      "restid": 103,
      "name": "Nikuya Sushi Thai",
      "cuisinid": 8,
      "cuisine": "Thai",
      "address": "11395 W Palmetto Park Rd",
      "city": "Boca Raton",
      "state": "FL",
      "distance": 9,
      "deliverytime": 0,
      "reviews": "4.9 (284)",
      "logo": null,
      "cover": null,
      "acceptorders": 0,
      "isOpen": 0
    },
    {
      "restid": 104,
      "name": "Bluefin Sushi & Thai Grill",
      "cuisinid": 8,
      "cuisine": "Thai",
      "address": "861 W Yamato Rd Ste 1",
      "city": "Boca Raton",
      "state": "FL",
      "distance": 0,
      "deliverytime": 0,
      "reviews": "4.9 (284)",
      "logo": "https://www.placehold.it/300x300",
      "cover": "https://www.placehold.it/600x300",
      "acceptorders": 1,
      "isOpen": 0
    },
    {
      "restid": 105,
      "name": "Osha Authentic Thai And Sushi Bar",
      "cuisinid": 8,
      "cuisine": "Thai",
      "address": "2201 N Federal Hwy",
      "city": "Boca Raton",
      "state": "FL",
      "distance": 3,
      "deliverytime": 0,
      "reviews": "4.9 (284)",
      "logo": null,
      "cover": null,
      "acceptorders": 0,
      "isOpen": 0
    },
    {
      "restid": 106,
      "name": "M and M Thai Cafe",
      "cuisinid": 8,
      "cuisine": "Thai",
      "address": "891 E Palmetto Park Rd",
      "city": "Boca Raton",
      "state": "FL",
      "distance": 4,
      "deliverytime": 0,
      "reviews": "4.9 (284)",
      "logo": null,
      "cover": null,
      "acceptorders": 0,
      "isOpen": 0
    },
    {
      "restid": 107,
      "name": "Sushi Thai Restaurant",
      "cuisinid": 8,
      "cuisine": "Thai",
      "address": "100 Ne 2nd St",
      "city": "Boca Raton",
      "state": "FL",
      "distance": 3,
      "deliverytime": 0,
      "reviews": "4.9 (284)",
      "logo": null,
      "cover": null,
      "acceptorders": 0,
      "isOpen": 0
    },
    {
      "restid": 131,
      "name": "Sushi Yoshee Korean Japanese Restaurant",
      "cuisinid": 5,
      "cuisine": "Japanese",
      "address": "23261 State Road 7",
      "city": "Boca Raton",
      "state": "FL",
      "distance": 8,
      "deliverytime": 0,
      "reviews": "4.9 (284)",
      "logo": null,
      "cover": null,
      "acceptorders": 0,
      "isOpen": 0
    },
    {
      "restid": 132,
      "name": "Sushi Masa Japanese Restaurant",
      "cuisinid": 5,
      "cuisine": "Japanese",
      "address": "2240 Nw 19th St Ste 1201",
      "city": "Boca Raton",
      "state": "FL",
      "distance": 3,
      "deliverytime": 0,
      "reviews": "4.9 (284)",
      "logo": null,
      "cover": null,
      "acceptorders": 0,
      "isOpen": 0
    },
    {
      "restid": 133,
      "name": "Sushi Yama Japanese Restaurant",
      "cuisinid": 5,
      "cuisine": "Japanese",
      "address": "7050 W Palmetto Park Rd Ste 33",
      "city": "Boca Raton",
      "state": "FL",
      "distance": 5,
      "deliverytime": 0,
      "reviews": "4.9 (284)",
      "logo": null,
      "cover": null,
      "acceptorders": 0,
      "isOpen": 0
    },
    {
      "restid": 134,
      "name": "Saitos Japanese Steakhouse",
      "cuisinid": 5,
      "cuisine": "Japanese",
      "address": "8841 Glades Rd",
      "city": "Boca Raton",
      "state": "FL",
      "distance": 6,
      "deliverytime": 0,
      "reviews": "4.9 (284)",
      "logo": null,
      "cover": null,
      "acceptorders": 0,
      "isOpen": 0
    },
    {
      "restid": 135,
      "name": "Sushi Ray Japanese Restaurant",
      "cuisinid": 5,
      "cuisine": "Japanese",
      "address": "5250 Town Center Cir Ste 111",
      "city": "Boca Raton",
      "state": "FL",
      "distance": 3,
      "deliverytime": 0,
      "reviews": "4.9 (284)",
      "logo": null,
      "cover": null,
      "acceptorders": 0,
      "isOpen": 0
    },
    {
      "restid": 136,
      "name": "Kimura Japanese Steak & Seafood",
      "cuisinid": 5,
      "cuisine": "Japanese",
      "address": "545 N Congress Ave",
      "city": "Boynton Beach",
      "state": "FL",
      "distance": 9,
      "deliverytime": 0,
      "reviews": "4.9 (284)",
      "logo": null,
      "cover": null,
      "acceptorders": 0,
      "isOpen": 0
    },
    {
      "restid": 137,
      "name": "Yami Korean Japanese Grill",
      "cuisinid": 5,
      "cuisine": "Japanese",
      "address": "870 N Congress Ave Ste 100",
      "city": "Boynton Beach",
      "state": "FL",
      "distance": 9,
      "deliverytime": 0,
      "reviews": "4.9 (284)",
      "logo": null,
      "cover": null,
      "acceptorders": 0,
      "isOpen": 0
    }
  ]);
}

class Categorylist {
  final String image;
  final String name;

  Categorylist({
    this.image,
    this.name,
  });

  Categorylist.fromMap(Map map)
      : this(
          image: map['userName'],
          name: map['email'],
        );
}

class topickslist {
  final String image;
  final String name;

  topickslist({
    this.image,
    this.name,
  });

  topickslist.fromMap(Map map)
      : this(
          image: map['userName'],
          name: map['email'],
        );
}

class restaurentlist {
  final String image;
  final String name;

  restaurentlist({
    this.image,
    this.name,
  });

  restaurentlist.fromMap(Map map)
      : this(
          image: map['userName'],
          name: map['email'],
        );
}

class CustomPageView extends StatefulWidget {
  CustomPageView({
    Key key,
    this.scrollDirection = Axis.horizontal,
    this.reverse = false,
    PageController controller,
    this.physics,
    this.pageSnapping = true,
    this.onPageChanged,
    List<Widget> children = const <Widget>[],
    this.dragStartBehavior = DragStartBehavior.start,
    this.allowImplicitScrolling = false,
    this.restorationId,
    @required this.viewportDirection,
  })  : assert(allowImplicitScrolling != null),
        controller = controller ?? _defaultPageController,
        childrenDelegate = SliverChildListDelegate(children),
        super(key: key);

  CustomPageView.builder({
    Key key,
    this.scrollDirection = Axis.horizontal,
    this.reverse = false,
    PageController controller,
    this.physics,
    this.pageSnapping = true,
    this.onPageChanged,
    @required IndexedWidgetBuilder itemBuilder,
    int itemCount,
    this.dragStartBehavior = DragStartBehavior.start,
    this.allowImplicitScrolling = false,
    this.restorationId,
    @required this.viewportDirection,
  })  : assert(allowImplicitScrolling != null),
        controller = controller ?? _defaultPageController,
        childrenDelegate =
            SliverChildBuilderDelegate(itemBuilder, childCount: itemCount),
        super(key: key);

  CustomPageView.custom({
    Key key,
    this.scrollDirection = Axis.horizontal,
    this.reverse = false,
    PageController controller,
    this.physics,
    this.pageSnapping = true,
    this.onPageChanged,
    @required this.childrenDelegate,
    this.dragStartBehavior = DragStartBehavior.start,
    this.allowImplicitScrolling = false,
    this.restorationId,
    @required this.viewportDirection,
  })  : assert(childrenDelegate != null),
        assert(allowImplicitScrolling != null),
        controller = controller ?? _defaultPageController,
        super(key: key);

  final bool allowImplicitScrolling;

  final String restorationId;
  final Axis scrollDirection;

  final bool reverse;
  final viewportDirection;

  final PageController controller;
  final ScrollPhysics physics;

  final bool pageSnapping;
  final ValueChanged<int> onPageChanged;

  final SliverChildDelegate childrenDelegate;

  /// {@macro flutter.widgets.scrollable.dragStartBehavior}
  final DragStartBehavior dragStartBehavior;

  @override
  _CustomPageViewState createState() => _CustomPageViewState();
}

class _CustomPageViewState extends State<CustomPageView> {
  int _lastReportedPage = 0;

  @override
  void initState() {
    super.initState();
    _lastReportedPage = widget.controller.initialPage;
  }

  AxisDirection _getDirection(BuildContext context) {
    switch (widget.scrollDirection) {
      case Axis.horizontal:
        assert(debugCheckHasDirectionality(context));
        final TextDirection textDirection = Directionality.of(context);
        final AxisDirection axisDirection =
            textDirectionToAxisDirection(textDirection);
        return widget.reverse
            ? flipAxisDirection(axisDirection)
            : axisDirection;
      case Axis.vertical:
        return widget.reverse ? AxisDirection.up : AxisDirection.down;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final AxisDirection axisDirection = _getDirection(context);
    final ScrollPhysics physics = _ForceImplicitScrollPhysics(
      allowImplicitScrolling: widget.allowImplicitScrolling,
    ).applyTo(widget.pageSnapping
        ? _kPagePhysics.applyTo(widget.physics)
        : widget.physics);

    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        if (notification.depth == 0 &&
            widget.onPageChanged != null &&
            notification is ScrollUpdateNotification) {
          final PageMetrics metrics = notification.metrics as PageMetrics;
          final int currentPage = metrics.page.round();
          if (currentPage != _lastReportedPage) {
            _lastReportedPage = currentPage;
            widget.onPageChanged(currentPage);
          }
        }
        return false;
      },
      child: Scrollable(
        dragStartBehavior: widget.dragStartBehavior,
        axisDirection: axisDirection,
        controller: widget.controller,
        physics: physics,
        restorationId: widget.restorationId,
        viewportBuilder: (BuildContext context, ViewportOffset position) {
          return Viewport(
            cacheExtent: widget.allowImplicitScrolling ? 1.0 : 0.0,
            cacheExtentStyle: CacheExtentStyle.viewport,
            axisDirection: axisDirection,
            offset: position,
            slivers: <Widget>[
              SliverFillViewport(
                viewportFraction: widget.controller.viewportFraction,
                delegate: widget.childrenDelegate,
                padEnds: widget.viewportDirection,
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder description) {
    super.debugFillProperties(description);
    description
        .add(EnumProperty<Axis>('scrollDirection', widget.scrollDirection));
    description.add(
        FlagProperty('reverse', value: widget.reverse, ifTrue: 'reversed'));
    description.add(DiagnosticsProperty<PageController>(
        'controller', widget.controller,
        showName: false));
    description.add(DiagnosticsProperty<ScrollPhysics>(
        'physics', widget.physics,
        showName: false));
    description.add(FlagProperty('pageSnapping',
        value: widget.pageSnapping, ifFalse: 'snapping disabled'));
    description.add(FlagProperty('allowImplicitScrolling',
        value: widget.allowImplicitScrolling,
        ifTrue: 'allow implicit scrolling'));
  }
}

final PageController _defaultPageController = PageController();
const PageScrollPhysics _kPagePhysics = PageScrollPhysics();

class _ForceImplicitScrollPhysics extends ScrollPhysics {
  const _ForceImplicitScrollPhysics({
    @required this.allowImplicitScrolling,
    ScrollPhysics parent,
  })  : assert(allowImplicitScrolling != null),
        super(parent: parent);

  @override
  _ForceImplicitScrollPhysics applyTo(ScrollPhysics ancestor) {
    return _ForceImplicitScrollPhysics(
      allowImplicitScrolling: allowImplicitScrolling,
      parent: buildParent(ancestor),
    );
  }

  @override
  final bool allowImplicitScrolling;
}

class restaurantMenu {
  int restid;
  String name;
  int cuisinid;
  String cuisine;
  String address;
  String city;
  String state;
  int distance;
  int deliverytime;
  String reviews;
  String logo;
  String cover;
  int acceptorders;
  int isOpen;

  restaurantMenu(
      this.restid,
      this.name,
      this.cuisinid,
      this.cuisine,
      this.address,
      this.city,
      this.state,
      this.distance,
      this.deliverytime,
      this.reviews,
      this.logo,
      this.cover,
      this.acceptorders,
      this.isOpen);
}
