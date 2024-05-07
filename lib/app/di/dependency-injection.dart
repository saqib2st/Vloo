// import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vloo/app/repository/rest_api.dart';

class DependencyInjection {
  static void init() async {
    Get.put<GetConnect>(GetConnect(timeout: const Duration(seconds: 20),)); //initializing GetConnect
    Get.put<RestAPI>(RestAPI()); //initializing REST API class


    //Get.put<Connectivity >(Connectivity()); //initializing internet connectivity class
    Get.put<GetStorage >(GetStorage()); //initializing internet connectivity class

  }
}