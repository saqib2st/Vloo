import 'dart:core';

import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:vloo/app/data/models/buy_dongle_delivery_address/Delivery_address_response.dart';
import 'package:vloo/app/data/models/plans/plans_response.dart';
import 'package:vloo/app/data/models/plans/result.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/data/utils/utils.dart';
import 'package:vloo/app/modules/addScreen/views/detail_of_order.dart';
import 'package:vloo/app/modules/addScreen/views/payment_success_add_screen.dart';
import 'package:vloo/app/modules/stripeIntegrations/controllers/stripe_integrations_controller.dart';
import 'package:vloo/app/modules/templates/views/Widget/app_loader.dart';
import 'package:vloo/app/repository/rest_api.dart';
import 'package:vloo/main.dart';
import '../../../data/configs/api_config.dart';
import '../../../data/utils/singleton.dart';
import 'package:vloo/app/data/models/common/common_response.dart';
import 'package:vloo/app/modules/addScreen/views/add_screen_name.dart';
import 'package:vloo/app/modules/addScreen/views/synchronization_confirmation_screen.dart';
import 'package:vloo/app/routes/app_pages.dart';

class AddScreenController extends GetxController {
  final formBuilderKey = GlobalKey<FormBuilderState>().obs;
  final formKey = GlobalKey<FormState>();
  final RestAPI restAPI = Get.find<RestAPI>();
  TextEditingController textController = TextEditingController();

  var selectedScreen = ''.obs;
  final count = 1.obs;
  final RxBool isChecked = false.obs;
  final RxBool isCheckedHorizontal = false.obs;
  final RxBool isCheckedVerticalLeft = false.obs;
  final RxBool isCheckedVerticalRight = false.obs;

  String firstName = "";
  String deliveryAddress = "";
  String lastName = "";
  String city = "";
  String companyName = "";
  String postelCode = "";

  var showFirstWidget = true.obs;
  final RxString pairingCodeValue = ''.obs;
  DonglePlanResult? donglePlanResult;

  String? validateName(String value) {
    if (firstName.isEmpty) {
      return 'Enter a valid name';
    }
    return null;
  }

  String? validateLastName(String value) {
    if (lastName.isEmpty) {
      return 'Enter a valid last name';
    }
    return null;
  }

  String? validatePhone(String value) {
    if (phone.isEmpty) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  String? validateDeliveryAddress(String value) {
    if (deliveryAddress.isEmpty) {
      return 'Enter a valid delivery address';
    }
    return null;
  }

  String? validateCompanyName(String value) {
    if (companyName.isEmpty) {
      return 'Enter a valid company name';
    }
    return null;
  }

  String? validatePostelCode(String value) {
    if (postelCode.isEmpty) {
      return 'Enter a valid postel code';
    }
    return null;
  }

  String? validateCity(String value) {
    if (city.isEmpty) {
      return 'Enter a valid city';
    }
    return null;
  }

  void startTimer() {
    // Set a delay for 5 seconds and then switch the widget
    Future.delayed(const Duration(seconds: 5), () {
      showFirstWidget.value = false; // Hide the first widget
    });
  }

  final codePicker = const FlCountryCodePicker();
  Rx<CountryCode> countryCode =
      const CountryCode(name: 'Pakistan', code: 'PK', dialCode: '+92').obs;
  TextEditingController countryCodeController = TextEditingController();
  String phone = "";
  RxString screenName = "".obs;

  List<String> screenNameList = [
    'Ecran 1',
    'Ecran 2',
    'Ecran 3',
    'Ecran 4',
  ];

  void onPressedCountryCodeField(BuildContext context) async {
    final code = await codePicker.showPicker(
        pickerMaxHeight: Get.height * 0.9,
        pickerMinHeight: Get.height * 0.9,
        context: context);
    countryCode.value = code ??
        codePicker.countryCodes.firstWhere((element) => element.code == 'PK');
    // countryCodetext = '(${countryCode.dialCode})';
    formBuilderKey.value.currentState!.save();
    update();
  }

  Future<void> updateMyScreenOrientation(
      String screenCode, String orientation, String title, num step) async {
    AppLoader.showLoader();
    // ZBotToast.loadingShow();

    Map<String, dynamic> params = {};
    params["screen_code"] = screenCode;
    params["step"] = step;

    if (step == 2) {
      params["orientation"] = orientation;
    }

    if (step == 3) {
      params["title"] = title;
    }

    var response = await restAPI.postDataMethod(
        ApiConfig.addScreenURL, Singleton.header, params);
    if (response != null) {
      try {
        CommonResponse updateResponse = CommonResponse.fromJson(response);
        print(updateResponse.message);
        AppLoader.hideLoader();
        if (updateResponse.status == 200) {
          if (step == 1) {
            AppLoader.hideLoader();
            Get.to(SynchronizationConfirmationScreen(pairingCode: screenCode));
          }

          if (step == 2) {
            AppLoader.hideLoader();
            Get.to(AddScreenNameView(pairingCode: screenCode));
          }

          if (step == 3) {
            AppLoader.hideLoader();
            Get.offAllNamed(Routes.bottomNav,
                parameters: {"index": 2.toString()});
          }
        }
      } on Exception catch (_) {
        AppLoader.hideLoader();
        scaffoldKey.currentState
            ?.showSnackBar(Utils.getSnackBar(3, response["message"]));
        if (kDebugMode) {
          print(response);
        }
        rethrow;
      }
    } else {
      AppLoader.hideLoader();
      scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(
          3, Singleton.errorResponse?.message ?? Strings.somethingWentWrong));
    }
  }

