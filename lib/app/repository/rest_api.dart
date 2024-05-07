import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' as https;
import 'package:vloo/app/data/models/common/common_response.dart';
import 'package:vloo/app/data/utils/singleton.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/routes/app_pages.dart';

class RestAPI {
  final GetConnect connect = Get.find<GetConnect>();

  //GET request example
  Future<dynamic> getDataMethod(String url, Map<String, String> header, Map<String, dynamic>? query) async {
    Response response = await connect.get(url, headers: header, contentType: "application/json; charset=utf-8", query: query);

    if (response.statusCode == 200) {
      return response.body;
    } else if (response.statusCode == 401) {
      // Un authorized -> Go to login screen
      toLogin();
    } else if (response.statusCode == null) {
      // Un authorized -> Go to login screen
      Singleton.errorResponse?.message = response.statusText;
      return null;
    } else {
      Singleton.errorResponse?.message = response.body["message"];
      return null;
    }
  }

  //post request example
  Future<dynamic> postDataMethod(String url, Map<String, String> header, Map<String, dynamic> params) async {
    Response response = await connect.post(url, params, headers: header);

    if (response.statusCode == 200) {
      return response.body;
    } else if (response.statusCode == 401) {
      // Un authorized -> Go to login screen
      toLogin();
    } else {
      Singleton.errorResponse?.message = response.body["message"];
      return null;
    }
  }

  //post request raw body example
  Future<dynamic> postRawDataMethod(String url, Map<String, String> header, dynamic params) async {
    Response response = await connect.post(url, params, headers: header);

    if (response.statusCode == 200) {
      return response.body;
    } else if (response.statusCode == 401) {
      // Un authorized -> Go to login screen
      toLogin();
    } else {
      Singleton.errorResponse?.message = response.body["message"];
      return null;
    }
  }

//post request example
  Future<String?> postMultipartMethod(String url, List<https.MultipartFile>? multipartFiles, Map<String, String> body, bool isResultNeeded) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll(Singleton.header);
    request.fields.addAll(body);

    // add file
    if (multipartFiles != null) {
      request.files.addAll(multipartFiles);
    }

    var response = await request.send().timeout(const Duration(seconds: 90), onTimeout: () {
      throw Exception("Request Time Out");
    });

    CommonResponse? commonResponse;
    await response.stream.transform(utf8.decoder).listen((value) {
      commonResponse = CommonResponse.fromJson(json.decode(value));
    });

    if (response.statusCode == 200 && commonResponse?.status == 200) {
      if (isResultNeeded) {
        return commonResponse?.result.toString();
      } else {
        return commonResponse?.message ?? Strings.success;
      }
    } else if (response.statusCode == 401) {
      // Un authorized -> Go to login screen
      toLogin();
    } else {
      Singleton.errorResponse?.message = commonResponse?.message ?? response.reasonPhrase;
      return null;
    }
  }

  // redirection to login
  void toLogin() {
    Get.offAllNamed(Routes.login);
  }
}
