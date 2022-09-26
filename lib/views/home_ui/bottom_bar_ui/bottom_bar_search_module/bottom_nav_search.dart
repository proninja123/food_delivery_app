import 'dart:convert';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:food_delivery/utils/app_colors.dart';
import 'package:food_delivery/views/home_ui/about_order_filter_module/FilterPage.dart';
import 'package:food_delivery/views/home_ui/seller_menu_module/seller_menu_items_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:math'as math;
import 'package:http/http.dart' as http;
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:shared_preferences/shared_preferences.dart';
import '../bottom_bar.dart';
import '../../customize_menu_module/CustomizeFood.dart';
import '../../profile_module/bottom_nav_profile/bottom_nav_profile.dart';
int cd=0;

class SearchScreen extends StatefulWidget {


  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {


  FocusNode search_focus = new FocusNode();
  int currentPage = 0;
  PageController _pageController = new PageController(
      initialPage: 0,
      keepPage: true,
      viewportFraction: 0.8
  );
  String _selectedLocation;
  int _current = 0;

  int currentCategoryIndex = 0;
  List<String> _locations = ['Home (Carrera 46 #52-96)', 'Office (Carrera 46 #52-96)', 'Others (Carrera 46 #52-96)'];
  List<Widget>carosel=new List<Widget>();
  List<Categorylist>iList=new List<Categorylist>();
  List<topickslist>tList=new List<topickslist>();
  List<restaurentlist>rList=new List<restaurentlist>();
  List<restaurantMenu> fullMenu = new List<restaurantMenu>();

  Future<String> getRestaurantMenu() async{


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
      setState(() {
        timeDilation=1;
      });

        FocusScope.of(context).requestFocus(search_focus);

      setState(() {
        BottomBar.showint=-1;
        BottomBar.showb=false;
      });
    });
    getRestaurantMenu();
    addtoList();

