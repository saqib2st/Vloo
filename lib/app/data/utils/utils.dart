import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/models/screens/ScreenModel.dart';
import 'package:vloo/app/data/utils/static_assets.dart';
import 'package:vloo/app/data/widgets/confirmation_alert_dialog.dart';
import 'package:vloo/app/data/widgets/orientationDialog.dart';

import 'strings.dart';

class Utils {
  static Future<DateTime?> getDate(BuildContext context, DateTime endDate) async {
    final DateTime? picked = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(1910, 1), lastDate: endDate);

    return picked;
  }

  static fetchColorFromStringColor(String? color) {
    if (color != null && color.isNotEmpty && color != "0x0" && color != "0") {
      return Color(int.parse(color.replaceAll("#", "").replaceFirst("0x", ""), radix: 16) + 0xFF000000);
    } else {
      return AppColor.transparent;
    }
  }

  static fetchMaterialColorFromStringColor(String? color) {
    if (color != null && color.isNotEmpty && color != "0x0" && color != "0") {
      return Utils.getMaterialColor(Color(int.parse(color.replaceAll("#", "").replaceFirst("0x", ""), radix: 16) + 0xFF000000));
    } else {
      return getMaterialColor(AppColor.transparent);
    }
  }

  static MaterialColor getMaterialColor(Color color) {
    return MaterialColor(color.value, <int, Color>{
      50: color.withOpacity(0.1),
      100: color.withOpacity(0.2),
      200: color.withOpacity(0.3),
      300: color.withOpacity(0.4),
      400: color.withOpacity(0.5),
      500: color.withOpacity(0.6),
      600: color.withOpacity(0.7),
      700: color.withOpacity(0.8),
      800: color.withOpacity(0.9),
      900: color.withOpacity(1.0),
    });
  }

  static String getDateInFormat(String inputDate, String inPutFormat, String outPutFormat) {
    if (inputDate == null || inputDate.isEmpty) return "";

    DateFormat originalFormat = DateFormat(inPutFormat);
    DateTime originalDate = originalFormat.parse(inputDate, true);

    // Convert to local time
    DateTime localDateTime = originalDate.toLocal();

    /*// Format the date in local time
    String formattedLocalTime = localDateTime.toString();*/
    DateFormat newFormat = DateFormat(outPutFormat);
    String newDateString = newFormat.format(localDateTime);

    print(newDateString); // Output: 26/10/2023 03:30 PM
    return newDateString;
  }

  static showOrientationAlert(BuildContext context, ScreenModel? selectedScreenModel) async {
    await showDialog(
        barrierColor: AppColor.primaryColor.withOpacity(0.9),
        context: context,
        builder: (BuildContext context) {
          return OrientationDialog(selectedScreenModel: selectedScreenModel);
        });
  }

  static confirmationAlert({required BuildContext context, String? description, String? positiveText, String? negativeText, required Function() onPressedPositive, required Function() onPressedNegative,negativeColor}) {
    showDialog(
      context: context,
      barrierColor: AppColor.primaryColor.withOpacity(0.9),
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          elevation: 0.0,
          surfaceTintColor: AppColor.transparent,
          backgroundColor: AppColor.transparent,
          child: ConfirmationAlertDialog(description: description, positiveText: positiveText ?? 'Delete', negativeText: negativeText ?? 'Cancel', onPressedNegative: onPressedNegative, onPressedPositive: onPressedPositive,negativeColor:negativeColor),
        );
      },
    );
  }

  ////////////get country flag////////////////////////////

  static String getCountryflag(String countryCode) {
    return countryCode.toUpperCase().replaceAllMapped(RegExp(r'[A-Z]'), (match) => String.fromCharCode((match.group(0)?.codeUnitAt(0))! + 127397));
  }

  /*String getFullImageUrl(String endPoint) {
    return APIs.baseImageURL + endPoint;
  }*/

  static int getTimeDifferenceInMonths(String startTime, String endTime) {
    DateTime createdDate = DateTime.parse(endTime);
    DateTime now = DateTime.parse(startTime);
    return (now.difference(createdDate).inDays) ~/ 30;
  }

  static int getTimeDifferenceInWeeks(String startTime, String endTime) {
    DateTime createdDate = DateTime.parse(startTime);
    DateTime now = DateTime.parse(endTime);
    return now.difference(createdDate).inDays ~/ 7;
  }

  static String calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var a = 0.5 - cos((lat2 - lat1) * p) / 2 + cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return (12742 * asin(sqrt(a))).toStringAsFixed(1);
  }

  static Widget getNetworkImage(String endPoint, [BoxFit? fit, double? width, double? height]) {
    return CachedNetworkImage(
      imageUrl: endPoint,
      height: height,
      width: width,
      fit: fit,
      placeholder: (context, url) => Container(
          color: AppColor.white,
          child: Image.asset(
            StaticAssets.imageLoaderIcon,
            fit: BoxFit.scaleDown,
            width: width,
            height: height,
          )),
      errorWidget: (context, url, error) => Container(
        color: AppColor.white,
        child: Image.asset(
          StaticAssets.noImageIcon,
          fit: BoxFit.scaleDown,
          width: width,
          height: height,
        ),
      ),
    );
  }

