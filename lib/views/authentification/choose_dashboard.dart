import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:food_delivery/custom_widgets/border_button.dart';
import 'package:food_delivery/custom_widgets/custom_label.dart';
import 'package:food_delivery/custom_widgets/filled_button.dart';
import 'package:food_delivery/views/authentification/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

import '../home_ui/bottom_bar_ui/bottom_bar.dart';
import '../../utils/app_colors.dart';
import 'signup_page.dart';

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timestamp) {
      // do stuff after frame is build

      setState(() {
        timeDilation = 1;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 101.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 35.0, right: 35),
                    child: Container(
                      height: 390,
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: 10,
                            left: 0,
                            right: 0,
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: ThemeProvider.of(context)
                                                  .brightness ==
                                              Brightness.light
                                          ? Colors.white
                                          : Color(0xFF222C44),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(14),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.07),
                                            spreadRadius: 16,
                                            blurRadius: 20,
                                            offset: Offset(0, 7))
                                      ]),
                                  height: 356,
                                  width: 258,
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: 22,
                            left: 0,
                            right: 0,
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: ThemeProvider.of(context)
                                                  .brightness ==
                                              Brightness.light
                                          ? Colors.white
                                          : Color(0xFF222C44),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(14),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.07),
                                            spreadRadius: 16,
                                            blurRadius: 20,
                                            offset: Offset(0, 7))
                                      ]),
                                  height: 356,
                                  width: 290,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: ThemeProvider.of(context).brightness ==
                                        Brightness.light
                                    ? Colors.white
                                    : Color(0xFF222C44),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(14),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.07),
                                      spreadRadius: 16,
                                      blurRadius: 20,
                                      offset: Offset(0, 7))
                                ]),
                            height: 356,
                            width: 306,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'images/love burger1.png',
                                  height: 214,
                                  width: 160,
                                ),
                                SizedBox(
                                  height: 19,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 18.0, right: 18),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: CustomLabel(
                                          label:
                                              'Comiida helps you find all you favorite restaurants near you.',
                                          labelColor: ThemeProvider.of(context)
                                                      .brightness ==
                                                  Brightness.light
                                              ? head
                                              : Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => BottomBar()),
                            (Route<dynamic> route) => false);
                      },
                      child: CustomLabel(
                        label: 'SKIP',
                        labelColor: button_red,
                      )),
                  SizedBox(
                    height: 55,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            Signup(),
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
                    child: Padding(
                      padding: const EdgeInsets.only(left: 24.0, right: 24),
                      child: FilledButton(
                        btnTextColor: Colors.white,
                        btnText: 'SIGN UP',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 19,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            Login(),
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
                    child: Padding(
                      padding: const EdgeInsets.only(left: 24.0, right: 24),
                      child: BorderButton(
                        btnText: 'SIGN IN',
                        btnBorderColor: button_red,
                        btnTextColor: button_red,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
