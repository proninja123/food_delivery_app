import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:food_delivery/custom_widgets/filled_button.dart';
import 'package:food_delivery/repository/authentification_repository.dart';
import 'package:food_delivery/utils/baseClass.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../utils/app_colors.dart';
import 'otp_verification.dart';

class VerifyPhone extends StatefulWidget with BaseClass {
  final bool isGoogle;

  final bool isFb;

  final bool isPhone;

  final GoogleSignInAccount user;
  final Map<String, dynamic> facebookUserData;
final bool isSignUp ;
  VerifyPhone({
    this.isGoogle = false,
    this.isFb = false,
    this.isSignUp=true,
    this.isPhone = true,
    this.user,
    this.facebookUserData,
  });

  @override
  _VerifyPhoneState createState() => _VerifyPhoneState();
}

class _VerifyPhoneState extends State<VerifyPhone> with BaseClass {
  String _selectedLocation;
  String phoneNumber = '';
  PhoneNumber number = PhoneNumber(isoCode: 'US');
  AuthRepository _authRepository = AuthRepository();
  List<String> _locations = ['ab', 'bc', 'cd'];
  FocusNode phone = new FocusNode();
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timestamp) {
      // do stuff after frame is build
      FocusScope.of(context).requestFocus(phone);
    });
    super.initState();
    if (widget.isFb) {
      print(widget.facebookUserData);
    }
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
                        "Verify Phone\n Number",
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
                        "You will receive an SMS with a code on\nthis number. Charges may apply.",
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
                  padding:
                      const EdgeInsets.only(left: 36.0, right: 36, top: 46),
                  child: _phoneNumberWidget(),
                ),
                /*Padding(
                  padding:
                      const EdgeInsets.only(left: 36.0, right: 36, top: 46),
                  child: Row(
                    children: [
                      new DropdownButton(
                        underline: Container(color: Colors.transparent),
                        icon: Icon(
                          Icons.keyboard_arrow_down_sharp,
                          color: button_red,
                        ),
                        elevation: 0,
                        hint: Image.asset(
                          'images/Bitmap.png',
                          height: 18,
                          width: 18,
                        ),
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Montserrat',
                            color: head,
                            fontWeight: FontWeight.w500),
                        value: _selectedLocation,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedLocation = newValue;
                            print(_selectedLocation);
                          });
                        },
                        items: _locations.map((location) {
                          return DropdownMenuItem(
                            child: new Text(location),
                            value: location,
                          );
                        }).toList(),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        height: 19,
                        color: Color(0xff707070),
                        width: 1,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: TextField(
                          focusNode: phone,
                          keyboardType: TextInputType.phone,
                          maxLength: 10,
                          controller: controller,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            counterText: "",
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              color: ThemeProvider.of(context).brightness ==
                                      Brightness.light
                                  ? head.withOpacity(0.45)
                                  : Colors.white.withOpacity(0.45),
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                            hintText: 'Enter Mobile Number',
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
                      )
                    ],
                  ),
                ),*/
                Padding(
                  padding:
                      const EdgeInsets.only(left: 36.0, right: 36, bottom: 78),
                  child: Divider(
                    thickness: 0.8,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 28.0, right: 28, top: 0),
                  child: InkWell(
                      onTap: () async {
                        print(widget.isFb);
                        print(widget.facebookUserData);
                        try {
                          if (controller.text.trim().isEmpty) {
                            showError(
                                'Phone number', 'Phone number cannot be empty');
                          } else {
                            showCircularDialog(context);
                            await _authRepository.register(phoneNumber);
                            popToPreviousScreen(context: context);
                            pushToNextScreenWithAnimation(
                              context: context,
                              destination: OtpScreen(
                                userNumber: phoneNumber,
                                isGoogle: widget.isGoogle,
                                isSignUp: widget.isSignUp,
                                isFb: widget.isFb,
                                isPhone: widget.isPhone,
                                user: widget.user,
                                facebookUserData: widget.facebookUserData,
                              ),
                            );
                          }
                        } catch (onError) {
                          print(onError.toString());
                          popToPreviousScreen(context: context);
                          showError('Error', onError.toString());
                        }
                      },
                      child: FilledButton(
                        btnHeight: 56,
                        btnRadius: 8,
                        btnColor: button_red,
                        btnTextColor: Colors.white,
                        btnText: "Send OTP",
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

  Widget _phoneNumberWidget() {
    return InternationalPhoneNumberInput(
      textStyle: TextStyle(
          color: ThemeProvider.of(context).brightness == Brightness.light
              ? head.withOpacity(0.45)
              : Colors.white.withOpacity(0.45),
          fontWeight: FontWeight.w700,
          fontSize: 16,
          decoration: TextDecoration.none),

      //autoValidate: false,
      selectorTextStyle: TextStyle(
          fontFamily: 'Montserrat',
          color: ThemeProvider.of(context).brightness == Brightness.light
              ? head.withOpacity(0.45)
              : Colors.white.withOpacity(0.45),
          fontWeight: FontWeight.w700,
          fontSize: 16,
          decoration: TextDecoration.none),
      initialValue: number,
      autoFocusSearch: false,
      selectorConfig: SelectorConfig(
        selectorType: PhoneInputSelectorType.DIALOG,
        useEmoji: true,
      ),
      keyboardType: TextInputType.phone,

      textFieldController: controller,
      inputBorder: InputBorder.none,
      inputDecoration: InputDecoration(
        border: InputBorder.none,
        //contentPadding: EdgeInsets.only(left: 20.0),
        hintText: 'Enter Mobile Number',
        hintStyle: TextStyle(
          color: ThemeProvider.of(context).brightness == Brightness.light
              ? head.withOpacity(0.45)
              : Colors.white.withOpacity(0.45),
          fontSize: 16.0,
          decoration: TextDecoration.none,
          fontWeight: FontWeight.w500,
        ),
      ),
      /*selectorType: PhoneInputSelectorType.DIALOG,*/
      onInputChanged: (PhoneNumber value) {
        phoneNumber = value.phoneNumber;
      },
    );
  }
}
