import 'package:get/get.dart';
import 'package:vloo/app/data/models/template/template_single_item_model.dart';
import 'package:vloo/app/data/utils/static_assets.dart';
import 'package:vloo/app/modules/textEditing/controllers/title_editing_controller.dart';

class LayersController extends GetxController with GetTickerProviderStateMixin {
  List<TemplateSingleItemModel>? itemsListData;

  LayersController({this.itemsListData});

  int getListCount() {
    return itemsListData?.length ?? 0;
  }

  String getIconsPath(String type) {
    var path = "";

    switch (type) {
      case "Image":        //  StaticAssets.selectedImageIcon : StaticAssets.imageIcon,
        return StaticAssets.imageIcon;
      case "Title":        //StaticAssets.selectedTitleIcon : StaticAssets.titleIcon,
        return StaticAssets.titleIcon;
      case "Description":  // StaticAssets.selectedDescriptionIcon : ,
        return StaticAssets.descriptionIcon;
      case "Price":       // StaticAssets.selectedPriceIcon : ,
        return StaticAssets.priceIcon;
    }

    return path;
  }

  void goToTitleEditingScreen(String value) {
    /*  Get.put<TitleEditingController>(TitleEditingController(elements: value ?? ""));
    Get.to(TemplateTitleEditingView(
      text: (val) {
        //TODO: API will be added and changes will be stored
      },
      textStyle: (val) {
        //TODO: API will be added and changes will be stored
      },
      comingFrom: 'editTitle',
    ));*/
  }

  toPriceElementView(String elements) {
    Get.put<TitleEditingController>(TitleEditingController());
    // Get.to(
    //   PriceEditingView(
    //     text: (val) {
    //       //TODO: API will be added and changes will be stored
    //     },
    //     textStyle: (val) {
    //       //TODO: API will be added and changes will be stored
    //     },
    //     comingFrom: 'elementPrice',
    //   ),
    // );
  }
}
