import 'package:get/get.dart';

import '../controllers/stripe_integrations_controller.dart';

class StripeIntegrationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StripeIntegrationsController>(
      () => StripeIntegrationsController(),
    );
  }
}
