import 'dart:async';

// import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:country_codes/country_codes.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vloo/app/data/configs/api_config.dart';
import 'package:vloo/app/data/models/login/Login_response.dart';
import 'package:vloo/app/data/utils/singleton.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/data/utils/utils.dart';
import 'package:vloo/app/modules/profile/controllers/profile_controller.dart';
import 'package:vloo/app/modules/profile/views/profile_view.dart';
import 'package:vloo/app/modules/templates/views/Widget/app_loader.dart';
import 'package:vloo/app/repository/rest_api.dart';
import 'package:vloo/app/routes/app_pages.dart';
import 'package:vloo/main.dart';
import 'dart:developer' as developer;

class SignupController extends GetxController {
  final formBuilderKey = GlobalKey<FormBuilderState>().obs;
  final formKey = GlobalKey<FormState>();

  RxBool showPass = true.obs;
  RxBool showConfirmPass = true.obs;
  final codePicker = const FlCountryCodePicker();
  TextEditingController countryCodeController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  Rx<CountryCode> countryCode = const CountryCode(name: 'France', code: 'FR', dialCode: '+33').obs;
  var selectedOption = 'personal'.obs;
  final RxBool isChecked = false.obs;
  final RestAPI restAPI = Get.find<RestAPI>();
  final GetStorage storage = Get.find<GetStorage>();

  String email = "";
  String phone = "";
  String passwordValue = "";
  String confirmPasswordValue = "";

  CountryCode getCountryISOCode() {
    CountryDetails details = CountryCodes.detailsForLocale();
      if (details != null) {
        return CountryCode(name: details.name ?? 'France', code:details.alpha2Code?? 'FR', dialCode: details.dialCode ?? '+33') ;
      } else {
        return const CountryCode(name: 'France', code: 'FR', dialCode: '+33');
      }
  }
  /* ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Get.find<Connectivity>();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
*/
/*
  @override
  void onInit() {
    super.onInit();
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);

  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }

  @override
  void onClose() {
    _connectivitySubscription.cancel();
    super.onClose();
  }
*/
  @override
  void onReady() {
    countryCode.value =  getCountryISOCode();
    super.onReady();
  }

  void saveFormKeyState() {
    formBuilderKey.value.currentState!.save();
  }

  void showPassToggle() {
    showPass.toggle();
  }

  void showConfirmPassToggle() {
    showConfirmPass.toggle();
  }

  String? validateEmail(String value) {
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? validateMobile(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return 'Please enter mobile number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return null;
  }

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

    if (email.isEmpty) {
      errorMessage = "Please enter the email";
    } else if (validateEmail(email) != null) {
      errorMessage = validateEmail(email) ?? '';
    } else if (validateMobile(phone) != null) {
      errorMessage = validateMobile(phone) ?? '';
    } else if (passwordValue.isEmpty || passwordValue.length < 8) {
      errorMessage = "Password length must be greater than 8 characters";
    } else if (passwordValue != confirmPasswordValue) {
      errorMessage = "Both passwords do not match.";
    } else if (isChecked.value == false) {
      errorMessage = "Please accept terms and conditions first";
    }

    if (errorMessage.isNotEmpty) {
      scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(3, errorMessage));
    }
    return errorMessage.isNotEmpty;
  }

  // API integration for account registration
  Future<void> registerAccount(
      String email, String phone, String password) async {

      AppLoader.showLoader();

      var header = {
        'Content-type': 'application/json; charset=utf-8',
        'Accept': 'application/json; charset=utf-8'
      };
      var params = {
        'email': email,
        'dial_code': countryCode.value.dialCode,
        'country_code': countryCode.value.code,
        'country': countryCode.value.name,
        'phone_number': phone,
        'password': password,
        'user_type': "personal"
      };

      var response =
          await restAPI.postDataMethod(ApiConfig.registerURL, header, params);
      if (response != null) {
        try {
          LoginResponse registerResponse = LoginResponse.fromJson(response);
          if (registerResponse.status == 200) {
            Singleton.token = registerResponse.result?.token ?? "";
            Singleton.header = {
              "Authorization": "Bearer ${Singleton.token}",
              "Content-Type": "application/json",
              "Accept": "application/json",
            };
            Singleton.userObject = registerResponse.result?.user;

            storage.write(Strings.token, registerResponse.result?.token ?? "");
            storage.write(
                Strings.user, "${registerResponse.result?.user ?? ""}");
            storage.write(
                Strings.userEmail, registerResponse.result?.user?.email ?? "");
            AppLoader.hideLoader();

            if (Singleton.token.isNotEmpty) {
              toCompleteProfile();
            }
          } else {
            AppLoader.hideLoader();
            scaffoldKey.currentState?.showSnackBar(SnackBar(
                content: Text(registerResponse.message ?? Strings.success)));
          }

          print(registerResponse.message);
        } on Exception catch (_) {
          AppLoader.hideLoader();
          scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(3, response["message"]));
          debugPrint(response);
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
    if (code != null) {
      countryCode.value =
          code /*?? codePicker.countryCodes.firstWhere((element) => element.code == 'PK')*/;
    }
    // countryCodeController.text = '(${countryCode.dialCode})';
    formBuilderKey.value.currentState!.save();
    update();
  }

  // redirection to CompleteRegistration
  void toCompleteProfile() {
    Get.put(ProfileController());
    Get.to(const ProfileView());
  }

  // redirection to Introduction
  void toIntroduction() {
    Get.offNamed(Routes.introduction);
  }

  // redirection to login
  void toLogin() {
    Get.offAllNamed(Routes.login);
  }

  void toHome() {
    Get.offAllNamed(Routes.bottomNav);
  }
}
