import 'dart:convert';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:food_delivery/custom_widgets/border_utton_with_image.dart';
import 'package:food_delivery/custom_widgets/custom_label.dart';
import 'package:food_delivery/custom_widgets/filled_button.dart';
import 'package:food_delivery/models/create_user_model.dart';
import 'package:food_delivery/models/login_model.dart';
import 'package:food_delivery/models/user_model.dart';
import 'package:food_delivery/repository/authentification_repository.dart';
import 'package:food_delivery/views/authentification/signup_page.dart';
import 'package:food_delivery/views/home_ui/bottom_bar_ui/bottom_bar.dart';
import 'package:food_delivery/utils/baseClass.dart';
import 'package:food_delivery/view_models/shared_pref_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../google_sign_in_api.dart';
import '../../utils/app_colors.dart';
import 'phone_verification_page.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with BaseClass {
  AuthRepository _authRepository = AuthRepository();

  @override
  Widget build(BuildContext context) {
    var sharePrefProvider = Provider.of<SharedPrefProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 36.0, right: 36, top: 151),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomLabel(
                    label: "Welcome Back!\nLogin to Comiida",
                    labelSize: 29,
                    labelColor: button_red,
                  ),
                  /* Text(
                    "Welcome Back!\nLogin to Comiida",
                    style: TextStyle(
                        fontSize: 29,
                        fontFamily: 'Montserrat',
                        color: button_red,
                        fontWeight: FontWeight.w700),
                  ),*/
                  SizedBox(
                    height: 17,
                  ),
                  CustomLabel(
                    label:
                    "Choose your preferred way to sign in.\nor just sign in manually!",
                    labelSize: 12,
                    labelColor:
                    ThemeProvider
                        .of(context)
                        .brightness == Brightness.light
                        ? head
                        : Colors.white,
                    labelWeight: FontWeight.w400,
                  ),
                  /* Text(
                    "Choose your preferred way to sign in.\nor just sign in manually!",
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Montserrat',
                        color: ThemeProvider.of(context).brightness ==
                                Brightness.light
                            ? head
                            : Colors.white,
                        fontWeight: fontWeight: FontWeight.w400),
                  ),*/
                  SizedBox(
                    height: 55,
                  ),
                  InkWell(
                      onTap: () {
                        loginFacebook(sharePrefProvider);
                        /* Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    );*/
                      },
                      child: ImageBorderButton(
                        btnText: 'Sign in using Facebook',
                        btnTextColor: Color(0xff35589D),
                        prefixImage:
                        'images/svg/iconfinder_83-facebook_4202110.svg',
                        btnBorderColor: Color(0xff35589D),
                      )
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  InkWell(
                      onTap: () {
                        googleSignIn(sharePrefProvider);
                      },
                      child: ImageBorderButton(
                        btnText: 'Sign in using Google  ',
                        btnTextColor: button_red,
                        prefixImage: 'images/svg/google-icon 2 copy.svg',
                        btnBorderColor: button_red,
                        btnFontWeight: FontWeight.w700,
                      )
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  InkWell(
                    onTap: () {
                      pushToNextScreenWithAnimation(context: context,
                          destination: VerifyPhone(isPhone: true, isSignUp:false,));
                      /*     Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            VerifyPhone(),
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
                      btnHeight: 50,
                      btnText: 'SIGN IN USING PHONE',
                      btnTextColor: Colors.white,
                      btnColor: head,
                      btnRadius: 8,
                    ) /*Container(
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
                            'SIGN IN USING PHONE',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    )*/
                    ,
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
                            "Don't have an account?",
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Montserrat',
                                color: ThemeProvider
                                    .of(context)
                                    .brightness ==
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
                              popToPreviousScreen(context: context);
                       /*       Navigator.of(context).push(PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                    Signup(),
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
                              ));*/
                            },
                            child: Text(
                              "Sign up",
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

  void loginFacebook(SharedPrefProvider sharePrefProvider) async {
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
        callLoginWithEmailApi(profile['email'], sharePrefProvider);
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



  /*  var facebookLogin = FacebookLogin();

    facebookLogin.logOut();

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

      print(facebookLoginResult.status);

      final token = facebookLoginResult.accessToken.token;

      /// for profile details also use the below code
      final graphResponse = await http.get(_getUrl(
          'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=$token'));
      final profile = json.decode(graphResponse.body);
      print(profile['email']);
      callLoginWithEmailApi(profile['email'], sharePrefProvider);
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

  Future googleSignIn(SharedPrefProvider sharePrefProvider) async {
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
      callLoginWithEmailApi(user.email.toString(), sharePrefProvider);
    }
  }

  void callLoginWithEmailApi(String email,
      SharedPrefProvider sharePrefProvider) async {
    try {
      String emailSent = email + ':' + 'testing';
      print(emailSent);
      var bytes =
      utf8.encode(emailSent);
      var base64Str = base64.encode(bytes);
      print(base64Str);
      showCircularDialog(context);
      LoginModel loginModel = await _authRepository.loginWithEmail(base64Str);

      print(loginModel.userID);
      UserDataModel userModel = new UserDataModel();
      userModel.setUserId(loginModel.userID.toString());
      userModel.setUserEmail(email);
      userModel.setLogin(true);
      sharePrefProvider
          .saveSharedPreference(userModel);
      popToPreviousScreen(context: context);
      pushReplaceAndClearStack(
          context: context,
          destination: BottomBar());
    }
    catch (error) {
      popToPreviousScreen(context: context);
      showError('', error.toString());
    }
  }
}
