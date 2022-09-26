import 'dart:convert';

import 'package:food_delivery/utils/baseClass.dart';
import 'package:food_delivery/views/authentification/onboarding_page.dart';
import 'package:food_delivery/views/home_ui/automatic_location/automatic_location_page.dart';
import 'package:food_delivery/views/home_ui/bottom_bar_ui/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/user_model.dart';

class SplashPage extends StatelessWidget with BaseClass{
  checkLogin(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String prefData = prefs.getString("userData");
    if (prefData != null) {
      var response = json.decode(prefData);
      var result = UserDataModel.fromJson(
          json.decode(prefs.getString("userData")));
      print(result.isLoggedIn);
      if (result.isLoggedIn == null || result.isLoggedIn == false) {

        pushReplaceAndClearStack(
          context: context,
          destination: /*OnBoarding*/OnBoardingPage/*AutomaticLocationPage*/(),
        );
      } else {

        pushReplaceAndClearStack(
          context: context,
          destination: BottomBar(),
        );
      }
    } else {
      pushReplaceAndClearStack(
        context: context,
        destination: /*OnBoarding*/OnBoardingPage(),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    checkLogin(context);
    return Container();
  }
}
