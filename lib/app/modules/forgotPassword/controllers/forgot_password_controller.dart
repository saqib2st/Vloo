import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vloo/app/data/configs/api_config.dart';
import 'package:vloo/app/data/models/common/common_response.dart';
import 'package:vloo/app/data/utils/singleton.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/data/utils/utils.dart';
import 'package:vloo/app/modules/forgotPassword/views/new_password.dart';
import 'package:vloo/app/modules/forgotPassword/views/verify_pin.dart';
import 'package:vloo/app/modules/templates/views/Widget/app_loader.dart';
import 'package:vloo/app/repository/rest_api.dart';
import 'package:vloo/app/routes/app_pages.dart';
import 'package:vloo/main.dart';

class ForgotPasswordController extends GetxController {
  RxBool showPass = true.obs;
  RxBool showConfirmPass = true.obs;
  final RestAPI restAPI = Get.find<RestAPI>();
  final formKey = GlobalKey<FormState>();

  String token = "";
  String email = "";
  String passwordValue = "";
  String confirmPasswordValue = "";

  bool verifiedCheck = false;
  TextEditingController codeTC = TextEditingController();

  void showPassToggle() {
    showPass.toggle();
  }

  void showConfirmPassToggle() {
    showConfirmPass.toggle();
  }

  String? validateEmail(String value) {
    if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  Future<void> sendEmail(String email) async {
    if (email.isEmpty || validateEmail(email) != null) {
      // scaffoldKey.currentState?.showSnackBar(const SnackBar(content: Text(Strings.enterYourEmail)));
    } else {
      AppLoader.showLoader();
      var header = {'Content-type': 'application/json; charset=utf-8', 'Accept': 'application/json; charset=utf-8'};
      var params = {'email': email};

      var response = await restAPI.postDataMethod(ApiConfig.passwordResetLinkURL, header, params);
      if (response != null) {
        try {
          CommonResponse emailResponse = CommonResponse.fromJson(response);
          if (emailResponse.status == 200){
            Singleton.email = email;
            Singleton.code = emailResponse.resetPasswordCode;
            AppLoader.hideLoader();
            toConfirmCode();
          }else{
            AppLoader.hideLoader();
            // scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(2, emailResponse.message ?? Strings.success));
          }
          print(emailResponse.message);
        } on Exception catch (_) {
          // TODO: Here show the error message that comes from server
          AppLoader.hideLoader();
          // scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(3, response["message"]));
          print(response);
          rethrow;
        }
      } else {
        AppLoader.hideLoader();
        // scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(3, Singleton.errorResponse?.message ?? Strings.somethingWentWrong));
      }

    }

  }

  // redirection to NewPassword
  void toConfirmCode() {
    Get.to(const VerifyPin());
  }

  // // redirection to Login
  void toLogin() {
    Get.offAllNamed(Routes.login);
  }

///////////////////////////////////////////////////  Confirm Code screen //////////////////////////////////////////

  // redirection to NewPassword
  void toNewPassword() {
    Get.to(const NewPassword());
  }

  void validatePinCode(String value) {
    if (value != Singleton.code.toString()) {
      // scaffoldKey.currentState?.showSnackBar(const SnackBar(content: Text("Your code is incorrect or expired.")));
    }else{
      // scaffoldKey.currentState?.showSnackBar(const SnackBar(content: Text("Code Verified.")));
      toNewPassword();
    }
  }


///////////////////////////////////////////////////  New Password screen //////////////////////////////////////////

  String? validatePassword(String value) {
    if (passwordValue.isEmpty) {
      return 'Enter a valid password';
    }
    if (confirmPasswordValue.isEmpty) {
      return 'Please enter confirm password ';
    }

    if (confirmPasswordValue != passwordValue) {
      return 'Both passwords do not match ';
    }
    return null;
  }

  bool showSnackBarError() {
    String errorMessage = "";

    if (Singleton.email == null || Singleton.email!.isEmpty || Singleton.code == null) {
      errorMessage = "Link is not valid anymore. Please try again";
    } else if (passwordValue.isEmpty || passwordValue.length < 8) {
      errorMessage = "Password length must be greater than 8 characters";
    } else if (passwordValue != confirmPasswordValue) {
      errorMessage = "Both passwords do not match.";
    }
    if(errorMessage.isNotEmpty){
      // scaffoldKey.currentState?.showSnackBar(SnackBar(content: Text(errorMessage)));
    }
    return errorMessage.isNotEmpty;
  }

  Future<void> resetPasswordAPI(String token, String email, String password, String confirmPassword) async {
    if (!showSnackBarError()) {
      AppLoader.showLoader();
      var header = {'Content-type': 'application/json; charset=utf-8', 'Accept': 'application/json; charset=utf-8'};
      var params = {'reset_code': Singleton.code.toString(), 'email': Singleton.email, 'password': password, 'password_confirmation': confirmPassword};

      var response = await restAPI.postDataMethod(ApiConfig.passwordResetURL, header, params);
      if (response != null) {
        try {
          CommonResponse loginResponse = CommonResponse.fromJson(response);
          if (loginResponse.status == 200 && loginResponse.message == "Password reset successfully") {
            AppLoader.hideLoader();
            toLogin();
          }else{
            AppLoader.hideLoader();
            // scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(2, loginResponse.message ?? Strings.success));
          }

          print(loginResponse.message);
        } on Exception catch (_) {
          // TODO: Here show the error message that comes from server
          AppLoader.hideLoader();
          // scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(3, response["message"]));
          print(response);
          rethrow;
        }
      } else {
        AppLoader.hideLoader();
        // scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(3, Singleton.errorResponse?.message ?? Strings.somethingWentWrong));
      }
    }
  }
}
