import 'dart:convert';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:food_delivery/custom_widgets/filled_button.dart';
import 'package:food_delivery/models/login_with_number_model.dart';
import 'package:food_delivery/models/user_model.dart';
import 'package:food_delivery/repository/authentification_repository.dart';
import 'package:food_delivery/views/authentification/sign_up_add_name.dart';
import 'package:food_delivery/views/home_ui/bottom_bar_ui/bottom_bar.dart';
import 'package:food_delivery/utils/baseClass.dart';
import 'package:food_delivery/view_models/shared_pref_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../../utils/app_colors.dart';

class OtpScreen extends StatefulWidget {
  final String userNumber;

  final bool isGoogle;

  final bool isFb;

  final bool isPhone;

  final GoogleSignInAccount user;
  final Map<String, dynamic> facebookUserData;
  final bool isSignUp;

  OtpScreen({
    this.userNumber,
    this.isGoogle = false,
    this.isFb = false,
    this.isPhone = true,
    this.isSignUp = true,
    this.user,
    this.facebookUserData,
  });

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> with BaseClass {
  FocusNode otp1 = new FocusNode();
  FocusNode otp2 = new FocusNode();
  FocusNode otp3 = new FocusNode();
  FocusNode otp4 = new FocusNode();
  AuthRepository _authRepository = AuthRepository();

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timestamp) {
      // do stuff after frame is build

      FocusScope.of(context).requestFocus(otp1);
    });
    super.initState();
  }

  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  TextEditingController controller4 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var sharePrefProvider = Provider.of<SharedPrefProvider>(context);
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
                        "Phone \nVerification",
                        style: TextStyle(
                            fontSize: 29,
                            fontFamily: 'Montserrat',
                            color: button_red,
                            height: 0.7,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 17,
                      ),
                      Text(
                        "We have sent you an SMS with a code.\nSend to ${widget.userNumber}",
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
                      left: 36.0, right: 36, top: 26, bottom: 46),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 72,
                        width: 56,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            color: ThemeProvider.of(context).brightness ==
                                    Brightness.light
                                ? Color(0xffE3E3E3)
                                : Color(0xff2B2F38)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: TextField(
                                focusNode: otp1,
                                onChanged: (val) {
                                  FocusScope.of(context).requestFocus(otp2);
                                },
                                keyboardType: TextInputType.number,
                                controller: controller1,
                                maxLength: 1,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                        left: 20,
                                        right: 20,
                                        top: 22,
                                        bottom: 20),
                                    counterText: "",
                                    border: InputBorder.none),
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: button_red,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 22,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 72,
                        width: 56,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          color: ThemeProvider.of(context).brightness ==
                                  Brightness.light
                              ? Color(0xffE3E3E3)
                              : Color(0xff2B2F38),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: TextField(
                                onChanged: (val) {
                                  FocusScope.of(context).requestFocus(otp3);
                                },
                                focusNode: otp2,
                                controller: controller2,
                                keyboardType: TextInputType.number,
                                maxLength: 1,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                        left: 20,
                                        right: 20,
                                        top: 22,
                                        bottom: 20),
                                    counterText: "",
                                    border: InputBorder.none),
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: button_red,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 22,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 72,
                        width: 56,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            color: ThemeProvider.of(context).brightness ==
                                    Brightness.light
                                ? Color(0xffE3E3E3)
                                : Color(0xff2B2F38)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: TextField(
                                onChanged: (val) {
                                  FocusScope.of(context).requestFocus(otp4);
                                },
                                focusNode: otp3,
                                keyboardType: TextInputType.number,
                                controller: controller3,
                                maxLength: 1,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                        left: 20,
                                        right: 20,
                                        top: 22,
                                        bottom: 20),
                                    counterText: "",
                                    border: InputBorder.none),
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: button_red,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 22,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 72,
                        width: 56,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            color: ThemeProvider.of(context).brightness ==
                                    Brightness.light
                                ? Color(0xffE3E3E3)
                                : Color(0xff2B2F38)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: TextField(
                                focusNode: otp4,
                                keyboardType: TextInputType.number,
                                maxLength: 1,
                                controller: controller4,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                        left: 20,
                                        right: 20,
                                        top: 22,
                                        bottom: 20),
                                    counterText: "",
                                    border: InputBorder.none),
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: button_red,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 22,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 28.0, right: 28, top: 0),
                  child: InkWell(
                      onTap: () async {
                        try {
                          if (controller1.text.trim().isNotEmpty &&
                              controller2.text.trim().isNotEmpty &&
                              controller3.text.trim().isNotEmpty &&
                              controller4.text.trim().isNotEmpty) {
                            showCircularDialog(context);
                            String otp = controller1.text.trim() +
                                controller2.text.trim() +
                                controller3.text.trim() +
                                controller4.text.trim();
                            var bytes =
                                utf8.encode('${widget.userNumber}:$otp');
                            var base64Str = base64.encode(bytes);
                            print(base64Str);

                            await _authRepository.confirmOtp(base64Str);
                            popToPreviousScreen(context: context);
                            if(widget.isSignUp) {
                              pushToNextScreenWithAnimation(
                                context: context,
                                destination: Addname(
                                  isGoogle: widget.isGoogle,
                                  isFb: widget.isFb,
                                  isPhone: widget.isPhone,
                                  user: widget.user,
                                  userNumber: widget.userNumber,
                                  facebookUserData: widget.facebookUserData,
                                ),
                              );
                            }
                            else{
                              String phoneNumber =widget.userNumber.replaceAll('+', '');
                              try {
                                showCircularDialog(context);
                                LoginWithPhoneModel loginWithPhoneModel =  await _authRepository.loginWithPhoneNumber(
                                    phoneNumber);
                                if(loginWithPhoneModel.userid==null){
                                  popToPreviousScreen(context: context);
                                  showError('Register', 'Phone number not found, Please register to continue');
                                  return ;
                                }
                                UserDataModel userModel = new UserDataModel();
                                userModel.setUserId(loginWithPhoneModel.userid.toString());
                                userModel.setFullName(loginWithPhoneModel.name);
                                userModel.setLogin(true);
                                sharePrefProvider
                                    .saveSharedPreference(userModel);
                                popToPreviousScreen(context: context);
                                pushReplaceAndClearStack(
                                    context: context,
                                    destination: BottomBar());
                              }
                              catch(onError){
                                showError('Invalid', onError.toString());
                                print(onError);
                              }
                            }
                          } else {
                            showError('Otp', 'Otp cannot be empty');
                          }
                        } catch (onError) {
                          print(onError.toString());
                          popToPreviousScreen(context: context);
                          showError('Error', onError.toString());
                        }
                        /*  Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            Addname(),
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
                        btnTextColor: Colors.white,
                        btnText: "Verify OTP",
                        btnFontWeight: FontWeight.w400,
                      )),
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
