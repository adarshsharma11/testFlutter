import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:uzuri/model/Response.dart';

import '../customException.dart';

class Api {
  final _baseUrl = "http://uzuriadmin.co.za/api/";

  Future<Response> post(String url, Map body) async {
    Response response = Response();
    try {
      final http.Response res = await http.post(
        _baseUrl + url,
        body: body,
      );
      response = _responseCode(res);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return response;
  }

  Future<Response> get(String url) async {
    Response response = Response();
    try {
      final http.Response res = await http.post(
        _baseUrl + url,
      );
      response = _responseCode(res);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return response;
  }

  dynamic _responseCode(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return Response.fromJson(json.decode(response.body));
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:

      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:

      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
