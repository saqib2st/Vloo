import 'package:get/get.dart';
import 'package:vloo/app/data/models/buy_dongle_delivery_address/Delivery_address_response.dart';
import 'package:vloo/app/data/models/buy_storage/buy_storage_response.dart';
import 'package:vloo/app/data/models/common/common_response.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/data/utils/utils.dart';
import 'package:vloo/app/modules/stripeIntegrations/controllers/stripe_integrations_controller.dart';
import 'package:vloo/app/modules/subscriptions/views/payment_success_subscription_screen.dart';
import 'package:vloo/app/modules/templates/views/Widget/app_loader.dart';
import 'package:vloo/app/repository/rest_api.dart';
import 'package:vloo/main.dart';

import '../../../data/configs/api_config.dart';
import '../../../data/utils/singleton.dart';

class SubscriptionsController extends GetxController {
  //TODO: Implement SubscriptionsController
  final RestAPI restAPI = Get.find<RestAPI>();
  final count = 3.obs;

  /* RxString title = "3 screens".obs;
  RxString fee = "2.99".obs;
  RxString currency = "€".obs;
  RxString type = "Screen-Plan".obs;
  RxString description = "Classic Plan".obs;
  RxString duration = "1 month".obs;*/

  int planID = 0;
  double totalPrice = 0;

  void increment() => count.value++;

  void decrement() => count.value--;

  String getUpdatedPrice() {
    totalPrice = count.value * 20;

    return totalPrice.toStringAsFixed(2);
  }

  // API integration for account profile update
  Future<void> getSubscriptionOrders() async {
    AppLoader.showLoader();

    var response = await restAPI.getDataMethod(
        ApiConfig.getOrderURL, Singleton.header, null);
    if (response != null) {
      try {
        CommonResponse updateResponse = CommonResponse.fromJson(response);
        print(updateResponse.message);
        /*scaffoldKey.currentState?.showSnackBar(
            Utils.getSnackBar(2, updateResponse.message ?? Strings.success));*/
        AppLoader.hideLoader();
      } on Exception catch (_) {
        AppLoader.hideLoader();

        scaffoldKey.currentState
            ?.showSnackBar(Utils.getSnackBar(3, response["message"]));
        print(response);
        rethrow;
      }
    } else {
      AppLoader.hideLoader();
      scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(
          3, Singleton.errorResponse?.message ?? Strings.somethingWentWrong));
    }
  }

  // API integration for screen order update
  Future<void> orderScreenPlan() async {
    //Step 1: Get payment from stripe
    StripeIntegrationsController stripeController =
        Get.put<StripeIntegrationsController>(StripeIntegrationsController());
    bool isSuccess = await stripeController.makePayment(
        amount: getUpdatedPrice(), currency: "USD");

    //Step 2: If payment successful, proceed to order storage
    if (isSuccess) {
      var params = {
        'plan_id':
            planID, // TODO: Change to dynamic afterwards Now For classic plan
        'payment_status': Strings.paid,
        'payment_method': Strings.stripe,
        'start_date': DateTime.now().toString(),
        'expiry_date': DateTime.now().add(const Duration(days: 30)).toString(),
        'type': Strings.screen,
        'total_price': getUpdatedPrice(),
      };

      var response = await restAPI.postDataMethod(
          ApiConfig.placeStorageOrderURL, Singleton.header, params);
      if (response != null) {
        try {
          BuyStorageResponse storageResponse =
              BuyStorageResponse.fromJson(response);
          if (storageResponse.status == 200) {
            AppLoader.hideLoader();
            Get.to(const PaymentSuccessSubscriptionScreen());
          } else {
            AppLoader.hideLoader();
            scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(
                3, storageResponse.message ?? Strings.success));
            print(storageResponse.message);
          }
          //  scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(2, deliveryAddressResponse.message ?? Strings.success));
        } on Exception catch (_) {
          AppLoader.hideLoader();
          scaffoldKey.currentState
              ?.showSnackBar(Utils.getSnackBar(3, response["message"]));
          print(response);
          rethrow;
        }
      } else {
        AppLoader.hideLoader();
        scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(
            3, Singleton.errorResponse?.message ?? Strings.somethingWentWrong));
      }
    } else {
      AppLoader.hideLoader();
      scaffoldKey.currentState?.showSnackBar(
          Utils.getSnackBar(3, 'Payment Failed due to some error'));
    }
  }
}
