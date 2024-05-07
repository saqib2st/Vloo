import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vloo/app/data/configs/api_config.dart';
import 'package:vloo/app/data/models/common/common_response.dart';
import 'package:vloo/app/data/models/login/User.dart';
import 'package:vloo/app/data/utils/singleton.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/data/utils/utils.dart';
import 'package:vloo/app/data/utils/zbot_toast.dart';
import 'package:vloo/app/modules/forgotPassword/controllers/forgot_password_controller.dart';
import 'package:vloo/app/modules/forgotPassword/views/forgot_password_view.dart';
import 'package:vloo/app/modules/profile/views/delete_account.dart';
import 'package:vloo/app/modules/templates/views/Widget/app_loader.dart';
import 'package:vloo/app/repository/rest_api.dart';
import 'package:vloo/app/routes/app_pages.dart';
import 'package:vloo/main.dart';

class ProfileController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final formBuilderKey = GlobalKey<FormBuilderState>().obs;
  final GetStorage storage = Get.find<GetStorage>();

  var selectedOption = 'personal'.obs;
  final RestAPI restAPI = Get.find<RestAPI>();
  final count = 0.obs;
  RxBool showPass = true.obs;

  String firstName = "";
  String email = "";
  String phone = "";
  String type = "";
  String city = "";
  String postCode = "";
  String companyName = "";
  String passwordValue = "";

  final codePicker = const FlCountryCodePicker();
  Rx<CountryCode> countryCode = const CountryCode(name: "", code: "", dialCode: "").obs;
  TextEditingController countryCodeController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  List<Widget> languagesList = <Widget>[const Text('En'), const Text('Fr')];
  RxBool isFrenchSelected = false.obs;
  RxBool isProfileUpdated = false.obs;

  @override
  void onInit() {
    getProfile();
    super.onInit();
  }

  void saveFormKeyState() {
    formBuilderKey.value.currentState!.save();
  }

  void showPassToggle() {
    showPass.toggle();
  }

  String? validateName(String value) {
    if (firstName.isEmpty) {
      return 'Enter a valid name';
    }
    return null;
  }

  String? validateCity(String value) {
    if (city.isEmpty) {
      return 'Enter a valid city';
    }
    return null;
  }

  String? validateCompanyName(String value) {
    if (companyName.isEmpty) {
      return 'Enter a valid company name';
    }
    return null;
  }

  bool showSnackBarError() {
    String errorMessage = "";

    if (firstName.isEmpty) {
      errorMessage = "Please enter firstname";
    } else if (city.isEmpty) {
      errorMessage = "Please enter your city of residence";
    }

    if (errorMessage.isNotEmpty) {
      scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(
          3, errorMessage ?? Strings.somethingWentWrong));
    }

    return errorMessage.isNotEmpty;
  }

  // API integration for account profile update
  Future<void> getProfile() async {
    var response = await restAPI.getDataMethod(
        ApiConfig.getProfileURL, Singleton.header, null);
    if (response != null) {
      try {
        CommonResponse updateResponse = CommonResponse.fromJson(response);

        User userResponse = User.fromJson(updateResponse.result);
        Singleton.userObject = userResponse;
        countryCode.value = CountryCode(
            name: userResponse.country ?? '',
            code: userResponse.countryCode ?? '',
            dialCode: userResponse.dialCode ?? '');
        firstName = userResponse.firstName ?? '';
        email = userResponse.email ?? '';
        phone = userResponse.phoneNumber ?? '';
        companyName = userResponse.companyName ?? '';
        city = userResponse.city ?? '';
        selectedOption.value = userResponse.useType ?? '';
        isProfileUpdated.value = true;
        print(updateResponse.message);
        //     scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(2, updateResponse.message ?? Strings.success));
      } on Exception catch (_) {
         scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(3, response["message"]));
        print(response);
        rethrow;
      }
    } else {
       scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(3, Singleton.errorResponse?.message ?? Strings.somethingWentWrong));
    }
  }

  // API integration for account profile update
  Future<void> updateProfile(
      {required bool comingFromEdit,
      String? email,
      String? phone,
      String? companyName,
      required String name,
      required String type,
      required String city,
      required String postCode}) async {
    if (!showSnackBarError()) {
      AppLoader.showLoader();
      Map<String, dynamic> params = {};
      params["first_name"] = firstName;
      params["post_code"] = postCode;

      if (selectedOption.value == 'personal') {
        params["use_type"] = "personal";
      } else {
        params["use_type"] = "professional";
        params["company_name"] = companyName;
      }

      if (comingFromEdit) {
        params["email"] = email;
        params["phone_number"] = phone;
        params["country_code"] = countryCode.value.code;
        params["dial_code"] = countryCode.value.dialCode;
        params["country"] = countryCode.value.name;
        params["city"] = city;
        params["company_city"] = city;
      }

      var response = await restAPI.postDataMethod(
          ApiConfig.profileUpdateURL, Singleton.header, params);
      if (response != null) {
        try {
          CommonResponse updateResponse = CommonResponse.fromJson(response);
          if (updateResponse.status == 200) {
            AppLoader.hideLoader();
            toSuccessScreen();
          } else {
            AppLoader.hideLoader();
            // scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(2, updateResponse.message ?? Strings.success));
          }

          print(updateResponse.message);
        } on Exception catch (_) {
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

  // API integration for account profile update
  Future<void> updateLanguage() async {
    AppLoader.showLoader();
    Map<String, dynamic> params = {};
    params["language"] = isFrenchSelected.value == true ? "French" : "English";

    var response = await restAPI.postDataMethod(
        ApiConfig.languageUpdateURL, Singleton.header, params);
    if (response != null) {
      try {
        CommonResponse updateResponse = CommonResponse.fromJson(response);
        print(updateResponse.message);
        // scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(2, updateResponse.message ?? Strings.success));

        AppLoader.hideLoader();
        Get.updateLocale(isFrenchSelected.value == true
            ? const Locale('fr', 'FR')
            : const Locale('en', 'US'));
      } on Exception catch (_) {
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

  // redirection to login
  void toLogin() {
    Get.offAllNamed(Routes.login);
  }

  // redirection to Success Screen
  void toSuccessScreen() {
    Get.offAllNamed(Routes.successRegistration);
  }

  // redirection to ForgotPassword
  void toForgotPassword() {
    Get.put(ForgotPasswordController());
    Get.to(const ForgotPasswordView());
  }

// redirection to ForgotPassword
  void toDeleteAccount() {
    Get.to(const DeleteAccountView());
  }

// Logout and redirection to Login Screen
  Future<void> logoutAccount(String url, String? password) async {
    AppLoader.showLoader();

    //1) Hit API to logout
    Map<String, dynamic> params = {};
    if (password != null && password.isNotEmpty) {
      params["password"] = password;
    }

    var response = await restAPI.postDataMethod(url, Singleton.header, params);
    if (response != null) {
      try {
        CommonResponse updateResponse = CommonResponse.fromJson(response);
        if (updateResponse.status == 200) {
          //2) Clear all storage + singleton
          Singleton.token = "";
          Singleton.email = "";
          Singleton.code = 0;
          Singleton.userObject = null;
          Singleton.orientation.value = "";

          //3) Clear storage and shared preferences
          if (storage.read(Strings.token) != null) {
            storage.erase();
          }

          //4) Navigate
          AppLoader.hideLoader();
          Get.offAllNamed(Routes.login);
        } else {
          AppLoader.hideLoader();
          // scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(2, updateResponse.message ?? Strings.success));
        }

        print(updateResponse.message);
      } on Exception catch (_) {
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

// method for countrycode
  void onPressedCountryCodeField(BuildContext context) async {
    final code = await codePicker.showPicker(
        pickerMaxHeight: Get.height * 0.9,
        pickerMinHeight: Get.height * 0.9,
        context: context);
    countryCode.value = code ??
        codePicker.countryCodes.firstWhere((element) => element.code == 'PK');
    // countryCodeController.text = '(${countryCode.dialCode})';
    formBuilderKey.value.currentState!.save();
    update();
  }

  String? validateEmail(String value) {
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? validatePhone(String value) {
    if (phone.isEmpty) {
      return 'Enter a valid phone';
    }
    return null;
  }

  Future<void> launchUrlInBrowser(String? url) async {
    if (!await launchUrl(Uri.parse(url ?? ""))) {
      throw Exception('Could not launch $url');
    }
  }

  void increment() => count.value++;
}
