import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class StripeIntegrationsController extends GetxController {
  Map<String, dynamic>? paymentIntentData;
  RxBool? isPaymentSuccess = false.obs;

  Future<bool> makePayment(
      {required String amount, required String currency}) async {
    try {
      paymentIntentData = await createPaymentIntent(amount, currency);
      if (paymentIntentData != null) {
        await Stripe.instance.initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
          merchantDisplayName: 'Prospects',
          customerId: paymentIntentData!['customer'],
          paymentIntentClientSecret: paymentIntentData!['client_secret'],
          customerEphemeralKeySecret: paymentIntentData!['ephemeralKey'],
        ));
        await displayPaymentSheet();
      }

      return isPaymentSuccess?.value ?? false;
    } catch (e, s) {
      print('exception:$e$s');
      return false;
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      Get.snackbar('Payment', 'Payment Successful',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2));

      isPaymentSuccess?.value = true;
    } on Exception catch (e) {
      if (e is StripeException) {
        print("Error from Stripe: ${e.error.localizedMessage}");
      } else {
        print("Unforeseen error: $e");
      }
      isPaymentSuccess?.value = false;
    } catch (e) {
      print("exception:$e");
      isPaymentSuccess?.value = false;
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            // 'Authorization': 'Bearer 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',     // client account
            'Authorization':
                'Bearer sk_test_51LxqQJGgusQdNNi8kujA5wIfGiHQ4bVN08fOiCKbFoifaZxWrloLeiHWiKCGjk3HH9HygHGe1dY27RyNu0n8Q9P700S2yPfC9c', // Test account
            'Content-Type': 'application/x-www-form-urlencoded',
            'Accept': 'application/json; charset=utf-8'
          });
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    String value = "";
    if (amount.contains(".") || amount.contains(",")) {
      value = amount.replaceAll(".", "").replaceAll(",", "");
    } else {
      value = ((int.tryParse(amount) ?? 0) * 100).toString();
    }

    return value;
  }

  final count = 0.obs;

  void increment() => count.value++;
}
