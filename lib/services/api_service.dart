import 'dart:convert';
import 'dart:io';
import 'package:food_delivery/models/apis/app_exception.dart';
import 'package:meta/meta.dart';

import 'package:http/http.dart' as http;


class ApiService {
  final String _baseUrl = "https://comiida.com/appapi/";

  Uri _getUrl(String methodName) {
    return Uri.parse(_baseUrl + methodName);
  }

  Future<dynamic> get(String url, {Map<String, String> headerMap}) async {
    dynamic responseJson;
    print(_getUrl(url));
    try {
      var response;
      if (headerMap == null) {
        response = await http.get(_getUrl(url));
      } else {
        response = await http.get(_getUrl(url), headers: headerMap);
      }
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  Future<dynamic> post(String url,
      {Map<String, dynamic> params, Map<String, String> headerMap}) async {
    dynamic responseJson;
    print(_getUrl(url));
    try {
      if (params == null) {
        throw FetchDataException('Parameters cannot be null');
      }
      var response;
      if (headerMap == null) {
        response = await http.post(_getUrl(url), body: params);
      } else {
        response =
            await http.post(_getUrl(url), body: params, headers: headerMap);
      }
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
