import 'dart:ui';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:food_delivery/utils/baseClass.dart';
import 'package:food_delivery/view_models/shared_pref_view_model.dart';
import 'package:food_delivery/views/authentification/onboarding_page.dart';
import 'package:food_delivery/views/authentification/signup_page.dart';
import 'package:food_delivery/views/home_ui/bottom_bar_ui/bottom_bar_home_module/bottom_nav_home_page.dart';
import 'package:food_delivery/views/home_ui/bottom_bar_ui/bottom_bar_search_module/bottom_nav_search.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:math' as math;
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/app_colors.dart';
import '../profile_module/profile_favourites/user_profile_favourites.dart';
import '../profile_module/profile_user_order_history/profile_user_order_history.dart';
import '../profile_module/bottom_nav_profile/bottom_nav_profile.dart';
import '../order_tracking_module/user_order_tracking.dart';

int _selectedIndex = -1;

class BottomBar extends StatefulWidget {
  static bool show_track;
  static bool showb;
  static int showint;

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> with BaseClass {
  bool show_bottomitem = BottomBar.showb == null ? false : BottomBar.showb;
  String _selectedLocation;
  int _current = 0;

  int currentCategoryIndex = 0;
  List<String> _locations = [
    'Home (Carrera 46 #52-96)',
    'Office (Carrera 46 #52-96)',
    'Others (Carrera 46 #52-96)'
  ];
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _currentIndex = BottomBar.showint == null ? 0 : BottomBar.showint;
  final List<Widget> _children = [
    OrderHistory(
      show_backbutton: false,
    ),
    SearchScreen(),
    Favourites(
      show_backbutton: false,
    ),
    SideBar(),
  ];

  void onTabTapped(int index) {
    print(index);
    if(index==2||index==0){
      if(_checkLogin()){
        print('INDEX VALUE 333333');
        setState(() {
          show_bottomitem = true;
          _currentIndex = index;
          timeDilation = 1;
        });
      }
      else{
        print('INDEX VALUE');

        showLoginDialog();


      }
    }
    else{
      setState(() {
        show_bottomitem = true;
        _currentIndex = index;
        timeDilation = 1;
      });
    }

  }

  bool show_cart;

  getDatas() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      BottomBar.show_track = prefs.getBool('show_cart');
    });
  }

  bool _checkLogin() {
    final prefProvider =
        Provider.of<SharedPrefProvider>(context, listen: false);
    if (prefProvider.userDataModel.isLoggedIn != null) {
      if (prefProvider.userDataModel.isLoggedIn) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      if (BottomBar.showb == null || BottomBar.showb == false) {
        setState(() {
          _selectedIndex = -1;
          show_bottomitem = false;
        });
      } else {
        setState(() {
          _selectedIndex = BottomBar.showint;
          show_bottomitem = BottomBar.showb;
        });
      }
      getDatas();
    });
    WidgetsBinding.instance.addPostFrameCallback((timestamp) {
      // do stuff after frame is build
      setState(() {
        timeDilation = 1;
      });
    });

    super.initState();
  }
  void showLoginDialog() {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 300),
      context: context,
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.center,
          child: Container(
              height: 432,
              width: 332,
              //margin: EdgeInsets.symmetric(horizontal: 40),
              decoration: BoxDecoration(
                color:  ThemeProvider.of(context).brightness == Brightness.light
                    ? Colors.white
                    : Color(0xFF131824),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                children: [
                  SizedBox(height: 52,),
                  Container(
                    height: 183,
                    width: 183,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red.withOpacity(0.07),
                    ),
                    child: Center(
                      child: Image(
                        image: AssetImage('images/logo.png'),
                        height: 80,
                        width: 100,
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    'Looks like you need to',
                    /*sharedPref.userDataModel.userName,*/
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: ThemeProvider.of(context).brightness ==
                          Brightness.light
                          ? head
                          : Colors.white,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.none,
                      fontSize: 16,
                    ),
                  ),

                  RichText(
                    text: TextSpan(
                      text: 'login to access ',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          fontFamily: 'Montserrat',
                          decoration: TextDecoration.none,
                          color: button_red),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'this feature.',
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Montserrat',
                              decoration: TextDecoration.none,
                              color:
                              ThemeProvider.of(context)
                                  .brightness ==
                                  Brightness.light
                                  ? head
                                  : Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30,),
                  GestureDetector(
                    onTap: () {
                      pushReplaceAndClearStack(
                          context: context,
                          destination: /*OnBoarding*/ OnBoardingPage());
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.all(Radius.circular(8)),
                        color: button_red,
                      ),
                      margin: EdgeInsets.symmetric(vertical: 20),
                      height: 56,
                      width: 300,
                      child: Center(
                        child: Text(
                          'LOGIN TO CONTINUE',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Colors.white,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    final sharedPref = Provider.of<SharedPrefProvider>(context);
    return show_bottomitem
        ? Scaffold(
            resizeToAvoidBottomInset: false,
            extendBody: true,
            body: show_bottomitem
                ? _children[_currentIndex]
                : HomePage(
                    show_search: false,
                  ),
            bottomNavigationBar: FABBottomAppBar(
              height: 80,
              iconSize: 19,
              centerItemText: '',
              color: Colors.grey,
              backgroundColor:
                  ThemeProvider.of(context).brightness == Brightness.light
                      ? Colors.white
                      : Color(0xff222C44),
              selectedColor: Colors.red,
              notchedShape: CircularNotchedRectangle(),
              onTabSelected: onTabTapped,
              items: [
                FABBottomAppBarItem(
                    iconData: 'images/svg/Fill 1-2 1 .svg', text: 'Orders'),
                FABBottomAppBarItem(
                    iconData: 'images/Group 9.png', text: 'Search'),
                FABBottomAppBarItem(
                    iconData: 'images/Group 5.png', text: 'Favorites'),
                FABBottomAppBarItem(
                    iconData: 'images/svg/iconfinder_about_4092564.svg',
                    text: 'Profile'),
              ],
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: InkWell(
              onTap: () {
                setState(() {
                  _selectedIndex = -1;
                  show_bottomitem = false;
                });
              },
              child: Container(
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 10)
                  ],
                  shape: BoxShape.circle,
                  color:
                      ThemeProvider.of(context).brightness == Brightness.light
                          ? Colors.white
                          : Color(0xff222C44),
                ),
                child: Container(
                    padding: EdgeInsets.all(5),
                    child: SvgPicture.asset(
                      'images/svg/_Compound Path_.svg',
                      color: Colors.red,
                      matchTextDirection: true,
                    )
                    // child: Image.asset('images/Group 3-4.png', fit: BoxFit.contain, height: 5,)
                    ),
              ),
            ),
          )
        : Scaffold(
            /* endDrawer:SideBar(),*/
            key: _scaffoldKey,
            appBar: show_bottomitem
                ? AppBar()
                : AppBar(
                    elevation: 0,
                    titleSpacing: 0,
                    automaticallyImplyLeading: false,
                    title: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 12,
                            height: 14,
                            child: SvgPicture.asset(
                              'images/svg/_Color 1 .svg',
                              color: ThemeProvider.of(context).brightness ==
                                      Brightness.light
                                  ? head
                                  : Colors.white,
                              height: 14,
                              fit: BoxFit.cover,
                              matchTextDirection: false,
                            ),
                          ),
                          _checkLogin()
                              ? Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: new DropdownButton(
                                    underline:
                                        Container(color: Colors.transparent),
                                    icon: Container(
                                      child: Center(
                                          child: Icon(
                                        Icons.keyboard_arrow_down_sharp,
                                        color: ThemeProvider.of(context)
                                                    .brightness ==
                                                Brightness.light
                                            ? Colors.grey
                                            : Colors.white,
                                      )),
                                    ),
                                    elevation: 0,
                                    hint: Text(
                                      'Home (Carrera 46 #52-96)',
                                      style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          color: ThemeProvider.of(context)
                                                      .brightness ==
                                                  Brightness.light
                                              ? head
                                              : Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    ),
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Montserrat',
                                        color: ThemeProvider.of(context)
                                                    .brightness ==
                                                Brightness.light
                                            ? head
                                            : Colors.white,
                                        fontWeight: FontWeight.w500),
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
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Row(
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          text: 'Login ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              fontFamily: 'Montserrat',
                                              color: button_red),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              pushReplaceAndClearStack(
                                                  context: context,
                                                  destination:
                                                      OnBoardingPage());
                                            },
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: 'to see saved location',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: 'Montserrat',
                                                  color:
                                                      ThemeProvider.of(context)
                                                                  .brightness ==
                                                              Brightness.light
                                                          ? head
                                                          : Colors.white,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        color: Color(0xffC9C9C9),
                                        size: 14,
                                      )
                                    ],
                                  ),
                                ),
                        ],
                      ),
                    ),
                    backgroundColor:
                        ThemeProvider.of(context).brightness == Brightness.light
                            ? Colors.white
                            : Color(0xFF131824),
                    actions: [
                      /* Padding(
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
    ),*/
                    ],
                  ),
            extendBody: true,
            body: show_bottomitem
                ? _children[_currentIndex]
                : Stack(
                    children: [
                      HomePage(),
                      Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: BottomBar.show_track == null ||
                                  BottomBar.show_track == false
                              ? Container()
                              : ClipRect(
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaX: 10.0, sigmaY: 10.0),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.of(context)
                                            .push(PageRouteBuilder(
                                          pageBuilder: (context, animation,
                                                  secondaryAnimation) =>
                                              TrackOrder(),
                                          transitionsBuilder: (context,
                                              animation,
                                              secondaryAnimation,
                                              child) {
                                            var begin = Offset(1.0, 0.0);
                                            var end = Offset.zero;
                                            var curve = Curves.ease;

                                            var tween = Tween(
                                                    begin: begin, end: end)
                                                .chain(
                                                    CurveTween(curve: curve));

                                            return SlideTransition(
                                              position: animation.drive(tween),
                                              child: child,
                                            );
                                          },
                                        ));
                                      },
                                      child: Container(
                                        height: 159,
                                        color:
                                            Color(0xffFFD2D2).withOpacity(0.0),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0, left: 20),
                                                  child: Container(
                                                    height: 36,
                                                    width: 36,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: button_red),
                                                    child: Icon(
                                                      Icons.lunch_dining,
                                                      color: Color(0xffFCEBD6),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8, left: 12),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Sam'z Chinese",
                                                        style: TextStyle(
                                                            color: ThemeProvider.of(
                                                                            context)
                                                                        .brightness ==
                                                                    Brightness
                                                                        .light
                                                                ? Colors.black
                                                                : Colors.white,
                                                            fontSize: 12,
                                                            fontFamily:
                                                                'Montserrat',
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                      Text(
                                                        "Order is under preparation",
                                                        style: TextStyle(
                                                            color: ThemeProvider.of(
                                                                            context)
                                                                        .brightness ==
                                                                    Brightness
                                                                        .light
                                                                ? Colors.black
                                                                    .withOpacity(
                                                                        0.44)
                                                                : Colors.white,
                                                            fontSize: 12,
                                                            fontFamily:
                                                                'Montserrat',
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 17.0, right: 20),
                                              child: Text(
                                                "Track order",
                                                style: TextStyle(
                                                    color: button_red,
                                                    fontSize: 12,
                                                    fontFamily: 'Montserrat',
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )),
                    ],
                  ),
            bottomNavigationBar: FABBottomAppBar(
              height: 80,
              iconSize: 19,
              centerItemText: '',
              color: Colors.grey,
              backgroundColor:
                  ThemeProvider.of(context).brightness == Brightness.light
                      ? Colors.white
                      : Color(0xff222C44),
              selectedColor: Colors.red,
              notchedShape: CircularNotchedRectangle(),
              onTabSelected: onTabTapped,
              items: [
                FABBottomAppBarItem(
                    iconData: 'images/svg/Fill 1-2 1 .svg', text: 'Orders'),
                FABBottomAppBarItem(
                    iconData: 'images/Group 9.png', text: 'Search'),
                FABBottomAppBarItem(
                    iconData: 'images/Group 5.png', text: 'Favorites'),
                FABBottomAppBarItem(
                    iconData: 'images/svg/iconfinder_about_4092564.svg',
                    text: 'Profile'),
              ],
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: InkWell(
              onTap: () {
                setState(() {
                  _selectedIndex = -1;
                  show_bottomitem = false;
                  timeDilation = 1;
                });
              },
              child: Container(
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 10)
                  ],
                  shape: BoxShape.circle,
                  color:
                      ThemeProvider.of(context).brightness == Brightness.light
                          ? Colors.white
                          : Color(0xff222C44),
                ),
                child: Container(
                    padding: EdgeInsets.all(5),
                    child: SvgPicture.asset(
                      'images/svg/_Compound Path_.svg',
                      color: Colors.red,
                      matchTextDirection: true,
                    )
                    // child: Image.asset('images/Group 3-4.png', fit: BoxFit.contain, height: 5,)
                    ),
              ),
            ),
          );
  }
}

