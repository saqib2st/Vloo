import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vloo/app/data/configs/api_config.dart';
import 'package:vloo/app/data/models/login/Login_response.dart';
import 'package:vloo/app/data/utils/singleton.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/data/utils/utils.dart';
import 'package:vloo/app/modules/forgotPassword/controllers/forgot_password_controller.dart';
import 'package:vloo/app/modules/forgotPassword/views/forgot_password_view.dart';
import 'package:vloo/app/modules/templates/views/Widget/app_loader.dart';
import 'package:vloo/app/repository/rest_api.dart';
import 'package:vloo/app/routes/app_pages.dart';
import 'package:vloo/main.dart';

class LoginController extends GetxController {
  final RestAPI restAPI = Get.find<RestAPI>();
  final GetStorage storage = Get.find<GetStorage>();
  RxBool showPass = true.obs;
  final formKey = GlobalKey<FormState>();

  String userNameValue = "";
  String passwordValue = "";

  // password check
  void showPassToggle() {
    showPass.toggle();
  }

  Future<void> doLogin(String userName, String password) async {
    if(userNameValue.isEmpty ){
       scaffoldKey.currentState?.showSnackBar(const SnackBar(content: Text('Please enter the email')));

    }else if (validateEmail(userName)!= null ) {
       scaffoldKey.currentState?.showSnackBar(const SnackBar(content: Text('Please Enter a valid email')));
    }
    else if (passwordValue.isEmpty) {
       scaffoldKey.currentState?.showSnackBar(const SnackBar(content: Text('Please enter the password')));
    }
    else {

AppLoader.showLoader();
      var header = {'Content-type': 'application/json; charset=utf-8', 'Accept': 'application/json; charset=utf-8'};
      var params = {'email': userName, 'password': password};

      var response = await restAPI.postDataMethod(ApiConfig.loginURL, header, params);
      if (response != null) {
        try {
          LoginResponse loginResponse = LoginResponse.fromJson(response);
          if (loginResponse.status == 200) {
            Singleton.token = loginResponse.result?.token ?? "";
            Singleton.header = {
              "Authorization": "Bearer ${Singleton.token}",
              "Content-Type": "application/json",
              "Accept": "application/json",
            };
            Singleton.userObject = loginResponse.result?.user;

            storage.write(Strings.token, loginResponse.result?.token ?? "");
            storage.write(Strings.user, jsonEncode(loginResponse.result?.user ?? ""));
            storage.write(Strings.userEmail, loginResponse.result?.user?.email ?? "");

            if (Singleton.token.isNotEmpty) {
              AppLoader.hideLoader();
              toHome();
            } else {
            AppLoader.hideLoader();
            // scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(2, loginResponse.message ?? Strings.success));
            print(loginResponse.message);
          }

            print(loginResponse.message);
          } else {
            AppLoader.hideLoader();
            // scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(2, loginResponse.message ?? Strings.success));
            print(loginResponse.message);
          }
         // scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(2, loginResponse.message ?? Strings.success));
        } on Exception catch (_) {
          // TODO: Here show the error message that comes from server

          AppLoader.hideLoader();
          scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(3, response["message"]));
          print(response);
          rethrow;
        }
      } else {
        AppLoader.hideLoader();
        scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(3, Singleton.errorResponse?.message ?? Strings.somethingWentWrong));
      }
    }
  }

  String? validateEmail(String value) {
    if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  // redirection to signup
  void toSignup() {
    Get.offAllNamed(Routes.signup);
  }

  // redirection to Introduction
  void toIntroduction() {
    Get.offNamed(Routes.introduction);
  }

  // redirection to ForgotPassword
  void toForgotPassword() {
    Get.put<ForgotPasswordController>(ForgotPasswordController());
    Get.to(const ForgotPasswordView());
  }

  // redirection to signup
  void toHome() {
    Get.offAllNamed(Routes.bottomNav);
  }
}
