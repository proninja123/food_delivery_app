import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:food_delivery/custom_widgets/filled_button.dart';
import 'package:food_delivery/views/authentification/select_location_page.dart';
import 'package:food_delivery/utils/app_colors.dart';
import 'package:food_delivery/utils/baseClass.dart';
import 'package:food_delivery/utils/user_current_location.dart';
import 'package:food_delivery/views/home_ui/automatic_location/automatic_location_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:location/location.dart';

import 'add_your_lcoation.dart';

class SignUpAddEmailPage extends StatefulWidget {
  final String userName;
  final String userNumber;

  final bool isGoogle;

  final bool isFb;

  final bool isPhone;

  final GoogleSignInAccount user;
  final Map<String,dynamic> facebookUserData ;
  SignUpAddEmailPage({
    this.userNumber,
    this.isGoogle = false,
    this.isFb = false,
    this.isPhone = true,
    this.user,
    this.userName,
    this.facebookUserData,
  });

  @override
  _SignUpAddEmailPageState createState() => _SignUpAddEmailPageState();
}

class _SignUpAddEmailPageState extends State<SignUpAddEmailPage>
    with BaseClass {
  FocusNode name = new FocusNode();
  TextEditingController _editingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timestamp) {
      // do stuff after frame is build

      FocusScope.of(context).requestFocus(name);
    });
    super.initState();
    if(widget.isGoogle && widget.user!=null){
      _editingController.text = widget.user.email;
    }
    else if(widget.isFb && widget.facebookUserData!=null){
      _editingController.text = widget.facebookUserData['email'];
    }
  }

  setUpUserLocation() async {
    LocationData locationData = await UserCurrentLocation().getUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 36.0, top: 61, bottom: 65),
                    child: Icon(
                      Icons.arrow_back,
                      color: ThemeProvider.of(context).brightness ==
                              Brightness.light
                          ? head
                          : Colors.white,
                      size: 28,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 37.0, right: 37, top: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Enter Your\nEmail",
                        style: TextStyle(
                            fontSize: 29,
                            fontFamily: 'Montserrat',
                            color: button_red,
                            height: 1.2,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 17,
                      ),
                      Text(
                        "You will receive an email with a code on this email. Charges may apply.",
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Montserrat',
                            color: ThemeProvider.of(context).brightness ==
                                    Brightness.light
                                ? head
                                : Colors.white,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 36.0, right: 36, top: 24, bottom: 68),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your email',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: button_red,
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                      ),
                      TextField(
                        focusNode: name,
                        controller: _editingController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter your Email address",
                          hintStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            color: ThemeProvider.of(context).brightness ==
                                    Brightness.light
                                ? head.withOpacity(0.45)
                                : Colors.white.withOpacity(0.45),
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
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
                      Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: Divider(
                          thickness: 0.8,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 28.0, right: 28, top: 0),
                  child: InkWell(
                    onTap: () {
                      if (_editingController.text.trim().isEmpty) {
                        showError('Email', 'Email cannot be empty');
                      } else if (!RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(_editingController.text.trim())) {
                        showError('Email', 'Email format is not correct');
                      } else {
                        pushToNextScreenWithAnimation(
                          context: context,
                          destination: /*AddYourLocationPage*/AutomaticLocationPage(
                            userNumber: widget.userNumber,
                            isGoogle: widget.isGoogle,
                            isFb:  widget.isFb ,
                            isPhone: widget.isPhone ,
                            user: widget.user,
                            userName: widget.userName,
                            facebookUserData: widget.facebookUserData,
                            userEmail: _editingController.text.trim(),
                          ),
                        );
                      }

                      /* Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            SelectLocation(),
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
                      ));*/
                    },
                    child: FilledButton(
                      btnHeight: 56,
                      btnRadius: 8,
                      btnColor: button_red,
                      btnText: "Send OTP",
                      btnTextColor: Colors.white,
                      btnFontWeight: FontWeight.w400,
                    ) /*Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: button_red,
                      ),
                      height: 56,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Start Ordering',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    )*/
                    ,
                  ),
                ),
              ],
            ),
            Positioned(
              top: -122,
              right: -201,
              child: SvgPicture.asset(
                'images/svg/_Compound Path_.svg',
                matchTextDirection: true,
                color: button_red.withOpacity(0.05),
                height: 262,
                width: 365,
                fit: BoxFit.contain, //Color(0xff515970),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