/*SvgPicture.asset(
'images/PNG/comiida-botton.svg',
color: Colors.red,
matchTextDirection: true,
),*/
class FABBottomAppBarItem {
  FABBottomAppBarItem({this.iconData, this.text});

  String iconData;
  String text;
}

class FABBottomAppBar extends StatefulWidget {
  FABBottomAppBar({
    this.items,
    this.centerItemText,
    this.height: 60.0,
    this.iconSize: 19.0,
    this.backgroundColor,
    this.color,
    this.selectedColor,
    this.notchedShape,
    this.onTabSelected,
  }) {
    assert(this.items.length == 2 || this.items.length == 4);
  }

  final List<FABBottomAppBarItem> items;
  final String centerItemText;
  final double height;
  final double iconSize;
  final Color backgroundColor;
  final Color color;
  final Color selectedColor;
  final NotchedShape notchedShape;
  final ValueChanged<int> onTabSelected;

  @override
  State<StatefulWidget> createState() => FABBottomAppBarState();
}

class FABBottomAppBarState extends State<FABBottomAppBar> {
  _updateIndex(int index) {
    widget.onTabSelected(index);
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = List.generate(widget.items.length, (int index) {
      return _buildTabItem(
        item: widget.items[index],
        index: index,
        onPressed: _updateIndex,
      );
    });
    items.insert(items.length >> 1, _buildMiddleTabItem());

    return Container(
      child: BottomAppBar(
        elevation: 10,
        clipBehavior: Clip.hardEdge,
        notchMargin: 2,
        shape: widget.notchedShape,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: items,
        ),
        color: widget.backgroundColor,
      ),
    );
  }

  Widget _buildMiddleTabItem() {
    return Expanded(
      child: SizedBox(
        height: 38,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: widget.iconSize),
            Text(
              widget.centerItemText ?? '',
              style: TextStyle(color: widget.color),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem({
    FABBottomAppBarItem item,
    int index,
    ValueChanged<int> onPressed,
  }) {
    Color color = _selectedIndex == index
        ? Color(0xffed1d1d)
        : ThemeProvider.of(context).brightness == Brightness.light
            ? head
            : Colors.white;
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            splashColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () => onPressed(index),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                item.iconData.contains('.svg')
                    ? SvgPicture.asset(item.iconData,
                        color: color, height: widget.iconSize)
                    : Image.asset(item.iconData,
                        color: color, height: widget.iconSize),
                Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: Text(
                    item.text,
                    style: TextStyle(
                        color: color,
                        fontSize: 12,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w400),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
