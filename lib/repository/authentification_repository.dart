import 'dart:convert';

import 'package:food_delivery/models/create_user_model.dart';
import 'package:food_delivery/models/login_model.dart';
import 'package:food_delivery/models/login_with_number_model.dart';
import 'package:food_delivery/models/on_boarding_model.dart';
import 'package:food_delivery/services/api_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  ApiService _apiService = ApiService();

  /// Get OnBoarding Data
  Future<List<OnBoardingPageModel>> getLandingPage() async {
    try {
      dynamic response = await _apiService.get(
        'inapp/carousel',
      );

      List<OnBoardingPageModel> data = [];

      data = (response as List).map(
              (jsonElement) => OnBoardingPageModel.fromJson(jsonElement)
      ).toList();

      return data;
     
    } catch (onError) {
      print("Error");
      throw onError.toString();
    }
  }

  /// Login
  Future<LoginWithPhoneModel> loginWithPhoneNumber(String phoneNumber) async {
    try {
      print(phoneNumber);
      dynamic response = await _apiService.get(
        'user/otplogin/' + phoneNumber,
      );
      print(response);
      // final jsonData = response['responseData'];
      // print(jsonData);
      LoginWithPhoneModel loginWithPhoneModel =
          LoginWithPhoneModel.fromJson(response);
      return loginWithPhoneModel;
    } catch (onError) {
      print("Error");
      throw onError.toString();
    }
  }

  /// Register
  Future<void> register(String phoneNumber) async {
    try {
      dynamic response = await _apiService.get(
        'user/OTPSetup/' + phoneNumber,
      );
      final jsonData = response['responseData'];
      print(jsonData);
    } catch (error) {
      print("Error");
      throw error.toString();
    }
  }

  /// Confirm OTP
  Future<void> confirmOtp(String encodedOtp) async {
    try {
      dynamic response = await _apiService.get(
        'user/otpconfirm/' + encodedOtp,
      );
      String code = response['Code'];
      if (code == '0') {
        throw response['Message'];
      }
    } catch (error) {
      print("Error");
      throw error.toString();
    }
  }

  /// RegCreate uster user with Social media
  Future<CreateUserModel> createUserWithSocialMedia(
    Map<String, String> param,
  ) async {
    print(param);
    try {
      dynamic response =
          await _apiService.post('user/createuser', params: param);
      CreateUserModel createUserModel = CreateUserModel.fromJson(response);
      return createUserModel;
      print(response);
    } catch (error) {
      print(error.toString());
      throw error.toString();
    }
  }

  /// Login with email
  Future<LoginModel> loginWithEmail(String encodedEmailPassword) async {
    try {
      dynamic response = await _apiService.get(
        'user/emailogin/' + encodedEmailPassword,
      );
      LoginModel loginModel = LoginModel.fromJson(response);
      return loginModel;
      print(response);
    } catch (error) {
      print(error.toString());
      throw error.toString();
    }
  }

  /// Change password
  Future<void> changePassword(String methodName, Map<String, String> param,
      Map<String, String> header) async {
    try {
      dynamic response =
          await _apiService.post(methodName, params: param, headerMap: header);
      final jsonData = response['responseData'];
      print(jsonData);
    } catch (onError) {
      print(onError);
      throw onError.toString();
    }
  }

  /// Change notification type
  Future<void> updateNotificationStatus({
    Map<String, dynamic> param,
    Map<String, String> headerMap,
  }) async {
    dynamic response =
        await _apiService.post('', params: param, headerMap: headerMap);
    final jsonData = response['responseData'];
    print(jsonData);
  }

  /// Update Email notification type
  Future<void> updateEmailNotificationStatus({
    Map<String, dynamic> param,
    Map<String, String> headerMap,
  }) async {
    dynamic response =
        await _apiService.post('', params: param, headerMap: headerMap);
    final jsonData = response['responseData'];
    print(jsonData);
  }

  ///  GET NOTIFICATION STATUS
  Future< /*NotificationDataModel*/ void> getNotifications(
      {Map<String, String> header}) async {
    dynamic response = await _apiService.get("", headerMap: header);
    final jsonData = response['responseData'];
    // return NotificationDataModel.fromJson(response);
  }

  ///  forgot password
  Future<void> forgotPassword(Map<String, dynamic> param) async {
    try {
      dynamic response = await _apiService.post('', params: param);
      final jsonData = response['responseData'];
      print(jsonData);
    } catch (error) {
      throw error;
    }
  }

  /// logout
  Future<void> logoutApi(String methodName, Map<String, dynamic> param) async {
    dynamic response = await _apiService.post(methodName, params: param);
    final jsonData = response['responseData'];
    print(jsonData);
  }

  /// Home Banner Api
  Future< /*HomeBannerModel*/ void> homeBannerApi(String methodName,
      {Map<String, String> header}) async {
    print(header);

    dynamic response = await _apiService.get(methodName, headerMap: header
        //   params: param,
        );
    // final jsonData = response['responseData'];
    // print(jsonData);
    // HomeBannerModel homeBannerModel = HomeBannerModel.fromJson(response);
    // return homeBannerModel;
  }

  /// Home Products Api
  Future< /*HomeProductsModel*/ void> homeProductsApi(
    String methodName,
    Map<String, String> param,
    Map<String, String> header,
  ) async {
    print(header);
    print(param);
    print(methodName);
    dynamic response =
        await _apiService.post(methodName, params: param, headerMap: header);
    // final jsonData = response['responseData'];
    // print(jsonData);
    //HomeProductsModel homeProductsModel = HomeProductsModel.fromJson(response);
    // return homeProductsModel;
  }

  /// Product Details Api
  Future< /*ProductDetailModel*/ void> getProductDetailsApi(
    Map<String, String> param,
    Map<String, String> header,
  ) async {
    print(header);
    print(param);
    dynamic response =
        await _apiService.post("", params: param, headerMap: header);
    // final jsonData = response['responseData'];
    // print(jsonData);
    /*  ProductDetailModel productDetailModel =
        ProductDetailModel.fromJson(response);*/
    //  return productDetailModel;
  }

  /// ADD TO FAV
  Future<void> addToFav(
    String methodName,
    Map<String, String> param,
    Map<String, String> header,
  ) async {
    print(header);
    print(param);
    print(methodName);
    dynamic response =
        await _apiService.post(methodName, params: param, headerMap: header);
    // final jsonData = response['responseData'];
    // print(jsonData);
  }

  /// REMOVE FROM FAV

  Future<void> removeFromFav(
    String methodName,
    Map<String, String> param,
    Map<String, String> header,
  ) async {
    print(header);
    print(param);
    print(methodName);
    dynamic response =
        await _apiService.post(methodName, params: param, headerMap: header);
    // final jsonData = response['responseData'];
    // print(jsonData);
  }

  ///  GET Favourite List

  Future< /*HomeProductsModel*/ void> getFavList(
    Map<String, String> header,
  ) async {
    print(header);
    try {
      dynamic response = await _apiService.get("", headerMap: header);
      /*    HomeProductsModel homeProductsModel =
          HomeProductsModel.fromJson(response);*/
      //  return homeProductsModel;
      // final jsonData = response['responseData'];
      // print(jsonData);
    } catch (onError) {
      print(onError);
    }
  }

  /// Get User Profile

  Future< /*UserProfileModel*/ void> getUserProfile(
    Map<String, String> header,
  ) async {
    print(header);
    dynamic response = await _apiService.get("", headerMap: header);
    // UserProfileModel userProfileModel = UserProfileModel.fromJson(response);
    //return userProfileModel;
    // final jsonData = response['responseData'];
    // print(jsonData);
  }

  /// Set Profile
  Future<void> setUserProfile(
      Map<String, String> header, Map<String, dynamic> body) async {
    print(header);
    print(body);
    dynamic response = await _apiService.post("setProfileByUserId",
        headerMap: header, params: body);

    // final jsonData = response['responseData'];
    // print(jsonData);
  }

  /// Get Seller Profile Data APi
  Future< /*SellerProfileDetailModel*/ void> getSellerProfileApi(
      Map<String, String> header, Map<String, dynamic> body) async {
    try {
      print(body);
      print(header);
      dynamic response =
          await _apiService.post("", params: body, headerMap: header);
      /*SellerProfileDetailModel sellerProfileDetailModel =
          SellerProfileDetailModel.fromJson(response);
      return sellerProfileDetailModel;*/
      // final jsonData = response['responseData'];
      // print(jsonData);
    } catch (error) {
      throw error;
    }
  }
}
