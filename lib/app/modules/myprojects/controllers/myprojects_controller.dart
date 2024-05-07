
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:vloo/app/data/configs/api_config.dart';
import 'package:vloo/app/data/models/template/Template.dart';
import 'package:vloo/app/data/models/template/Template_count_response.dart';
import 'package:vloo/app/data/models/template/Template_response.dart';
import 'package:vloo/app/data/utils/singleton.dart';
import 'package:vloo/app/modules/myprojects/views/create_new_project.dart';
import 'package:vloo/app/modules/templates/views/Widget/app_loader.dart';
import 'package:vloo/app/modules/templates/views/blank_template.dart';
import 'package:vloo/app/repository/rest_api.dart';

class MyprojectsController extends GetxController {
  final RxList<Template> templateList = <Template>[].obs;
  final RefreshController refreshController = RefreshController(initialRefresh: false);
  final RestAPI restAPI = Get.find<RestAPI>();

  RxInt savedTemplateCount = 0.obs;
  RxInt liveTemplateCount = 0.obs;
  RxInt totalTemplateCount = 0.obs;
  final count = 0.obs;


  void onRefresh() async {
    templateList.clear();
    await getTemplateList();
    await getProjectsListCount();
    refreshController.refreshCompleted();
  }

  Future<void> toBlankTemplate() async {
    await Get.to(const BlankTemplate());
    onRefresh();
  }
  List<Template>? fetchFilteredList(String orientation) {
    if (templateList.isNotEmpty) {
      //var list = templateList.reversed.where((p) => p.orientation == orientation);
      var list = templateList.reversed.where((p) => p.orientation == orientation);
      return list.toList();
    }
    return null;
  }

  Future<void> getTemplateList() async {
    /* if (!showSnackBarError()) {*/
    AppLoader.showLoader();

    var response = await restAPI.getDataMethod(ApiConfig.getSavedTemplateListingURL, Singleton.header, null);
    if (response != null) {
      try {
        TemplateResponse model = TemplateResponse.fromJson(response);
        if (model.status == 200 && model.result != null && model.result!.isNotEmpty) {
          AppLoader.hideLoader();
          templateList.addAll(model.result as Iterable<Template>);
          templateList.refresh();
        }

        if (templateList.isEmpty) {
          AppLoader.hideLoader();
          Get.put<MyprojectsController>(MyprojectsController());
          Get.to(const CreateNewProject());
        } else {
          AppLoader.hideLoader();
          // scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(2, model.message ?? Strings.success));
        }

        print(model.message);
      } on Exception catch (_) {
        // TODO: Here show the error message that comes from server
        AppLoader.hideLoader();

        // scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(3, response["message"]));
        print(response);
        rethrow;
      }
    } else {
      AppLoader.hideLoader();
      // scaffoldKey.currentState?.showSnackBar(SnackBar(content: Text(Singleton.errorResponse?.message ?? "Server Error")));
    }
  }

  Future<void> getProjectsListCount() async {
    /* if (!showSnackBarError()) {*/

    AppLoader.showLoader();
    var response = await restAPI.getDataMethod(ApiConfig.countTemplateURL, Singleton.header, null);
    if (response != null) {
      try {
        TemplateCountResponse model = TemplateCountResponse.fromJson(response);
        if (model.status == 200 && model.result != null) {
          AppLoader.hideLoader();
          totalTemplateCount.value = model.result?.totalTemplates ?? 0;
          liveTemplateCount.value = model.result?.liveTemplate ?? 0;
          savedTemplateCount.value = model.result?.savedTemplates ?? 0;
        } else {
          AppLoader.hideLoader();
          // scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(2, model.message ?? Strings.success));
        }

        print(model.message);
      } on Exception catch (_) {
        // TODO: Here show the error message that comes from server
        AppLoader.hideLoader();

        // scaffoldKey.currentState?.showSnackBar(Utils.getSnackBar(3, response["message"]));
        print(response);
        rethrow;
      }
    } else {
      AppLoader.hideLoader();
      // scaffoldKey.currentState?.showSnackBar(SnackBar(content: Text(Singleton.errorResponse?.message ?? "Server Error")));
    }
  }

  @override
  void onReady() {
    super.onReady();
    onRefresh();
  }

}