    super.initState();
  }
  var Searchkey="";
  final searc_controller = TextEditingController();
  final List<int> pages = List.generate(4, (index) => index);
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
        appBar: AppBar(
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

      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            Padding(
              padding: const EdgeInsets.only(left:20.0,right: 20,),
              child: Container(
                  height: 47,

                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.symmetric(vertical: 10),

                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(24)),
                      boxShadow: [BoxShadow(
                          color: ThemeProvider.of(context).brightness ==
                              Brightness.light
                              ? Colors.red.withOpacity(0.07):Color(0xff222C44).withOpacity(0.07),
                          spreadRadius:8,
                          blurRadius: 20,
                          offset: Offset(0, 7)
                      )],
                      color:ThemeProvider.of(context).brightness ==
                          Brightness.light
                          ? Colors.white: Color(0xff222C44)
                  ),

                  child:Row(

                    children: [

                      Padding(
                        padding: const EdgeInsets.only(left:15.0,bottom: 4),
                        child: Container(
                          width: 18,
                          height: 18,
                          margin: EdgeInsets.only(right: 10),
                          child: Image.asset("images/Group 9.png", color: Color(0xffed1d1d), fit: BoxFit.contain,),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          onChanged: (val){
                           setState(() {
                             Searchkey=val;
                           });
                          },
                          focusNode: search_focus,
                          controller: searc_controller,
                          decoration: InputDecoration(

                              hintText: "Search for restaurants, cuisines or a dish..",
                              hintStyle: TextStyle(
                                  fontSize: 12,fontFamily: 'Montserrat',

                                  color: ThemeProvider.of(context).brightness ==
                                      Brightness.light
                                      ? head.withOpacity(0.5):Colors.white.withOpacity(0.5),fontWeight: FontWeight.w500,),


                              border: InputBorder.none),
                          style: TextStyle(fontSize: 12,fontFamily: 'Montserrat',color: ThemeProvider.of(context).brightness ==
                              Brightness.light
                              ? head:Colors.white,fontWeight: FontWeight.w500,),),
                      ),
                    ],
                  )),
            ),
            Searchkey=="thai"?
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top:35.0,left: 22),
                  child: Row(
                    children: [
                      Text('Quick search',style: TextStyle(fontSize: 20,fontFamily: 'Montserrat',
                          color: ThemeProvider.of(context).brightness ==
                              Brightness.light
                              ? head:Colors.white,fontWeight: FontWeight.w600),),
                    ],
                  ),
                ),
                Container(
                  child: Padding(

                    padding:  EdgeInsets.only(top: 21,bottom: 0),
                    child: SizedBox(
                      height:110,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: iList.length,
                        itemBuilder: (BuildContext context, int index) => Padding(
                          padding:  (index == 0)?EdgeInsets.only(left:8) : EdgeInsets.only(left:8),
                          child: InkWell(
                            onTap: (){
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
                                        borderRadius: BorderRadius.all(Radius.circular(8)),
                                        color: currentCategoryIndex == index ? button_red : ThemeProvider.of(context).brightness ==
                                            Brightness.light
                                            ? Colors.white:head,
                                        boxShadow: [BoxShadow(
                                            color: ThemeProvider.of(context).brightness ==
                                                Brightness.light
                                                ? Colors.black.withOpacity(0.13):Color(0xFF131824).withOpacity(0.13),
                                            blurRadius: 0.8,
                                            spreadRadius: 0.8,
                                            offset: Offset(3,3)
                                        )]
                                    ),
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      child: SvgPicture.asset(
                                        '${iList[index].image}',
                                        matchTextDirection: true,
                                        color: currentCategoryIndex == index ? Colors.yellow : ThemeProvider.of(context).brightness ==
                                            Brightness.light
                                            ? Colors.grey:Colors.white,
                                        height: 10,
                                        fit: BoxFit.contain,//Color(0xff515970),
                                      ),
                                    ),
                                  ),
                                  //Image.asset('${iList[index].image}',fit: BoxFit.contain,height: 50,),
                                  Padding(
                                    padding: const EdgeInsets.only(top:15),
                                    child: Text('${iList[index].name}',style: TextStyle(fontSize: 12,fontFamily: 'Montserrat',color: Color(0xff535B72),fontWeight: FontWeight.w500),
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

                Padding(
                  padding: const EdgeInsets.only(top:10.0,left: 22),
                  child: Row(
                    children: [
                      Text('Showing results for "Thai"',style: TextStyle(fontSize: 20,fontFamily: 'Montserrat',
                          color: ThemeProvider.of(context).brightness ==
                              Brightness.light
                              ? head:Colors.white,fontWeight: FontWeight.w600),),
                    ],
                  ),
                ),
                Container(
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.all(0),

                    shrinkWrap: true,
                    itemCount: fullMenu.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: ()async{
                          SharedPreferences prefs = await SharedPreferences.getInstance();

                          await prefs.setString('Rname', '${fullMenu[index].name}');
                          await prefs.setString('Rreview', '${fullMenu[index].reviews}');
                          await prefs.setString('Rlogo', '${fullMenu[index].logo}');
                          await prefs.setString('Rcover', '${fullMenu[index].cover}');
                          await prefs.setInt('Risopen', fullMenu[index].isOpen);
                          await prefs.setInt('Rdelivery', fullMenu[index].deliverytime);

                          Navigator.of(context).push(PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) => RestuarentPage(),
                            transitionsBuilder: (context, animation, secondaryAnimation, child) {
                              var begin = Offset(1.0, 0.0);
                              var end = Offset.zero;
                              var curve = Curves.ease;

                              var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                              return SlideTransition(
                                position: animation.drive(tween),
                                child: child,
                              );
                            },
                          ));

                        },
                        child: Padding(
                          padding: (index==fullMenu.length-1)?
                          EdgeInsets.only(top:24.0,left: 24,right: 24,bottom: 120):
                          EdgeInsets.only(top:24.0,left: 24,right: 24,),
                          child: Container(height: 101,
                            decoration: BoxDecoration(borderRadius: BorderRadius.all(
                                Radius.circular(20)
                            ),color: ThemeProvider.of(context).brightness ==
                                Brightness.light
                                ? Colors.white:Color(0xff222C44),
                                boxShadow: [BoxShadow(
                                    color: ThemeProvider.of(context).brightness ==
                                        Brightness.light
                                        ? Colors.red.withOpacity(0.07):Color(0xff222C44).withOpacity(0.07),
                                    spreadRadius:0.1,
                                    blurRadius: 0.1,
                                    offset: Offset(1, 2)
                                )]),
                            child: Column(


                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [

                                    Padding(
                                      padding: const EdgeInsets.only(left:10.0,top: 13),
                                      child: Container(
                                        height: 68,
                                        width: 92,

                                        child: Stack(
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  height: 64,width: 64,
                                                  decoration: BoxDecoration(borderRadius: BorderRadius.all(
                                                      Radius.circular(8)
                                                  ),
                                                      image:  DecorationImage(image: NetworkImage('${fullMenu[index].logo}'))
                                                  ),
                                                ),
                                              ],
                                            ),
                                           /* Positioned(
                                                left: 0,
                                                right: 0,
                                                bottom: 2,
                                                child: Column(
                                                  children: [
                                                    InkWell(
                                                      onTap: (){
                                                       *//* Navigator.push(
                                                          context,
                                                          MaterialPageRoute(builder: (context) => CustomizationPage()),
                                                        );*//*
                                                      }
                                                      ,
                                                      child: Container(
                                                        height: 27,
                                                        width: 72,
                                                        decoration: BoxDecoration(borderRadius: BorderRadius.all(
                                                            Radius.circular(14)
                                                        ),color: button_red,
                                                            boxShadow: [BoxShadow(
                                                                color: Colors.black.withOpacity(0.07),
                                                                spreadRadius:0.25,
                                                                blurRadius: 0.25,
                                                                offset: Offset(0, 3)
                                                            )]),
                                                        child: Center(
                                                          child: Text('0% Off',style:TextStyle(fontSize: 12,fontFamily: 'Montserrat',
                                                              letterSpacing: 1.15,
                                                              color: Colors.white,fontWeight: FontWeight.w700) ,),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ))*/
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 20,),
                                    Padding(
                                      padding: const EdgeInsets.only(top:13.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          Padding(
                                            padding: const EdgeInsets.only(top:0.0,bottom: 0),
                                            child: Container(
                                              width: MediaQuery.of(context).size.width-180,
                                              child: Text('${fullMenu[index].name}',style:  TextStyle(fontSize: 14,fontFamily: 'Montserrat',
                                                color: ThemeProvider.of(context).brightness ==
                                                    Brightness.light
                                                    ? head:Colors.white,fontWeight: FontWeight.w700,),),
                                            ),
                                          ),
                                          SizedBox(height: 9,),
                                          Padding(
                                            padding: const EdgeInsets.only(bottom:0.0),
                                            child: Row(
                                              children: [
                                                SvgPicture.asset(
                                                  'images/svg/star_20210401_174429079.svg',
                                                  height: 15.8,width: 16.6,
                                                  fit: BoxFit.cover,
                                                  matchTextDirection: false,
                                                ),
                                                SizedBox(width: 4,),
                                                Text('${fullMenu[index].reviews}',style:  TextStyle(fontSize: 12,fontFamily: 'Montserrat',
                                                  color: head,fontWeight: FontWeight.w400,),),
                                                SizedBox(width: 8,),
                                                fullMenu[index].isOpen==1?
                                                Text('Open',style:  TextStyle(fontSize: 12,fontFamily: 'Montserrat',
                                                  color: button_green,fontWeight: FontWeight.w400,),):
                                                Text('Close',style:  TextStyle(fontSize: 12,fontFamily: 'Montserrat',
                                                  color: button_red,fontWeight: FontWeight.w400,),),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 8,),
                                          Text('Medelin(10 Mi)',style:  TextStyle(fontSize: 12,fontFamily: 'Montserrat',
                                            color: ThemeProvider.of(context).brightness ==
                                                Brightness.light
                                                ? Color(0xff8F8F8F):Colors.white.withOpacity(0.7),fontWeight: FontWeight.w400,),)

                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),

                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ):Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left:41.0,right: 41,top: 70,bottom: 25),
                  child: Container(
                    height: 160,width: double.infinity,child:
                    Image.asset('images/undraw_breakfast_psiw.png'),

                  ),
                ),
                Text('No search result.',style: TextStyle(fontSize: 16,fontFamily: 'Montserrat',color: ThemeProvider.of(context).brightness ==
                    Brightness.light
                    ? head:Colors.white,fontWeight: FontWeight.w700),),
                Text('Maybe try something more tasty?',style: TextStyle(fontSize: 16,fontFamily: 'Montserrat',color: ThemeProvider.of(context).brightness ==
                    Brightness.light
                    ? head:Colors.white,fontWeight: FontWeight.w700),)
              ],
            )

          ],
        ),
      ),
    );
  }

  void changePage()
  {
    print(currentPage);
    if(currentPage == 4)
    {
      //  Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
    }
    else{
      _pageController.animateToPage(currentPage+1, duration: Duration(milliseconds: 200), curve: Curves.linear);
    }
  }
  setCurrentPage(int value)
  {
    currentPage = value;
    setState(() {

    });
  }
  addtoList(){
    carosel.add( Container(
      width: 386,
      height: 182,
      margin: EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20))  ,
        image: DecorationImage(image:AssetImage('images/Background.png',),
            fit: BoxFit.cover),


      ),
      child: Container(
        width: 386,
        height: 182,
        decoration: BoxDecoration(  gradient: LinearGradient(colors: [
          Color(0xffff2f17).withOpacity(0.9),
          Color(0xffff2f17).withOpacity(0),
        ],
            stops: [0,.6],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight),
          borderRadius: BorderRadius.all(Radius.circular(20))  ,),
        child: Padding(
          padding: const EdgeInsets.only(left:20.0,top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 40,height: 30,
                child: SvgPicture.asset(
                  'images/svg/_Compound Path_.svg',
                  color: Colors.white,
                  matchTextDirection: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:15.0),
                child: Text('NEW YEAR OFFER',style:TextStyle(
                  fontSize: 14,fontFamily: 'Montserrat',color: Colors.white,

                ) ,),
              ),
              Padding(
                padding: const EdgeInsets.only(top:5.0),
                child: Text('20% OFF',style:TextStyle(
                    fontSize: 17,fontFamily: 'Montserrat',color: Colors.white,
                    letterSpacing: 1.21,
                    fontWeight: FontWeight.w700 ) ,),
              ),
              Padding(
                padding: const EdgeInsets.only(top:20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('Explore',style:TextStyle(
                            fontSize: 12,fontFamily: 'Montserrat',color: Colors.white,
                            letterSpacing: 1.15,
                            fontWeight: FontWeight.w500 ) ,),
                        SizedBox(width: 4,),
                        Icon(Icons.arrow_forward_rounded,color: Colors.white,size: 14,)
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
            ],),
        ),
      ),

    ));
    carosel.add( Container(
      width: 386,
      height: 182,
      margin: EdgeInsets.only(left: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20))  ,
        image: DecorationImage(image:AssetImage('images/Background.png',),
            fit: BoxFit.cover),


      ),
      child: Container(
        width: 386,
        height: 182,
        decoration: BoxDecoration(  gradient: LinearGradient(colors: [
          Color(0xffff2f17).withOpacity(0.9),
          Color(0xffff2f17).withOpacity(0),
        ],
            stops: [0,.6],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight),
          borderRadius: BorderRadius.all(Radius.circular(20))  ,),
        child: Padding(
          padding: const EdgeInsets.only(left:20.0,top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 40,height: 30,
                child: SvgPicture.asset(
                  'images/svg/_Compound Path_.svg',
                  color: Colors.white,
                  matchTextDirection: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:15.0),
                child: Text('NEW YEAR OFFER',style:TextStyle(
                  fontSize: 14,fontFamily: 'Montserrat',color: Colors.white,

                ) ,),
              ),
              Padding(
                padding: const EdgeInsets.only(top:5.0),
                child: Text('20% OFF',style:TextStyle(
                    fontSize: 17,fontFamily: 'Montserrat',color: Colors.white,
                    letterSpacing: 1.21,
                    fontWeight: FontWeight.w700 ) ,),
              ),
              Padding(
                padding: const EdgeInsets.only(top:20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('Explore',style:TextStyle(
                            fontSize: 12,fontFamily: 'Montserrat',color: Colors.white,
                            letterSpacing: 1.15,
                            fontWeight: FontWeight.w500 ) ,),
                        SizedBox(width: 4,),
                        Icon(Icons.arrow_forward_rounded,color: Colors.white,size: 14,)
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
            ],),
        ),
      ),

    ));
    carosel.add( Container(
      width: 386,
      height: 182,
      margin: EdgeInsets.only(left: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20))  ,
        image: DecorationImage(image:AssetImage('images/Background.png',),
            fit: BoxFit.cover),


      ),
      child: Container(
        width: 386,
        height: 182,
        decoration: BoxDecoration(  gradient: LinearGradient(colors: [
          Color(0xffff2f17).withOpacity(0.9),
          Color(0xffff2f17).withOpacity(0),
        ],
            stops: [0,.6],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight),
          borderRadius: BorderRadius.all(Radius.circular(20))  ,),
        child: Padding(
          padding: const EdgeInsets.only(left:20.0,top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 40,height: 30,
                child: SvgPicture.asset(
                  'images/svg/_Compound Path_.svg',
                  color: Colors.white,
                  matchTextDirection: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:15.0),
                child: Text('NEW YEAR OFFER',style:TextStyle(
                  fontSize: 14,fontFamily: 'Montserrat',color: Colors.white,

                ) ,),
              ),
              Padding(
                padding: const EdgeInsets.only(top:5.0),
                child: Text('20% OFF',style:TextStyle(
                    fontSize: 17,fontFamily: 'Montserrat',color: Colors.white,
                    letterSpacing: 1.21,
                    fontWeight: FontWeight.w700 ) ,),
              ),
              Padding(
                padding: const EdgeInsets.only(top:20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('Explore',style:TextStyle(
                            fontSize: 12,fontFamily: 'Montserrat',color: Colors.white,
                            letterSpacing: 1.15,
                            fontWeight: FontWeight.w500 ) ,),
                        SizedBox(width: 4,),
                        Icon(Icons.arrow_forward_rounded,color: Colors.white,size: 14,)
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
            ],),
        ),
      ),

    ));
    carosel.add( Container(
      width: 386,
      height: 182,
      margin: EdgeInsets.only(left: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20))  ,
        image: DecorationImage(image:AssetImage('images/Background.png',),
            fit: BoxFit.cover),


      ),
      child: Container(
        width: 386,
        height: 182,
        decoration: BoxDecoration(  gradient: LinearGradient(colors: [
          Color(0xffff2f17).withOpacity(0.9),
          Color(0xffff2f17).withOpacity(0),
        ],
            stops: [0,.6],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight),
          borderRadius: BorderRadius.all(Radius.circular(20))  ,),
        child: Padding(
          padding: const EdgeInsets.only(left:20.0,top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 40,height: 30,
                child: SvgPicture.asset(
                  'images/svg/_Compound Path_.svg',
                  color: Colors.white,
                  matchTextDirection: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:15.0),
                child: Text('NEW YEAR OFFER',style:TextStyle(
                  fontSize: 14,fontFamily: 'Montserrat',color: Colors.white,

                ) ,),
              ),
              Padding(
                padding: const EdgeInsets.only(top:5.0),
                child: Text('20% OFF',style:TextStyle(
                    fontSize: 17,fontFamily: 'Montserrat',color: Colors.white,
                    letterSpacing: 1.21,
                    fontWeight: FontWeight.w700 ) ,),
              ),
              Padding(
                padding: const EdgeInsets.only(top:20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('Explore',style:TextStyle(
                            fontSize: 12,fontFamily: 'Montserrat',color: Colors.white,
                            letterSpacing: 1.15,
                            fontWeight: FontWeight.w500 ) ,),
                        SizedBox(width: 4,),
                        Icon(Icons.arrow_forward_rounded,color: Colors.white,size: 14,)
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
            ],),
        ),
      ),

    ));
    iList.add(Categorylist(image: 'images/svg/hamburger.svg',name: 'Pizza'));
    iList.add(Categorylist(image: 'images/svg/hot dog.svg',name: 'Burgers'));
    iList.add(Categorylist(image: 'images/svg/noodle.svg',name: 'Tacos'));
    iList.add(Categorylist(image: 'images/svg/pizza slice.svg',name: 'Beverages'));

    iList.add(Categorylist(image: 'images/svg/hamburger.svg',name: 'Pizza'));
    iList.add(Categorylist(image: 'images/svg/hot dog.svg',name: 'Burgers'));
    iList.add(Categorylist(image: 'images/svg/noodle.svg',name: 'Tacos'));
    iList.add(Categorylist(image: 'images/svg/pizza slice.svg',name: 'Beverages'));

    tList.add(topickslist(image: 'images/bon-vivant-qom5MPOER-I-unsplash 1 .png',name: "Sam's Chinese"));
    tList.add(topickslist(image: 'images/jordan-nix-61wG5-SAF Y-unsplash 1 .png',name: "Taco Bell"));
    tList.add(topickslist(image: 'images/tai-s-captures-JiRSy0GfqPA-unsplash 2 .png',name: "Mexican"));
    tList.add(topickslist(image: 'images/lior-shapira-GKxsKNTfZd8-unsplash 1 .png',name: "Indian"));
    tList.add(topickslist(image: 'images/bon-vivant-qom5MPOER-I-unsplash 1 .png',name: "Sam's Chinese"));
    tList.add(topickslist(image: 'images/jordan-nix-61wG5-SAF Y-unsplash 1 .png',name: "Taco Bell"));
    tList.add(topickslist(image: 'images/tai-s-captures-JiRSy0GfqPA-unsplash 2 .png',name: "Mexican"));
    tList.add(topickslist(image: 'images/lior-shapira-GKxsKNTfZd8-unsplash 1 .png',name: "Indian"));
    tList.add(topickslist(image: 'images/bon-vivant-qom5MPOER-I-unsplash 1 .png',name: "Sam's Chinese"));
    tList.add(topickslist(image: 'images/jordan-nix-61wG5-SAF Y-unsplash 1 .png',name: "Taco Bell"));
    tList.add(topickslist(image: 'images/tai-s-captures-JiRSy0GfqPA-unsplash 2 .png',name: "Mexican"));
    tList.add(topickslist(image: 'images/lior-shapira-GKxsKNTfZd8-unsplash 1 .png',name: "Indian"));
    tList.add(topickslist(image: 'images/bon-vivant-qom5MPOER-I-unsplash 1 .png',name: "Sam's Chinese"));
    tList.add(topickslist(image: 'images/jordan-nix-61wG5-SAF Y-unsplash 1 .png',name: "Taco Bell"));
    tList.add(topickslist(image: 'images/tai-s-captures-JiRSy0GfqPA-unsplash 2 .png',name: "Mexican"));
    tList.add(topickslist(image: 'images/lior-shapira-GKxsKNTfZd8-unsplash 1 .png',name: "Indian"));
    rList.add(restaurentlist(image: 'images/vitalii-chernopyskyi-Oxb84ENcFfU-unsplash-2 2 .png',name: "Pizza Hut (Outlet)"));
    rList.add(restaurentlist(image: 'images/Background (2).png',name: " Burger King"));
    rList.add(restaurentlist(image: 'images/vitalii-chernopyskyi-Oxb84ENcFfU-unsplash-2 2 .png',name: "Pizza Hut (Outlet)"));
    rList.add(restaurentlist(image: 'images/Background (2).png',name: " Burger King"));



  }
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

class restaurantMenu{
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

  restaurantMenu(this.restid, this.name, this.cuisinid, this.cuisine, this.address, this.city, this.state, this.distance, this.deliverytime, this.reviews, this.logo, this.cover, this.acceptorders, this.isOpen);
}