  // API integration for plans response
  Future<void> getPlansResponse() async {
    //  AppLoader.showLoader();           // to remove bug of navigating back screen
    var response = await restAPI.getDataMethod(
        ApiConfig.getPlansURL, Singleton.header, null);
    if (response != null) {
      try {
        PlansResponse model = PlansResponse.fromJson(response);
        if (model.status == 200 &&
            model.result != null &&
            model.result!.plan != null) {
          donglePlanResult = model.result!;
        }
        //   AppLoader.hideLoader();
      } on Exception catch (_) {
        //   AppLoader.hideLoader();
        print(response);
        rethrow;
      }
    }
  }

  String fetchAddressString() {
    var address =
        '$firstName $lastName, $deliveryAddress, $companyName, $city, $postelCode';
    return address.toString();
  }

  double calculateDonglePrice() {
    if (donglePlanResult != null) {
      double price = count.value * (donglePlanResult!.donglePrice ?? 0);
      return price;
    }

    return 0;
  }

  String calculateTotalPrice() {
    if (donglePlanResult != null) {
      double price = (donglePlanResult!.plan?.fee ?? 0) +
          (donglePlanResult!.deliveryFee ?? 0) +
          (donglePlanResult!.vat ?? 0) +
          calculateDonglePrice();
      return price.toStringAsFixed(2);
    }

    return "";
  }

  void navigateNextToOrderDetails() {
    if (firstName.isEmpty ||
        lastName.isEmpty ||
        phone.isEmpty ||
        deliveryAddress.isEmpty ||
        city.isEmpty) {
      scaffoldKey.currentState?.showSnackBar(
          const SnackBar(content: Text(Strings.fieldCannotBeEmpty)));
    } else if (!phone.isPhoneNumber) {
      scaffoldKey.currentState?.showSnackBar(
          const SnackBar(content: Text(Strings.phoneNumberIncorrect)));
    } else {
      Get.to(const DetailOfOrder());
    }
  }

  // API integration for delivery order
  Future<void> deliveryAddressAPI() async {
    if (firstName.isEmpty ||
        lastName.isEmpty ||
        phone.isEmpty ||
        deliveryAddress.isEmpty ||
        city.isEmpty) {
      scaffoldKey.currentState?.showSnackBar(
          const SnackBar(content: Text(Strings.fieldCannotBeEmpty)));
    } else {
      AppLoader.showLoader();

      StripeIntegrationsController stripeController =
          Get.put<StripeIntegrationsController>(StripeIntegrationsController());
      bool isSuccess = await stripeController.makePayment(
          amount: calculateTotalPrice(), currency: 'USD');

      if (isSuccess) {
        var params = {
          'plan_id': donglePlanResult?.plan?.id.toString(),
          'amount': calculateTotalPrice(),
          'currency': donglePlanResult?.plan?.currency,
          'quantity': count.value,
          'delivery_time': donglePlanResult?.deliveryTime.toString(),
          'delivery_fee': donglePlanResult?.deliveryFee?.toString(),
          'first_name': firstName.toString(),
          'last_name': lastName.toString(),
          'phone_number': countryCode.value.dialCode + phone.toString(),
          'delivery_address': deliveryAddress.toString(),
          'company_name': companyName.toString(),
          'postal_code': postelCode.toString(),
          'city': city.toString()
        };

        var response = await restAPI.postDataMethod(
            ApiConfig.placeOrderURL, Singleton.header, params);
        if (response != null) {
          try {
            DeliveryAddressResponse deliveryAddressResponse =
                DeliveryAddressResponse.fromJson(response);
            if (deliveryAddressResponse.status == 200) {
              AppLoader.hideLoader();
              Get.to(const PaymentSuccessAddScreen());
            } else {
              AppLoader.hideLoader();
              scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(
                  2, deliveryAddressResponse.message ?? Strings.success));
              print(deliveryAddressResponse.message);
            }
            //  scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(2, deliveryAddressResponse.message ?? Strings.success));
          } on Exception catch (_) {
            // TODO: Here show the error message that comes from server
            AppLoader.hideLoader();
            scaffoldKey.currentState
                ?.showSnackBar(Utils.getSnackBar(3, response["message"]));
            print(response);
            rethrow;
          }
        } else {
          AppLoader.hideLoader();
          scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(3,
              Singleton.errorResponse?.message ?? Strings.somethingWentWrong));
        }
      } else {
        AppLoader.hideLoader();
        scaffoldKey.currentState?.showSnackBar(
            const SnackBar(content: Text('Payment Failed due to some error')));
      }
    }
  }
  @override
  Future<void> onInit() async {
    super.onInit();

    startTimer();
    await getPlansResponse();
  }

  void selectHorizontalOrientation() {
    isCheckedHorizontal.value = !isCheckedHorizontal.value;
    if (isCheckedHorizontal.value == true) {
      isCheckedVerticalLeft.value = false;
      isCheckedVerticalRight.value = false;
    }
  }

  void selectVerticalLeftOrientation() {
    isCheckedVerticalLeft.value = !isCheckedVerticalLeft.value;
    if (isCheckedVerticalLeft.value == true) {
      isCheckedHorizontal.value = false;
      isCheckedVerticalRight.value = false;
    }
  }

  void selectVerticalRightOrientation() {
    isCheckedVerticalRight.value = !isCheckedVerticalRight.value;
    if (isCheckedVerticalRight.value == true) {
      isCheckedVerticalLeft.value = false;
      isCheckedHorizontal.value = false;
    }
  }

  String fetchOrientation() {
    if (isCheckedHorizontal.value) {
      return "Landscape";
    } else if (isCheckedVerticalLeft.value) {
      return "Portrait Left";
    } else if (isCheckedVerticalRight.value) {
      return "Portrait Right";
    }

    return "";
  }

  void increment() => count.value++;

  void decrement() => count.value--;
}
