import 'dart:convert';
import 'dart:io';

import 'package:food_delivery/models/apis/app_exception.dart';
import 'package:food_delivery/models/autocomplete_location/auto_compelte_location_model.dart';
import 'package:flutter/foundation.dart';

import '../api_service.dart';
import 'package:http/http.dart' as http;
class LocationAutoCompleteService {


  final String baseUrl =
      'https://maps.googleapis.com/maps/api/place/autocomplete/json?';

  Uri _getUrl(String inputString) {
    return Uri.parse(baseUrl + 'input=$inputString&radius=100000&types=geocode&language=en&key=AIzaSyCJTzg3gjHZrlrTDDecgRJUMwipOuxpFqU');
  }


  /// Get OnBoarding Data
  Future<AutocompleteLocationResponse> getAutoCompleteResponse(String searchText) async {
    try {
      dynamic response = await _get(
        searchText,
      );

      AutocompleteLocationResponse data ;

      data =  AutocompleteLocationResponse.fromJson(response);


      return data;

    } catch (onError) {
      print("Error");
      throw onError.toString();
    }
  }

  Future<dynamic> _get(String toBeSearchedString) async {
    dynamic responseJson;

    try {
      var response;

      response = await http.get(_getUrl(toBeSearchedString));

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @visibleForTesting
  dynamic returnResponse(http.Response response) {
    dynamic responseJson = jsonDecode(response.body);
    print(response.body.toString());

    int statusCode;

    statusCode = response.statusCode;

    switch (/*response.statusCode*/ statusCode) {
      case 200:
      /*dynamic responseJson = jsonDecode(response.body);*/
        return responseJson;
      case 400:
        throw BadRequestException(/*response.body.toString()*/
            responseJson['Message']);
      case 401:
        throw BadRequestException(/*response.body.toString()*/
            responseJson['Message']);
      case 403:
        throw UnauthorisedException(/*response.body.toString()*/
            responseJson['Message']);
      case 500:
        throw UnauthorisedException(/*response.body.toString()*/
            responseJson['Message']);
      case 404:
        throw BadRequestException(/*response.body.toString()*/
            responseJson['Message']);
      default:
        throw FetchDataException(
            'Error occured while communication with server' +
                ' with status code : ${response.statusCode}');
    }
  }
}