import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:vloo/app/data/utils/strings.dart';

import '../controllers/stripe_integrations_controller.dart';

class StripeIntegrationsView extends GetView<StripeIntegrationsController> {
  const StripeIntegrationsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: const Text('StripeIntegrationsView'),
        centerTitle: true,
      ),
      body:  Center(
        child: ElevatedButton(
          onPressed: () async {
            await controller.makePayment(amount: "5", currency: 'USD');
            Get.back(result: controller.isPaymentSuccess?.value);
          },
          child: const Text(Strings.pressToPay),
        ),
      ),
    );
  }
}
