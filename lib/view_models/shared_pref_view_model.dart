import 'dart:convert';

import 'package:food_delivery/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefProvider with ChangeNotifier {
   UserDataModel _userDataModel;

  SharedPrefProvider() {
    _userDataModel = UserDataModel();
    loadPreference();
    loadProfileSharedPreference();
  }

  void setUserData(UserDataModel userDataModel) {
    _userDataModel = userDataModel;

    notifyListeners();
  }

  saveSharedPreference(UserDataModel userDataModel) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var data = encode(userDataModel);
    pref.setString("userData", data);
    setUserData(userDataModel);
  }

  UserDataModel get userDataModel => _userDataModel;

  loadProfileSharedPreference() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    UserDataModel userProfileModel = new UserDataModel();
  }

  loadPreference() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getString("userData") != null) {
      UserDataModel userDataModel = decode(pref.getString("userData"));
      if (userDataModel != null) {
        setUserData(userDataModel);
      }
    }
  }

  clearPreference() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    UserDataModel model = new UserDataModel();
    model.isLoggedIn=false ;
    model.userId="";
    model.userNumber="";
    model.userEmail="";
    model.userName="";
    model.fullName="";
    model.authToken="";
    saveSharedPreference(model);
  }

  static String encode(UserDataModel userData) =>
      json.encode(userData.toMap(userData));

  static UserDataModel decode(String musics) {
    var response = json.decode(musics);
    final result = UserDataModel.fromJson(response);
    return result;
  }
}
