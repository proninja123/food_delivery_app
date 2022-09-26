import 'dart:convert';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:food_delivery/utils/app_colors.dart';
import 'package:food_delivery/views/home_ui/user_cart_module/user_cart_page.dart';
import 'package:food_delivery/views/home_ui/customize_menu_module/CustomizeFood.dart';
import 'package:food_delivery/views/home_ui/seller_menu_information_module/seller_menu_Information.dart';
import 'package:food_delivery/views/home_ui/seller_table_booking_module/seller_reserved_table_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../bottom_bar_ui/bottom_bar.dart';
import '../seller_review_module/seller_review_page.dart';

class RestuarentPage extends StatefulWidget {
  @override
  _RestuarentPageState createState() => _RestuarentPageState();
}

class _RestuarentPageState extends State<RestuarentPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  FocusNode _focusNode = FocusNode();
  int _activeTabIndex = 0;
  final List<CartList> add_cart = new List();

  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(_setActiveTabIndex);

    getDishMenu();
    getDatas();
  }

  String Rname;
  String Rreview;
  String Rlogo;
  String Rcover;
  int Risopen;
  int Rdelivery;
  bool show_cart = false;
  int item_Count = 0;
  double item_Total = 0.0;

  getDatas() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      show_cart = prefs.getBool('show_cart');
      Rname = prefs.getString('Rname');
      Rreview = prefs.getString('Rreview');
      Rlogo = prefs.getString('Rlogo');
      Rcover = prefs.getString('Rcover');
      Risopen = prefs.getInt('Risopen');
      Rdelivery = prefs.getInt('Rdelivery');
      item_Total = prefs.getDouble('item_total');
      item_Count = prefs.getInt('item_count');
      has_added = prefs.getString('clist');
    });
  }

  double d_height = 200;
  double c_height = 200;

  void _setActiveTabIndex() {
    setState(() {
      _activeTabIndex = _tabController.index;
      if (_tabController.index == 0) {
        setState(() {
          c_height = d_height * fullMenu.length;
        });
      } else if (_tabController.index == 1) {
        setState(() {
          c_height = 1300;
        });
      } else if (_tabController.index == 2) {
        setState(() {
          c_height = 1120;
        });
      } else if (_tabController.index == 3) {
        setState(() {
          c_height = 800;
        });
      }
    });
  }

  double list_length = 5;

  List<dishmenu> fullMenu = new List<dishmenu>();
  List<dishmenu> searchmenu = new List<dishmenu>();
  String has_added = " ";

  Future<String> getDishMenu() async {
    var url = 'https://www.comiida.com/appapi/restaurant/getmenu/104';

    var response = await http.get(Uri.parse(url));
    // print(response.body);
    print(response.body.toString());

    Map<String, dynamic> convertData = json.decode(response.body);
    for (var menu in convertData.keys) {
      for (var count in convertData[menu]["Menu"].keys) {
        var tempRestaurantMenu = new dishmenu(
          convertData[menu]["Menu"][count]['ItemID'],
          convertData[menu]["Menu"][count]['Name'],
          convertData[menu]["Menu"][count]['Price'],
          convertData[menu]["Menu"][count]['Image'],
          convertData[menu]["Menu"][count]['Modifier'],
        );
        setState(() {
          fullMenu.add(tempRestaurantMenu);
        });
      }
    }

    print(fullMenu[0].Name);
    print(fullMenu[1].Name);
    print(fullMenu.length);
    setState(() {
      searchmenu = List.from(fullMenu);
      c_height = c_height * fullMenu.length;
    });
  }

  onSearchTextChanged(String text) async {
    searchmenu.clear();
    if (text.isEmpty) {
      setState(() {
        searchmenu = List.from(fullMenu);
      });
      return;
    } else {
      setState(() {
        fullMenu.forEach((dishDetail) {
          if (dishDetail.Name.toLowerCase().contains(text.toLowerCase()))
            searchmenu.add(dishDetail);
        });
      });
    }
  }

  TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeProvider.of(context).brightness == Brightness.light
          ? Colors.white
          : Color(0xff222C44),
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 320,
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Container(
                                height: 220,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(24),
                                      bottomLeft: Radius.circular(24),
                                    ),
                                    image: DecorationImage(
                                        image: NetworkImage('$Rcover'),
                                        fit: BoxFit.cover)),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, top: 38),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.of(context)
                                              .pushAndRemoveUntil(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          BottomBar()),
                                                  (Route<dynamic> route) =>
                                                      false);
                                        },
                                        child: Icon(
                                          Icons.arrow_back,
                                          color: Colors.white,
                                          size: 34,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                              bottom: 10,
                              left: 0,
                              right: 0,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, right: 25),
                                child: Container(
                                  //margin: EdgeInsets.symmetric(horizontal: 25),
                                  height: 147,

                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color:
                                        ThemeProvider.of(context).brightness ==
                                                Brightness.light
                                            ? Colors.white
                                            : Color(0xff131824),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: ThemeProvider.of(context)
                                                      .brightness ==
                                                  Brightness.light
                                              ? Colors.red.withOpacity(0.07)
                                              : Color(0xff222C44)
                                                  .withOpacity(0.07),
                                          spreadRadius: 16,
                                          blurRadius: 20,
                                          offset: Offset(0, 7))
                                    ],
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 16.0, left: 18),
                                            child: Container(
                                              height: 65,
                                              width: 70,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.white,
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          '$Rlogo'))),

                                              //child: Image.network('${fullMenu[index].logo}'),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 12),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: 200,
                                                  child: Text(
                                                    '$Rname',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontFamily:
                                                            'Montserrat',
                                                        letterSpacing: 1.1,
                                                        color: ThemeProvider.of(
                                                                        context)
                                                                    .brightness ==
                                                                Brightness.light
                                                            ? head
                                                            : Colors.white,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      '$Rreview',
                                                      style: TextStyle(
                                                          fontSize: 11,
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
                                                              FontWeight.w400),
                                                    ),
                                                    SizedBox(
                                                      width: 6,
                                                    ),
                                                    Row(
                                                      children: [
                                                        SvgPicture.asset(
                                                          'images/svg/star_20210401_174429079.svg',
                                                          height: 10,
                                                          fit: BoxFit.cover,
                                                          matchTextDirection:
                                                              false,
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        SvgPicture.asset(
                                                          'images/svg/star_20210401_174429079.svg',
                                                          height: 10,
                                                          fit: BoxFit.cover,
                                                          matchTextDirection:
                                                              false,
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        SvgPicture.asset(
                                                          'images/svg/star_20210401_174429079.svg',
                                                          height: 10,
                                                          fit: BoxFit.cover,
                                                          matchTextDirection:
                                                              false,
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        SvgPicture.asset(
                                                          'images/svg/star_20210401_174429079.svg',
                                                          height: 10,
                                                          fit: BoxFit.cover,
                                                          matchTextDirection:
                                                              false,
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        SvgPicture.asset(
                                                          'images/svg/star_20210401_174429079.svg',
                                                          height: 10,
                                                          fit: BoxFit.cover,
                                                          matchTextDirection:
                                                              false,
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                      ],
                                                    ),
                                                    /* SizedBox(width: 6,),
                                              Text('(120)',style: TextStyle(fontSize: 11,fontFamily: 'Montserrat',
                                                  color:ThemeProvider.of(context).brightness ==
                                                      Brightness.light
                                                      ? head.withOpacity(0.39):Colors.white.withOpacity(0.39),fontWeight: FontWeight.w400),),*/
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 6,
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 12,
                                                              vertical: 3),
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Color(0xffEEEEEE),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          6))),
                                                      child: Center(
                                                        child: Text(
                                                          'Pizza',
                                                          style: TextStyle(
                                                              fontSize: 11,
                                                              fontFamily:
                                                                  'Montserrat',
                                                              color: head,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 12,
                                                              vertical: 3),
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Color(0xffEEEEEE),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          6))),
                                                      child: Center(
                                                        child: Text(
                                                          'Pasta',
                                                          style: TextStyle(
                                                              fontSize: 11,
                                                              fontFamily:
                                                                  'Montserrat',
                                                              color: head,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 12,
                                                              vertical: 3),
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Color(0xffEEEEEE),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          6))),
                                                      child: Center(
                                                        child: Text(
                                                          'Salad',
                                                          style: TextStyle(
                                                              fontSize: 11,
                                                              fontFamily:
                                                                  'Montserrat',
                                                              color: head,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  'No live tracking available',
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      fontFamily: 'Montserrat',
                                                      letterSpacing: 0.12,
                                                      color: button_red,
                                                      fontWeight:
                                                          FontWeight.w100),
                                                ),
                                                SizedBox(
                                                  height: 12,
                                                ),
                                                Row(
                                                  children: [
                                                    Risopen == 1
                                                        ? Row(
                                                            children: [
                                                              Container(
                                                                height: 11,
                                                                width: 11,
                                                                decoration: BoxDecoration(
                                                                    color: Color(
                                                                        0xff30B900),
                                                                    shape: BoxShape
                                                                        .circle),
                                                              ),
                                                              SizedBox(
                                                                width: 4,
                                                              ),
                                                              Text(
                                                                'Open',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontFamily:
                                                                        'Montserrat',
                                                                    color: ThemeProvider.of(context).brightness ==
                                                                            Brightness
                                                                                .light
                                                                        ? head.withOpacity(
                                                                            0.25)
                                                                        : Colors
                                                                            .white
                                                                            .withOpacity(
                                                                                0.25),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                              ),
                                                            ],
                                                          )
                                                        : Row(
                                                            children: [
                                                              Container(
                                                                height: 11,
                                                                width: 11,
                                                                decoration: BoxDecoration(
                                                                    color:
                                                                        button_red,
                                                                    shape: BoxShape
                                                                        .circle),
                                                              ),
                                                              SizedBox(
                                                                width: 4,
                                                              ),
                                                              Text(
                                                                'Closed',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontFamily:
                                                                        'Montserrat',
                                                                    color: ThemeProvider.of(context).brightness ==
                                                                            Brightness
                                                                                .light
                                                                        ? head.withOpacity(
                                                                            0.25)
                                                                        : Colors
                                                                            .white
                                                                            .withOpacity(
                                                                                0.25),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                              ),
                                                            ],
                                                          ),
                                                    SizedBox(
                                                      width: 25,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Image.asset(
                                                          'images/Component 4 – 1.png',
                                                          height: 11,
                                                        ),
                                                        SizedBox(
                                                          width: 4,
                                                        ),
                                                        Text(
                                                          '${Rdelivery} minutes',
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
                                                                      .withOpacity(
                                                                          0.25)
                                                                  : Colors.white
                                                                      .withOpacity(
                                                                          0.25),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 18.0),
                                        child: Container(
                                          height: 43,
                                          width: 19,
                                          decoration: BoxDecoration(
                                            color: Color(0xffE5E5E5),
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(12),
                                                bottomRight:
                                                    Radius.circular(12)),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 8.0),
                                                child: SvgPicture.asset(
                                                  'images/svg/Stroke 1-4 1 .svg',
                                                  height: 13,
                                                  color: head,
                                                  fit: BoxFit.cover,
                                                  matchTextDirection: false,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30)),
                          color: ThemeProvider.of(context).brightness ==
                                  Brightness.light
                              ? Colors.white
                              : Color(0xff131824)),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 18.0),
                            child: TabBar(
                              indicatorSize: TabBarIndicatorSize.tab,

                              controller: _tabController,

                              isScrollable: true,
                              unselectedLabelColor:
                                  ThemeProvider.of(context).brightness ==
                                          Brightness.light
                                      ? head
                                      : Colors.white,
                              indicatorWeight: 1,
                              indicator: BubbleTabIndicator(
                                  indicatorHeight: 25,
                                  indicatorColor: Color(0xffFFA1A1),
                                  tabBarIndicatorSize: TabBarIndicatorSize.tab,
                                  indicatorRadius: 12),
                              indicatorColor: Colors.transparent,
                              labelStyle: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'Montserrat',
                                  color: head,
                                  fontWeight: FontWeight.w400,
                                  height: 1),
                              //labelStyle: TextStyle(color: Colors.red),
                              unselectedLabelStyle: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'Montserrat',
                                  color: button_red,
                                  fontWeight: FontWeight.w400,
                                  height: 1),
                              labelColor: button_red,
                              tabs: [
                                _tabController.index == 0
                                    ? Tab(
                                        text: 'Order',
                                      )
                                    : Tab(
                                        text: 'Order',
                                      ),
                                _tabController.index == 1
                                    ? Tab(
                                        text: 'Reviews',
                                      )
                                    : Tab(
                                        text: 'Reviews',
                                      ),
                                _tabController.index == 2
                                    ? Tab(
                                        text: 'Information',
                                      )
                                    : Tab(
                                        text: 'Information',
                                      ),
                                _tabController.index == 3
                                    ? Tab(
                                        text: 'Reserve Table',
                                      )
                                    : Tab(
                                        text: 'Reserve Table',
                                      ),
                              ],
                            ),
                          ),
                          Container(
                            //_tabController.index==1?(list_length+2)*142:(list_length+2)*110,
                            height: c_height,
                            child: GestureDetector(
                              child: TabBarView(
                                  controller: _tabController,
                                  children: [
                                    Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20, right: 20, top: 0),
                                          child: Container(
                                              height: 47,
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 10),
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 10),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(24)),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: ThemeProvider.of(
                                                                        context)
                                                                    .brightness ==
                                                                Brightness.light
                                                            ? Colors.black
                                                                .withOpacity(
                                                                    0.05)
                                                            : Color(0xff222C44)
                                                                .withOpacity(
                                                                    0.05),
                                                        spreadRadius: 2,
                                                        blurRadius: 10,
                                                        offset: Offset(0, 7))
                                                  ],
                                                  color:
                                                      ThemeProvider.of(context)
                                                                  .brightness ==
                                                              Brightness.light
                                                          ? Colors.white
                                                          : Color(0xff222C44)),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 15.0,
                                                            bottom: 0),
                                                    child: Container(
                                                      width: 18,
                                                      height: 18,
                                                      margin: EdgeInsets.only(
                                                          right: 10),
                                                      child: Image.asset(
                                                        "images/Group 9.png",
                                                        color:
                                                            Color(0xffed1d1d),
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: TextField(
                                                      onChanged: (String txt) {
                                                        onSearchTextChanged(
                                                            txt);
                                                      },
                                                      controller:
                                                          _textController,
                                                      focusNode: _focusNode,
                                                      decoration: InputDecoration(
                                                          hintText:
                                                              "Search your cuisine",
                                                          hintStyle: TextStyle(
                                                              fontSize: 12,
                                                              fontFamily:
                                                                  'Montserrat',
                                                              color: ThemeProvider.of(
                                                                              context)
                                                                          .brightness ==
                                                                      Brightness
                                                                          .light
                                                                  ? head
                                                                      .withOpacity(
                                                                          0.5)
                                                                  : Colors.white
                                                                      .withOpacity(
                                                                          0.5),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              height: 1),
                                                          border:
                                                              InputBorder.none),
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
                                                              FontWeight.w500,
                                                          height: 1),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        ),
                                        searchmenu.length != 0
                                            ? Container(
                                                child: ListView.builder(
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  padding: EdgeInsets.all(0),
                                                  shrinkWrap: true,
                                                  itemCount: searchmenu.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 24.0,
                                                              left: 20,
                                                              right: 20),
                                                      child: Container(
                                                        height: 110,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            20)),
                                                            color: ThemeProvider.of(
                                                                            context)
                                                                        .brightness ==
                                                                    Brightness
                                                                        .light
                                                                ? Colors.white
                                                                : Color(
                                                                    0xff222C44),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                  color: ThemeProvider.of(context).brightness ==
                                                                          Brightness
                                                                              .light
                                                                      ? Colors
                                                                          .black
                                                                          .withOpacity(
                                                                              0.07)
                                                                      : Color(0xff222C44)
                                                                          .withOpacity(
                                                                              0.07),
                                                                  spreadRadius:
                                                                      0.1,
                                                                  blurRadius:
                                                                      0.1,
                                                                  offset:
                                                                      Offset(
                                                                          1, 2))
                                                            ]),
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      top: 13.0,
                                                                      bottom:
                                                                          13,
                                                                      left: 16),
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Row(
                                                                        children: [
                                                                          Container(
                                                                            height:
                                                                                14,
                                                                            width:
                                                                                14,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: Colors.white,
                                                                              border: Border.all(color: button_green),
                                                                            ),
                                                                            child:
                                                                                Column(
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              children: [
                                                                                Container(
                                                                                  height: 6,
                                                                                  width: 6,
                                                                                  decoration: BoxDecoration(shape: BoxShape.circle, color: button_green),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                8,
                                                                          ),
                                                                          Text(
                                                                            'Best Seller',
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 10,
                                                                              fontFamily: 'Montserrat',
                                                                              color: button_red,
                                                                              fontWeight: FontWeight.w700,
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets.only(
                                                                            top:
                                                                                3.0,
                                                                            bottom:
                                                                                3),
                                                                        child:
                                                                            Text(
                                                                          '${searchmenu[index].Name}',
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                12,
                                                                            fontFamily:
                                                                                'Montserrat',
                                                                            color: ThemeProvider.of(context).brightness == Brightness.light
                                                                                ? head
                                                                                : Colors.white,
                                                                            fontWeight:
                                                                                FontWeight.w700,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(bottom: 2.0),
                                                                        child:
                                                                            Text(
                                                                          '\$${searchmenu[index].Price}',
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                10,
                                                                            fontFamily:
                                                                                'Montserrat',
                                                                            color:
                                                                                button_green,
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        'A green wave that goes lorem ipsum\n dolor sit amet.',
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              9,
                                                                          fontFamily:
                                                                              'Montserrat',
                                                                          color: ThemeProvider.of(context).brightness == Brightness.light
                                                                              ? Color(0xff8F8F8F)
                                                                              : Colors.white.withOpacity(0.7),
                                                                          fontWeight:
                                                                              FontWeight.w400,
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      top: 13.0,
                                                                      right:
                                                                          12),
                                                                  child:
                                                                      Container(
                                                                    height: 68,
                                                                    width: 92,
                                                                    child:
                                                                        Stack(
                                                                      children: [
                                                                        Column(
                                                                          children: [
                                                                            Container(
                                                                              height: 56,
                                                                              width: 92,
                                                                              decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.all(Radius.circular(8)),
                                                                                  image: DecorationImage(
                                                                                      image: NetworkImage(
                                                                                        '${searchmenu[index].Image}',
                                                                                      ),
                                                                                      fit: BoxFit.cover)),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Positioned(
                                                                            left:
                                                                                0,
                                                                            right:
                                                                                0,
                                                                            bottom:
                                                                                2,
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                InkWell(
                                                                                  onTap: () async {
                                                                                    var cl;
                                                                                    List<CartList> pref_list = new List();

                                                                                    SharedPreferences prefs = await SharedPreferences.getInstance();
                                                                                    /*setState(() {

                                                                                  cl=prefs.getString('clist');
                                                                                  if(cl!=null && cl!=""){
                                                                                   setState(() {
                                                                                     pref_list= CartList.decode(cl);
                                                                                   });
                                                                                   if(cl.contains('${fullMenu[index].Name}')){
                                                                                     print('Already added');
                                                                                   }else{
                                                                                     pref_list.add(CartList(id: fullMenu[index].ItemID,name:'${fullMenu[index].Name}',price:
                                                                                     '${fullMenu[index].Price}',img: '${fullMenu[index].Image}', quantity:1 ),);
                                                                                     print(pref_list);
                                                                                   }
                                                                                  }else{
                                                                                    pref_list.add(CartList(id: fullMenu[index].ItemID,name:'${fullMenu[index].Name}',price:
                                                                                    '${fullMenu[index].Price}',img: '${fullMenu[index].Image}',
                                                                                        quantity:1 ),);
                                                                                   // print(pref_list);
                                                                                  }



                                                                                });
                                                                                final String encodedData = CartList.encode(pref_list);
                                                                               */ /* add_cart.add(CartList(id: 1,name:'${fullMenu[index].Name}',price:
                                                                                '${fullMenu[index].Price}',img: '${fullMenu[index].Image}'));
                                                                                print("MMMMMMMMMMMMMMMMMM$add_cart");*/ /*
                                                                                await prefs.setString('clist', '$encodedData');
                                                                                await prefs.setBool('show_cart', true);*/
                                                                                    await prefs.setString('Cname', '${searchmenu[index].Name}');
                                                                                    await prefs.setString('Cprice', '${searchmenu[index].Price}');
                                                                                    await prefs.setString('Clogo', '${searchmenu[index].Image}');
                                                                                    await prefs.setString('Cid', '${searchmenu[index].ItemID}');
                                                                                    setState(() {
                                                                                      BottomBar.show_track = true;
                                                                                    });
                                                                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => CustomizationPage()));
                                                                                  },
                                                                                  child: Container(
                                                                                    height: 27,
                                                                                    width: 77,
                                                                                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8)), color: ThemeProvider.of(context).brightness == Brightness.light ? Colors.white : head, boxShadow: [
                                                                                      BoxShadow(color: Colors.black.withOpacity(0.07), spreadRadius: 0.25, blurRadius: 0.25, offset: Offset(0, 3))
                                                                                    ]),
                                                                                    child: Padding(
                                                                                      padding: const EdgeInsets.only(left: 7.0, right: 7),
                                                                                      child: has_added == null
                                                                                          ? Row(
                                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                                              children: [
                                                                                                Text(
                                                                                                  'Add',
                                                                                                  style: TextStyle(
                                                                                                    fontSize: 13,
                                                                                                    fontFamily: 'Montserrat',
                                                                                                    color: ThemeProvider.of(context).brightness == Brightness.light ? head : Colors.white,
                                                                                                    fontWeight: FontWeight.w700,
                                                                                                  ),
                                                                                                ),
                                                                                              ],
                                                                                            )
                                                                                          : has_added.contains("${fullMenu[index].Name}")
                                                                                              ? Row(
                                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                                                                  children: [
                                                                                                    Text(
                                                                                                      '-',
                                                                                                      style: TextStyle(
                                                                                                        fontSize: 13,
                                                                                                        fontFamily: 'Montserrat',
                                                                                                        color: ThemeProvider.of(context).brightness == Brightness.light ? button_green : button_green,
                                                                                                        fontWeight: FontWeight.w700,
                                                                                                      ),
                                                                                                    ),
                                                                                                    Text(
                                                                                                      '1',
                                                                                                      style: TextStyle(
                                                                                                        fontSize: 13,
                                                                                                        fontFamily: 'Montserrat',
                                                                                                        color: ThemeProvider.of(context).brightness == Brightness.light ? button_green : button_green,
                                                                                                        fontWeight: FontWeight.w700,
                                                                                                      ),
                                                                                                    ),
                                                                                                    Text(
                                                                                                      '+',
                                                                                                      style: TextStyle(
                                                                                                        fontSize: 13,
                                                                                                        fontFamily: 'Montserrat',
                                                                                                        color: ThemeProvider.of(context).brightness == Brightness.light ? button_green : button_green,
                                                                                                        fontWeight: FontWeight.w700,
                                                                                                      ),
                                                                                                    )
                                                                                                  ],
                                                                                                )
                                                                                              : Row(
                                                                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                                  children: [
                                                                                                    Text(
                                                                                                      'Add',
                                                                                                      style: TextStyle(
                                                                                                        fontSize: 13,
                                                                                                        fontFamily: 'Montserrat',
                                                                                                        color: ThemeProvider.of(context).brightness == Brightness.light ? head : Colors.white,
                                                                                                        fontWeight: FontWeight.w700,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ))
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              )
                                            : Container(
                                                height: 50,
                                                child: Center(
                                                    child:
                                                        CircularProgressIndicator())),
                                      ],
                                    ),
                                    ReviewsPage(),
                                    InformationPage(),
                                    ReserveTable(),
                                  ]),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              (_tabController.index == 0) &&
                      MediaQuery.of(context).viewInsets.bottom == 0
                  ? Positioned(
                      right: 0.0,
                      bottom: 0,
                      left: 0,
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              showpop(context);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(bottom: 12),
                                  child: Container(
                                    height: 35,
                                    width: 128,
                                    // padding: EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                                    decoration: new BoxDecoration(
                                      color: button_red,
                                      borderRadius: new BorderRadius.all(
                                        Radius.circular(22),
                                      ),
                                    ),
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.0,
                                            bottom: 9,
                                            right: 6,
                                            left: 7),
                                        child: Text(
                                          'Browse Menu',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontFamily: 'Montserrat',
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          show_cart == true
                              ? InkWell(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                CartPage()));
                                  },
                                  child: Container(
                                    height: 60,
                                    margin: EdgeInsets.only(
                                        left: 24,
                                        right: 24,
                                        top: 10,
                                        bottom: 21),
                                    //padding: EdgeInsets.symmetric(horizontal: 18, vertical: 15),
                                    decoration: new BoxDecoration(
                                      color: button_green,
                                      boxShadow: [
                                        BoxShadow(
                                            color: ThemeProvider.of(context)
                                                        .brightness ==
                                                    Brightness.light
                                                ? button_green.withOpacity(0.3)
                                                : button_green.withOpacity(0.4),
                                            spreadRadius: 5,
                                            blurRadius: 15,
                                            offset: Offset(0, 7))
                                      ],
                                      borderRadius: new BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 14.0, left: 15, bottom: 16),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                '$item_Count Item  |  \$$item_Total',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white,
                                                    fontFamily: 'Montserrat',
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                              SizedBox(
                                                height: 1,
                                              ),
                                              Text(
                                                'Extra charges may apply',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 8,
                                                  fontFamily: 'Montserrat',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 18.0, right: 16, bottom: 20),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                'VIEW CART',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontFamily: 'Montserrat',
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              SvgPicture.asset(
                                                'images/svg/Fill 1-2 1 .svg',
                                                height: 18,
                                                fit: BoxFit.cover,
                                                color: Colors.white,
                                                matchTextDirection: false,
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              : Container(
                                  height: 60,
                                  margin: EdgeInsets.only(
                                      left: 24, right: 24, top: 10, bottom: 21),
                                  //padding: EdgeInsets.symmetric(horizontal: 18, vertical: 15),
                                  decoration: new BoxDecoration(
                                    color: Color(0xff8F8F8F),
                                    boxShadow: [
                                      BoxShadow(
                                          color: ThemeProvider.of(context)
                                                      .brightness ==
                                                  Brightness.light
                                              ? Color(0xffA2A2A2B8)
                                                  .withOpacity(0.3)
                                              : button_green.withOpacity(0.4),
                                          spreadRadius: 5,
                                          blurRadius: 15,
                                          offset: Offset(0, 7))
                                    ],
                                    borderRadius: new BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 14.0, left: 15, bottom: 16),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              '0 Item  |  ......',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            SizedBox(
                                              height: 1,
                                            ),
                                            Text(
                                              'Extra charges may apply',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 8,
                                                fontFamily: 'Montserrat',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 18.0, right: 16, bottom: 20),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'NOT AVAILABLE',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            SvgPicture.asset(
                                              'images/svg/Fill 1-2 1 .svg',
                                              height: 18,
                                              fit: BoxFit.cover,
                                              color: Colors.white,
                                              matchTextDirection: false,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                        ],
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  showpop(BuildContext contexts) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Positioned(
                    bottom: 71,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 40.0, right: 40),
                      child: Dialog(
                        backgroundColor: ThemeProvider.of(context).brightness ==
                                Brightness.light
                            ? Colors.white
                            : head,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(12)), //this right here
                        child: Container(
                          height: 213,
                          width: 197,
                          child: Padding(
                            padding:
                                EdgeInsets.only(left: 21, right: 20, top: 24),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Best Seller',
                                      style: TextStyle(
                                          color: ThemeProvider.of(context)
                                                      .brightness ==
                                                  Brightness.light
                                              ? head
                                              : Colors.white,
                                          fontSize: 12,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      '30',
                                      style: TextStyle(
                                          color: ThemeProvider.of(context)
                                                      .brightness ==
                                                  Brightness.light
                                              ? head.withOpacity(0.3)
                                              : Colors.white.withOpacity(0.3),
                                          fontSize: 12,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 17,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Pizza',
                                      style: TextStyle(
                                          color: ThemeProvider.of(context)
                                                      .brightness ==
                                                  Brightness.light
                                              ? head
                                              : Colors.white,
                                          fontSize: 12,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      '5',
                                      style: TextStyle(
                                          color: ThemeProvider.of(context)
                                                      .brightness ==
                                                  Brightness.light
                                              ? head.withOpacity(0.3)
                                              : Colors.white.withOpacity(0.3),
                                          fontSize: 12,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 17,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Pasta',
                                      style: TextStyle(
                                          color: ThemeProvider.of(context)
                                                      .brightness ==
                                                  Brightness.light
                                              ? head
                                              : Colors.white,
                                          fontSize: 12,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      '16',
                                      style: TextStyle(
                                          color: ThemeProvider.of(context)
                                                      .brightness ==
                                                  Brightness.light
                                              ? head.withOpacity(0.3)
                                              : Colors.white.withOpacity(0.3),
                                          fontSize: 12,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 17,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Snacks',
                                      style: TextStyle(
                                          color: ThemeProvider.of(context)
                                                      .brightness ==
                                                  Brightness.light
                                              ? head
                                              : Colors.white,
                                          fontSize: 12,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      '8',
                                      style: TextStyle(
                                          color: ThemeProvider.of(context)
                                                      .brightness ==
                                                  Brightness.light
                                              ? head.withOpacity(0.3)
                                              : Colors.white.withOpacity(0.3),
                                          fontSize: 12,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 17,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Restaurant Special',
                                      style: TextStyle(
                                          color: ThemeProvider.of(context)
                                                      .brightness ==
                                                  Brightness.light
                                              ? head
                                              : Colors.white,
                                          fontSize: 12,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      '20',
                                      style: TextStyle(
                                          color: ThemeProvider.of(context)
                                                      .brightness ==
                                                  Brightness.light
                                              ? head.withOpacity(0.3)
                                              : Colors.white.withOpacity(0.3),
                                          fontSize: 12,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ));
        });
  }
}

class BubbleTabIndicator extends Decoration {
  final double indicatorHeight;
  final Color indicatorColor;
  final double indicatorRadius;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry insets;
  final TabBarIndicatorSize tabBarIndicatorSize;

  const BubbleTabIndicator({
    this.indicatorHeight: 20.0,
    this.indicatorColor: Colors.greenAccent,
    this.indicatorRadius: 100.0,
    this.tabBarIndicatorSize = TabBarIndicatorSize.label,
    this.padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
    this.insets: const EdgeInsets.symmetric(horizontal: 5.0),
  });

  @override
  Decoration lerpFrom(Decoration a, double t) {
    if (a is BubbleTabIndicator) {
      return new BubbleTabIndicator(
        padding: EdgeInsetsGeometry.lerp(a.padding, padding, t),
        insets: EdgeInsetsGeometry.lerp(a.insets, insets, t),
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  Decoration lerpTo(Decoration b, double t) {
    if (b is BubbleTabIndicator) {
      return new BubbleTabIndicator(
        padding: EdgeInsetsGeometry.lerp(padding, b.padding, t),
        insets: EdgeInsetsGeometry.lerp(insets, b.insets, t),
      );
    }
    return super.lerpTo(b, t);
  }

  @override
  _BubblePainter createBoxPainter([VoidCallback onChanged]) {
    return new _BubblePainter(this, onChanged);
  }
}

class _BubblePainter extends BoxPainter {
  _BubblePainter(this.decoration, VoidCallback onChanged) : super(onChanged);

  final BubbleTabIndicator decoration;

  double get indicatorHeight => decoration.indicatorHeight;

  Color get indicatorColor => decoration.indicatorColor;

  double get indicatorRadius => decoration.indicatorRadius;

  EdgeInsetsGeometry get padding => decoration.padding;

  EdgeInsetsGeometry get insets => decoration.insets;

  TabBarIndicatorSize get tabBarIndicatorSize => decoration.tabBarIndicatorSize;

  Rect _indicatorRectFor(Rect rect, TextDirection textDirection) {
    Rect indicator = padding.resolve(textDirection).inflateRect(rect);

    if (tabBarIndicatorSize == TabBarIndicatorSize.tab) {
      indicator = insets.resolve(textDirection).deflateRect(rect);
    }

    return new Rect.fromLTWH(
      indicator.left,
      indicator.top,
      indicator.width,
      indicator.height,
    );
  }

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration.size != null);
    final Rect rect = Offset(
            offset.dx, (configuration.size.height / 2) - indicatorHeight / 2) &
        Size(configuration.size.width, indicatorHeight);
    final TextDirection textDirection = configuration.textDirection;
    final Rect indicator = _indicatorRectFor(rect, textDirection);
    final Paint paint = Paint();
    paint.color = indicatorColor;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 1;
    canvas.drawRRect(
        RRect.fromRectAndRadius(indicator, Radius.circular(indicatorRadius)),
        paint);
  }
}

class dishmenu {
  int ItemID;
  String Name;
  String Price;
  String Image;
  int Modifier;

  dishmenu(this.ItemID, this.Name, this.Price, this.Image, this.Modifier);
}

class CartList {
  final int id, quantity;
  final String name, price, img;
  bool favorite;

  CartList({
    this.id,
    this.quantity,
    this.price,
    this.name,
    this.img,
    this.favorite,
  });

  factory CartList.fromJson(Map<String, dynamic> jsonData) {
    return CartList(
      id: jsonData['id'],
      quantity: jsonData['quantity'],
      price: jsonData['price'],
      name: jsonData['name'],
      img: jsonData['img'],
      favorite: false,
    );
  }

  static Map<String, dynamic> toMap(CartList music) => {
        'id': music.id,
        'quantity': music.quantity,
        'price': music.price,
        'name': music.name,
        'img': music.img,
        'favorite': music.favorite,
      };

  static String encode(List<CartList> musics) => json.encode(
        musics
            .map<Map<String, dynamic>>((music) => CartList.toMap(music))
            .toList(),
      );

  static List<CartList> decode(String musics) =>
      (json.decode(musics) as List<dynamic>)
          .map<CartList>((item) => CartList.fromJson(item))
          .toList();
}