/*
 static Future<Widget> getNetworkThumbnail(String endPoint, [BoxFit? fit, double? width, double? height]) async {
    return FadeInImage.assetNetwork(
      image: await getVideoThumbnail(endPoint) ?? "",
      placeholder: StaticAssets.imageLoaderIcon,
      imageErrorBuilder: (BuildContext context, Object object, StackTrace? _) {
        return Container(
          color: AppColor.white,
          child: Image.asset(
            StaticAssets.noImageIcon,
            fit: BoxFit.scaleDown,
            width: width,
            height: height,
          ),
        );
      },
      fit: fit ?? BoxFit.cover,
      width: width,
      height: height,
    );
  }
*/

  /*static Future<String?> getVideoThumbnail(String videoURL) async {
    return await VideoThumbnail.thumbnailFile(
      video: "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4",
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.WEBP,
      quality: 100,
    );
  }

 static Future<Uint8List?> getVideoThumbnailUInt8List(String videoURL) async {
    return await VideoThumbnail.thumbnailData(
      video: videoURL,
      imageFormat: ImageFormat.JPEG,
      maxWidth: 200, // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
      quality: 25,
    );
  }
*/
  static Widget getImageFromFile(File file, [BoxFit? fit, double? width, double? height]) {
    return Image.file(
      file,
      fit: fit ?? BoxFit.cover,
      width: width,
      height: height,
    );
  }

  static SnackBar getSnackBar(int type, String message) {
    /* Type == 1 -> Normal info bar
    Type == 2 -> Success bar
    Type == 3 -> Error bar*/

    Color color = AppColor.unselectedTab;
    if (type == 1) {
      color = AppColor.unselectedTab;
    } else if (type == 2) {
      color = AppColor.statusGreen;
    } else if (type == 3) {
      color = AppColor.statusRed;
    }

    return SnackBar(showCloseIcon: true, closeIconColor: AppColor.white, backgroundColor: color, content: Text(message));
  }

  static String? appBarTitle(String comingFrom) {
    if (comingFrom == Strings.addElementTitle || comingFrom == Strings.editElementTitle) {
      return 'Title';
    } else if (comingFrom == Strings.addElementDescription || comingFrom == Strings.editElementDescription) {
      return 'Description';
    } else if (comingFrom == Strings.addElementPrice || comingFrom == Strings.editElementPrice) {
      return 'Price';
    }
    return null;
  }

/*static Future<User> getCurrentUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map userMap = jsonDecode(preferences.getString('userData') ?? "");
    return User.fromJson(userMap);
  }*/

/*static Future<XFile?> pickImage(ImageSource imageSource) async {
    return await ImagePicker().pickImage(
      source: imageSource,
    );
  }*/

/*static Future<List<XFile>?> pickMultiImages() async {
    return await ImagePicker().pickMultiImage();
  }*/
}

extension TimeOfDayConverter on TimeOfDay {
  String to24hours() {
    final hour = this.hour.toString().padLeft(2, "0");
    final min = minute.toString().padLeft(2, "0");
    return "$hour:$min";
  }
}

extension TimeOfDayExtension on TimeOfDay {
  int compareTo(TimeOfDay other) {
    if (hour < other.hour) return -1;
    if (hour > other.hour) return 1;
    if (minute < other.minute) return -1;
    if (minute > other.minute) return 1;
    return 0;
  }
}

extension FetchRatingsTitle on double {
  String fetchRatingsTitle(double value) {
    if (value >= 5) {
      return "Excellent";
    } else if (value > 3 && value < 5) {
      return "Good";
    }
    if (value > 1 && value < 3) {
      return "Average";
    } else {
      return "Bad";
    }
  }
}

extension DateTimeExtension on DateTime {
  String timeAgo({bool numericDates = true}) {
    final date2 = DateTime.now();
    final difference = date2.difference(this);

    if ((difference.inDays / 7).floor() >= 1) {
      return (numericDates) ? '1 week ago' : 'Last week';
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays >= 1) {
      return (numericDates) ? '1 day ago' : 'Yesterday';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} hours ago';
    } else if (difference.inHours >= 1) {
      return (numericDates) ? '1 hour ago' : 'An hour ago';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inMinutes >= 1) {
      return (numericDates) ? '1 minute ago' : 'A minute ago';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} seconds ago';
    } else {
      return 'Just now';
    }
  }
}

extension StringExtensions on String {
  String convertUtcToLocalTime() {
    // Parse the UTC time string
    DateTime utcDateTime = DateTime.parse(this).toUtc();

    // Convert to local time
    DateTime localDateTime = utcDateTime.toLocal();

    // Format the date in local time
    String formattedLocalTime = localDateTime.toString();

    return formattedLocalTime;
  }
}
extension GlobalValues on GetStorage {
  bool get isAdmin {
    return read(Strings.userEmail) == 'templateadmin@vloo.com';
  }
}
