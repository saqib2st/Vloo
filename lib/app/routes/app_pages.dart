import 'package:get/get.dart';

import '../modules/MyMedia/bindings/my_media_binding.dart';
import '../modules/MyMedia/views/my_media_view.dart';
import '../modules/addScreen/bindings/add_screen_binding.dart';
import '../modules/addScreen/views/add_screen.dart';
import '../modules/bottomNav/bindings/bottom_nav_binding.dart';
import '../modules/bottomNav/views/bottom_nav_view.dart';
import '../modules/forgotPassword/bindings/forgot_password_binding.dart';
import '../modules/forgotPassword/views/forgot_password_view.dart';
import '../modules/imageElement/bindings/image_element_binding.dart';
import '../modules/imageElement/views/image_element_view.dart';
import '../modules/introduction/bindings/introduction_binding.dart';
import '../modules/introduction/views/introduction_view.dart';
import '../modules/layers/bindings/layers_binding.dart';
import '../modules/layers/views/layers_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/myprojects/bindings/myprojects_binding.dart';
import '../modules/myprojects/views/myprojects_view.dart';
import '../modules/myscreens/bindings/myscreens_binding.dart';
import '../modules/myscreens/views/myscreens_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/profile/views/success_registration.dart';
import '../modules/signup/bindings/signup_binding.dart';
import '../modules/signup/views/signup_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/stripeIntegrations/bindings/stripe_integrations_binding.dart';
import '../modules/stripeIntegrations/views/stripe_integrations_view.dart';
import '../modules/subscriptions/bindings/subscriptions_binding.dart';
import '../modules/subscriptions/views/subscriptions_view.dart';
import '../modules/templates/bindings/templates_binding.dart';
import '../modules/templates/views/templates_view.dart';
import '../modules/textEditing/bindings/text_editing_binding.dart';
import '../modules/textEditing/views/template_title_editing_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.splash;

  static final routes = [
    GetPage(
      name: _Paths.splash,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.signup,
      page: () => const SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.login,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.successRegistration,
      page: () => const SuccessRegistration(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.introduction,
      page: () => const IntroductionView(),
      binding: IntroductionBinding(),
    ),
    GetPage(
      name: _Paths.forgotPassword,
      page: () => const ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: _Paths.bottomNav,
      page: () => const BottomNavView(),
      binding: BottomNavBinding(),
      transition: Transition.noTransition
    ),
    GetPage(
      name: _Paths.templates,
      page: () => const TemplatesView(),
      binding: TemplatesBinding(),
    ),
    GetPage(
      name: _Paths.imageElement,
      page: () =>  ImageElementView(comingFrom: 'add'),
      binding: ImageElementBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.TEXT_EDITING,
      page: () => TemplateTitleEditingView(
        fontOpacity: (val)=>null,
        backgroundOpacity: (val)=>null,
        isAnimEnabled: false,
        text: (val) => null,
        textStyle: (val) => null,
        selectedAlignment: (val) => null,
        animatedModel: (val) => null,
      ),
      binding: TextEditingBinding(),
    ),
    GetPage(
      name: _Paths.MYPROJECTS,
      page: () => const MyprojectsView(),
      binding: MyprojectsBinding(),
    ),
    GetPage(
      name: _Paths.MYSCREENS,
      page: () => const MyScreensView(),
      binding: MyscreensBinding(),
    ),
    GetPage(
      name: _Paths.LAYERS,
      page: () => const ElementLayersView(),
      binding: LayersBinding(),
    ),
    GetPage(
      name: _Paths.ADD_SCREEN,
      page: () => const AddScreenView(),
      binding: AddScreenBinding(),
    ),
    GetPage(
      name: _Paths.SUBSCRIPTIONS,
      page: () => const SubscriptionsView(),
      binding: SubscriptionsBinding(),
    ),
    GetPage(
      name: _Paths.MY_MEDIA,
      page: () => const MyMediaView(),
      binding: MyMediaBinding(),
    ),
    GetPage(
      name: _Paths.STRIPE_INTEGRATIONS,
      page: () => const StripeIntegrationsView(),
      binding: StripeIntegrationsBinding(),
    ),
  ];
}
