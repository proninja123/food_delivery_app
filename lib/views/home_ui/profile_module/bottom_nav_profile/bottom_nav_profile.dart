import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:food_delivery/views/authentification/choose_dashboard.dart';
import 'package:food_delivery/utils/baseClass.dart';
import 'package:food_delivery/view_models/shared_pref_view_model.dart';
import 'package:food_delivery/views/authentification/onboarding_page.dart';
import 'package:food_delivery/views/authentification/signup_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import '../../../../utils/theme_config.dart';
import 'package:food_delivery/views/home_ui/profile_module/profile_about_application/about_aaplication.dart';
import 'package:food_delivery/views/home_ui/profile_module/profile_help_support/help_support.dart';
import 'package:food_delivery/views/home_ui/profile_module/profile_select_language/profile_select_app_language.dart';
import 'package:food_delivery/views/home_ui/profile_module/profile_manage_address/profile_manage_addresses.dart';
import 'package:food_delivery/views/home_ui/profile_module/profile_user_order_history/profile_user_order_history.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../utils/app_colors.dart';
import '../profile_user_chat/profile_chat.dart';
import '../profile_favourites/user_profile_favourites.dart';
import '../../about_order_filter_module/order_placed.dart';

class SideBar extends StatefulWidget {
  /* final ValueChanged<int> update;*/
  /*SideBar({this.update});*/

  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> with BaseClass {
  bool isInstructionView = false;

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timestamp) {
      // do stuff after frame is build
    });
    super.initState();
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
  Widget build(BuildContext context) {
    final sharedPref = Provider.of<SharedPrefProvider>(context);
    return ThemeSwitchingArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30.0, top: 30, right: 30),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(),
                    /*InkWell(
                        onTap: (){
                          setState(() {
                            timeDilation=2;
                          });
                          Navigator.of(context).pop();
                        },
                        child: Icon(Icons.arrow_back,color: ThemeProvider.of(context).brightness ==
                            Brightness.light
                            ? head:Colors.white,size: 28,)),
*/
                    Text(
                      'Profile',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: ThemeProvider.of(context).brightness ==
                                Brightness.light
                            ? head
                            : Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: ThemeSwitcher(
                        builder: (context) {
                          return IconButton(
                            onPressed: () async {
                              setState(() {
                                timeDilation = 2;
                              });
                              ThemeSwitcher.of(context).changeTheme(
                                theme: ThemeProvider.of(context).brightness ==
                                        Brightness.light
                                    ? darkBlueTheme
                                    : lightTheme,
                              );
                            },
                            icon: ThemeProvider.of(context).brightness ==
                                    Brightness.light
                                ? Icon(Icons.brightness_3, size: 25)
                                : Icon(
                                    Icons.wb_sunny_outlined,
                                    size: 25,
                                    color: Colors.yellow,
                                  ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 30.0, top: 21, right: 30),
                child: _checkLogin()
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Transform.scale(
                            scale: 2.15,
                            origin: Offset(0, 0),
                            child: Image.asset(
                              'images/pro.png',
                              height: 79.2,
                              width: 79.2,
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Carlos Aries',
                                /*sharedPref.userDataModel.userName,*/
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: ThemeProvider.of(context).brightness ==
                                          Brightness.light
                                      ? head
                                      : Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 24,
                                ),
                              ),
                              Text(
                                '(800) 730 XXXX | carlosaries@yahoo.com',
                                /*'${sharedPref.userDataModel.userNumber} | ${sharedPref.userDataModel.userEmail}',*/
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: ThemeProvider.of(context).brightness ==
                                          Brightness.light
                                      ? head
                                      : Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    timeDilation = 1;
                                  });
                                  _getEditProfileBottomSheet(context);
                                  // FocusScope.of(context).requestFocus(name);
                                },
                                child: Container(
                                  height: 15,
                                  width: 28,
                                  child: Text(
                                    'Edit',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      color: button_red,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'You ae not logged in',
                            /*sharedPref.userDataModel.userName,*/
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: ThemeProvider.of(context).brightness ==
                                      Brightness.light
                                  ? head
                                  : Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            'Login to start ordering',
                            /*sharedPref.userDataModel.userName,*/
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: button_red,
                              fontWeight: FontWeight.w600,
                              fontSize: 17,
                            ),
                          ),
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
                              height: 48,
                              width: 223,
                              child: Center(
                                child: Text(
                                  'LOGIN',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 46.5, right: 37, top: 15),
                child: InkWell(
                    onTap: () {
                      if(_checkLogin()){
                        setState(() {
                          timeDilation = 1;
                        });
                        pushToNextScreenWithAnimation(
                            context: context, destination: ManageAddress());
                      }
                      else{
                        showLoginDialog();
                      }

                    },
                    child: _getProfileOptionTile('Manage Addresses',
                        'images/svg/iconfinder___Location_1904662.svg', true)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 46.5, right: 37, top: 15),
                child: InkWell(
                    onTap: () {
                      if(_checkLogin()){
                        setState(() {
                          timeDilation = 1;
                        });
                        pushToNextScreenWithAnimation(
                            context: context,
                            destination: Favourites(
                              show_backbutton: true,
                            ));
                      }
                      else{
                        showLoginDialog();
                      }

                    },
                    child: _getProfileOptionTile(
                        'Favourite Orders', 'images/svg/Path.svg', true)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 46.5, right: 37, top: 15),
                child: InkWell(
                    onTap: () {
                      if(_checkLogin()){
                        setState(() {
                          timeDilation = 1;
                        });
                        pushToNextScreenWithAnimation(
                            context: context,
                            destination: OrderHistory(
                              show_backbutton: true,
                            ));
                      }
                      else{
                        showLoginDialog();
                      }


                    },
                    child: _getProfileOptionTile(
                        'Your Orders',
                        'images/svg/iconfinder_comerce_delivery_shop_business-14_4544841.svg',
                        true)),
              ),
              /*Padding(
                padding: const EdgeInsets.only(left: 46.5, right: 37, top: 15),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      timeDilation = 1;
                    });
                    Navigator.of(context).push(PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          Language(),
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
                    height: 41,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'images/iconfinder_20-blue_world-globe-language-international_4488775.png',
                              height: 15,
                              fit: BoxFit.cover,
                              color: ThemeProvider.of(context).brightness ==
                                      Brightness.light
                                  ? head
                                  : Colors.white,
                            ),
                            SizedBox(
                              width: 13,
                            ),
                            Text(
                              'Select Language',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: ThemeProvider.of(context).brightness ==
                                        Brightness.light
                                    ? Color(0xff2B2F38)
                                    : Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: ThemeProvider.of(context).brightness ==
                                  Brightness.light
                              ? head.withOpacity(0.5)
                              : Colors.white.withOpacity(0.5),
                          size: 15,
                        ),
                      ],
                    ),
                  ),
                ),
              ),*/
              Padding(
                padding: const EdgeInsets.only(left: 46.5, right: 37, top: 15),
                child: InkWell(
                    onTap: () {
                      setState(() {
                        timeDilation = 1;
                      });
                      pushToNextScreenWithAnimation(
                          context: context, destination: ChatScreen());
                    },
                    child: _getProfileOptionTile('Chat support',
                        'images/svg/noun_chat_945168.svg', true)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 46.5, right: 37, top: 15),
                child: InkWell(
                    onTap: () {
                      setState(() {
                        timeDilation = 1;
                      });
                      pushToNextScreenWithAnimation(
                          context: context, destination: About());
                    },
                    child: _getProfileOptionTile('About',
                        'images/svg/iconfinder_about_4092564.svg', true)),
              ),
              Padding(
                  padding:
                      const EdgeInsets.only(left: 46.5, right: 37, top: 15),
                  child: _getProfileOptionTile(
                      'Rate Us on App Store',
                      'images/svg/iconfinder_-_Star-Favorite-Featured-Famous-Super_3844463.svg',
                      false)),
              Padding(
                padding: const EdgeInsets.only(left: 46.5, right: 37, top: 15),
                child: InkWell(
                    onTap: () {
                      setState(() {
                        timeDilation = 1;
                      });
                      pushToNextScreenWithAnimation(
                          context: context, destination: HelpSupport());
                    },
                    child: _getProfileOptionTile(
                        'Help or give Feedback',
                        'images/svg/iconfinder_20-blue_world-globe-language-international_4488775.svg',
                        false)),
              ),
              _checkLogin()?Padding(
                padding: EdgeInsets.only(
                    left: 24.0, right: 24, top: 50, bottom: 130),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        sharedPref.clearPreference();
                        pushReplaceAndClearStack(
                            context: context,
                            destination: /*OnBoarding*/ OnBoardingPage());
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          color: button_red,
                        ),
                        height: 48,
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20.0, right: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'LOG OUT',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Icon(
                                    Icons.power_settings_new_outlined,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ):Container(),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> _getEditProfileBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25))),
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return edit();
        });
      },
    );
  }

  SingleChildScrollView edit() {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          color: ThemeProvider.of(context).brightness == Brightness.light
              ? Colors.white
              : Color(0xff222C44),
          boxShadow: [
            BoxShadow(
                color: ThemeProvider.of(context).brightness == Brightness.light
                    ? Color(0xff00000021)
                    : Color(0xff222C44).withOpacity(0.07),
                spreadRadius: 20,
                blurRadius: 20,
                offset: Offset(0, 5))
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 41, left: 44, right: 73),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Edit Info',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: ThemeProvider.of(context).brightness ==
                                  Brightness.light
                              ? head
                              : Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 21,
                  ),
                  Row(
                    children: [
                      Text(
                        'Full Name*',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: button_red,
                          fontWeight: FontWeight.w600,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 0,
                    ),
                    child: TextField(
                      focusNode: name,
                      autofocus: true,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: ThemeProvider.of(context).brightness ==
                                        Brightness.light
                                    ? Colors.grey
                                    : Colors.white)),
                        hintText: 'Enter Name',
                        hintStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          color: ThemeProvider.of(context).brightness ==
                                  Brightness.light
                              ? head.withOpacity(0.45)
                              : Colors.white.withOpacity(0.45),
                          fontSize: 12,
                        ),
                        contentPadding: EdgeInsets.all(0),
                      ),
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: ThemeProvider.of(context).brightness ==
                                Brightness.light
                            ? head
                            : Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  Row(
                    children: [
                      Text(
                        'Email Address',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: button_red,
                          fontWeight: FontWeight.w600,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 0,
                    ),
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: ThemeProvider.of(context).brightness ==
                                        Brightness.light
                                    ? Colors.grey
                                    : Colors.white)),
                        hintText: 'Enter E-Mail',
                        hintStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          color: ThemeProvider.of(context).brightness ==
                                  Brightness.light
                              ? head.withOpacity(0.45)
                              : Colors.white.withOpacity(0.45),
                          fontSize: 12,
                        ),
                        contentPadding: EdgeInsets.all(0),
                      ),
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: ThemeProvider.of(context).brightness ==
                                Brightness.light
                            ? head
                            : Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  Row(
                    children: [
                      Text(
                        'Phone number*',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: button_red,
                          fontWeight: FontWeight.w600,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 0,
                    ),
                    child: TextField(
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                      decoration: InputDecoration(
                        counterText: '',
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: ThemeProvider.of(context).brightness ==
                                        Brightness.light
                                    ? Colors.grey
                                    : Colors.white)),
                        hintText: 'Enter Phone number',
                        hintStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          color: ThemeProvider.of(context).brightness ==
                                  Brightness.light
                              ? head.withOpacity(0.45)
                              : Colors.white.withOpacity(0.45),
                          fontSize: 12,
                        ),
                        contentPadding: EdgeInsets.all(0),
                      ),
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: ThemeProvider.of(context).brightness ==
                                Brightness.light
                            ? head
                            : Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                height: 56,
                width: double.infinity,
                margin:
                    EdgeInsets.only(left: 28, right: 28, top: 18, bottom: 200),
                //padding: EdgeInsets.symmetric(horizontal: 18, vertical: 15),
                decoration: new BoxDecoration(
                  color: button_green,
                  boxShadow: [
                    BoxShadow(
                        color: ThemeProvider.of(context).brightness ==
                                Brightness.light
                            ? button_green.withOpacity(0.5)
                            : Color(0xff222C44),
                        spreadRadius: 0,
                        blurRadius: 36,
                        offset: Offset(0, 3))
                  ],
                  borderRadius: new BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Update',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  FocusNode name = new FocusNode();

  Widget _getProfileOptionTile(
    String title,
    String prefixIcon,
    bool isSuffixIconShow,
  ) {
    return Container(
      height: 41,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                prefixIcon,
                color: ThemeProvider.of(context).brightness == Brightness.light
                    ? head
                    : Colors.white,
                height: 15,
                fit: BoxFit.cover,
                matchTextDirection: false,
              ),
              SizedBox(
                width: 13,
              ),
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  color:
                      ThemeProvider.of(context).brightness == Brightness.light
                          ? Color(0xff2B2F38)
                          : Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          isSuffixIconShow
              ? Icon(
                  Icons.arrow_forward_ios,
                  color:
                      ThemeProvider.of(context).brightness == Brightness.light
                          ? head.withOpacity(0.5)
                          : Colors.white.withOpacity(0.5),
                  size: 15,
                )
              : Container(),
        ],
      ),
    );
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
}
