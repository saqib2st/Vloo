import 'package:country_codes/country_codes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:vloo/app/di/dependency-injection.dart';
import 'package:vloo/l10n/languages.dart';
import 'app/routes/app_pages.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<ScaffoldMessengerState> scaffoldKey =
    GlobalKey<ScaffoldMessengerState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CountryCodes.init();
  await GetStorage.init();
  DependencyInjection.init(); //calling DependencyInjection init method
  final appDocumentDirectory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  await Hive.openBox('colors');
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(const MyApp()));
  // PhotoManager.clearFileCache();

  //Stripe.publishableKey = "pk_live_51OMUTTKTwcmmWo31v09tONHdyJHhyLGtAJ10s1xMnHlc0Ax9hQicLQHPIPnGCgSFK860os9tiF6G34unSPyw1MOM00oChrnXYb";   // Client account
  Stripe.publishableKey =
      "pk_test_51LxqQJGgusQdNNi8lUtJofQKFnAtOjscGFLAmAWlBgWvpAuGqdza1JIiTRUuHUZ9jbajRbLNfEI2iyPEkcHoHFKo00V23ctdr8"; // Test Account

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: navigatorKey,
      scaffoldMessengerKey: scaffoldKey,
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute: AppPages.initial,
      translations: Languages(),
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('en', 'US'),
      getPages: AppPages.routes,
    );
  }
}
