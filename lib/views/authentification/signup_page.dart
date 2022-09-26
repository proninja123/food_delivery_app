

import 'dart:convert';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:food_delivery/repository/authentification_repository.dart';
import 'package:food_delivery/utils/app_colors.dart';
import 'package:food_delivery/utils/baseClass.dart';
import 'package:food_delivery/views/authentification/phone_verification_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_svg/svg.dart';

import 'package:http/http.dart' as http;
import '../../google_sign_in_api.dart';
import 'login_page.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> with BaseClass {
  AuthRepository _authRepository = AuthRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 36.0, right: 36, top: 151),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome!\nLet's get started.",
                    style: TextStyle(
                        fontSize: 29,
                        fontFamily: 'Montserrat',
                        color: button_red,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 17,
                  ),
                  Text(
                    "Choose your preferred way to sign up.\nor just sign up manually!",
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
                    height: 55,
                  ),
                  InkWell(
                    onTap: () async {
                      loginFacebook();
                      /* Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    );*/
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        border: Border.all(color: Color(0xff35589D), width: 2),
                        color: Colors.white,
                      ),
                      height: 48,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'images/svg/iconfinder_83-facebook_4202110.svg',
                                matchTextDirection: true,
                                color: Color(0xff35589D),
                                height: 19,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                'Sign up using Facebook',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Color(0xff35589D),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  InkWell(
                    onTap: () {
                      googleSignIn();
                      /* Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    );*/
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        border: Border.all(color: button_red, width: 2),
                        color: Colors.white,
                      ),
                      height: 48,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'images/svg/google-icon 2 copy.svg',
                                matchTextDirection: true,
                                color: button_red,
                                height: 19,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                'Sign up using Google  ',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: button_red,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            VerifyPhone(
                          isPhone: true,
                          user: null,
                        ),
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
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: head,
                      ),
                      height: 50,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'SIGN UP USING PHONE',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 180,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account?",
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Montserrat',
                                color: ThemeProvider.of(context).brightness ==
                                        Brightness.light
                                    ? head
                                    : Colors.white,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        Login(),
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
                            child: Text(
                              "Login here",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Montserrat',
                                  color: button_red,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
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

  Future googleSignIn() async {
    GoogleSignInAPi.logout();
    final user = await GoogleSignInAPi.login();
    if (user == null) {
      print('USer is null');
    } else {
      print(user.displayName);
      print('NAMEEEEEEEEEE');
      print(user.id.toString());
      print('IDDDDDDDD');
      print(user.email.toString());
      print(user.photoUrl.toString());
      pushToNextScreenWithAnimation(
        context: context,
        destination: VerifyPhone(
          isGoogle: true,
          user: user,
        ),
      );
    }
  }

  void loginFacebook() async {
    final facebookLogin = FacebookLogin();
    facebookLogin.loginBehavior = FacebookLoginBehavior.webOnly;
    final result = await facebookLogin.logInWithReadPermissions(['email']);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        print(result.accessToken);
        print(result.accessToken.token);
        print(result.accessToken.expires);
        print(result.accessToken.permissions);
        print(result.accessToken.userId);
        final token = result.accessToken.token;

        /// for profile details also use the below code
        final graphResponse = await http.get(_getUrl(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=$token'));
        final profile = json.decode(graphResponse.body);
        print(profile['email']);
        pushToNextScreenWithAnimation(
          context: context,
          destination: VerifyPhone(
            isFb: true,
            facebookUserData: profile,
          ),
        );
        /*_sendTokenToServer(result.accessToken.token);
        _showLoggedInUI();*/
        break;
      case FacebookLoginStatus.cancelledByUser:
        showError('Error', 'FACEBOOK LOGIN CANCELLED');
       // _showCancelledMessage();
        break;
      case FacebookLoginStatus.error:
        showError('Error', 'FACEBOOK LOGIN AUTHORIZATION ERROR');
     //   _showErrorOnUI(result.errorMessage);
        break;
    }
    /*  final facebookLogin = FacebookLogin();
    final facebookLoginResult = await facebookLogin.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email
    ]);
    if (facebookLoginResult.status == FacebookLoginStatus.success) {
      print(facebookLoginResult.accessToken);
      print(facebookLoginResult.accessToken.token);
      print(facebookLoginResult.accessToken.expires);
      print(facebookLoginResult.accessToken.permissions);
      print(facebookLoginResult.accessToken.userId);
      *//*print(facebookLoginResult.accessToken.isValid());

    print(facebookLoginResult.errorMessage);*//*
      print(facebookLoginResult.status);

      final token = facebookLoginResult.accessToken.token;

      /// for profile details also use the below code
      final graphResponse = await http.get(_getUrl(
          'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=$token'));
      final profile = json.decode(graphResponse.body);
      print(profile['email']);
      pushToNextScreenWithAnimation(
        context: context,
        destination: VerifyPhone(
          isFb: true,
          facebookUserData: profile,
        ),
      );
    } else if (facebookLoginResult.status == FacebookLoginStatus.cancel) {
      showError('Error', 'FACEBOOK LOGIN CANCELLED');
    } else if (facebookLoginResult.status == FacebookLoginStatus.error) {
      print(facebookLoginResult.error.toMap());
      showError('Error', 'FACEBOOK LOGIN AUTHORIZATION ERROR');
    }*/

  }

  Uri _getUrl(String url) {
    return Uri.parse(url);
  }
}
