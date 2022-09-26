import 'dart:ui';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:food_delivery/controllers/onboarding_controllers.dart';
import 'package:food_delivery/custom_widgets/custom_label.dart';
import 'package:food_delivery/custom_widgets/filled_button.dart';
import 'package:food_delivery/models/on_boarding_model.dart';
import 'package:food_delivery/repository/authentification_repository.dart';
import 'package:food_delivery/utils/app_colors.dart';
import 'package:food_delivery/utils/app_images.dart';
import 'package:food_delivery/utils/baseClass.dart';
import 'package:food_delivery/views/home_ui/bottom_bar_ui/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'signup_page.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> with BaseClass {
  int _current = 0;

  AuthRepository _authRepository = AuthRepository();
  List<Widget> imageSliders = [];

  getLandingPage() async {
    List<OnBoardingPageModel> onBoardingPageModel =
        await _authRepository.getLandingPage();
    for (int i = 0; i < onBoardingPageModel.length; i++) {
      imageSliders.add(
        Column(
          children: [
            Expanded(
              child: Container(
                height: 160,
                width: 214,
                child: Image(
                  image: /*AssetImage(
                      on_boarding) */NetworkImage(onBoardingPageModel.elementAt(i).image),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              margin: EdgeInsets.only(left: 16, right: 16),
              child: Text(
                onBoardingPageModel.elementAt(i).title,
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  color: button_red,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 16, right: 16),
              child: Text(
                onBoardingPageModel.elementAt(i).text,
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                    color:
                        ThemeProvider.of(context).brightness == Brightness.light
                            ? head
                            : Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
            )
          ],
        ),
      );
    }
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLandingPage();
  }

  //final OnBoardingController onBoardingController = Get.put(OnBoardingController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: imageSliders.length > 0
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        CarouselSlider(
                          items: imageSliders,
                          options: CarouselOptions(
                              autoPlay: true,
                              height: Get.height * 0.40,
                              viewportFraction: 1.0,
                              enlargeCenterPage: false,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _current = index;
                                });
                              }),
                        ),
                        SizedBox(
                          height: 29,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: imageSliders.map((url) {
                            int index = imageSliders.indexOf(url);
                            return Container(
                              width: _current == index ? 5.0 : 4.0,
                              height: _current == index ? 5.0 : 4.0,
                              margin: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 4.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(8),
                                color: _current == index
                                    ? button_red
                                    : Colors.grey.shade400,
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            pushToNextScreenWithAnimation(
                                context: context, destination: Signup());
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: FilledButton(
                              btnTextColor: Colors.white,
                              btnText: 'LOGIN/SIGN UP',
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
                      ],
                    ),
                  ],
                )
              : Center(
                  child: Container(
                    height: 30,
                    width: 30,
                    child: CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(
                        Colors.red,
                      ),
                    ),
                  ),
                )),
    );
  }
}
