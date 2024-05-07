

class ApiConfig {
  static const String baseUrl = "https://vloo.6lgx.com/api/";

  // Authentications
  static const String loginURL = "${baseUrl}login";
  static const String logoutURL = "${baseUrl}profile/logout";
  static const String registerURL = "${baseUrl}register";

  static const String getProfileURL = "${baseUrl}profile/get";
  static const String profileUpdateURL = "${baseUrl}profile/update";
  static const String languageUpdateURL = "${baseUrl}profile/change-language";
  static const String passwordResetLinkURL = "${baseUrl}password/reset-link";
  static const String passwordResetURL = "${baseUrl}password/reset";
  static const String deleteAccountPermanentlyURL = "${baseUrl}profile/permanent-delete";
  static const String softDeleteAccountURL = "${baseUrl}profile/delete";


  // Templates
  static const String getTemplateListingURL = "${baseUrl}template/get";
  static const String getSavedTemplateListingURL = "${baseUrl}template/get-saved-template";
  static const String createTemplateURL = "${baseUrl}template/add";
  static const String createCanvaTemplateURL = "${baseUrl}template/save";
  static const String preDefinedTemplate = "${baseUrl}template/get-predefined-template";
  static const String countTemplateURL = "${baseUrl}template/counts";
  static const String updateTemplateFeatureImageURL = "${baseUrl}template/save-snapshot";
  static const String updateTemplateTitleURL = "${baseUrl}template/update-title";
  static const String uploadTemplateMediaURL = "${baseUrl}template/upload-media";
  static const String deleteTemplateURL = "${baseUrl}template/delete";
  static const String duplicateTemplateURL = "${baseUrl}template/template-duplicate";

  // Elements
  static const String addElementURL = "${baseUrl}element/add";

  // Add plans
  static const String addPlanURL = "${baseUrl}add-plan";
  static const String addOrderURL = "${baseUrl}order/make-Order";
  static const String getOrderURL = "${baseUrl}order/get-orders";
  static const String getPlansURL = "${baseUrl}dongle/get-data";
  static const String placeOrderURL = "${baseUrl}dongle/place-order";
  static const String getUserSubscriptionPlanURL = "${baseUrl}subscription/get";

  // My screens
  static const String screensListingURL = "${baseUrl}screen/lisitng";
  static const String screensListingCountURL = "${baseUrl}screen/lisitng/count";
  static const String screenDetailsURL = "${baseUrl}screen/details";
  static const String updateScreenOrientationURL = "${baseUrl}screen/change-orientation";
  static const String updateScreenTitleURL = "${baseUrl}screen/edit-title";
  static const String deleteScreenURL = "${baseUrl}screen/delete";
  static const String addScreenURL = "${baseUrl}screen/add-screen";
  static const String addScreenContentURL = "${baseUrl}screen/add-screen-content";
  static const String removeScreenContentURL = "${baseUrl}screen/remove-screen-content";

  // My Medias
  static const String mediaListingURL = "${baseUrl}media/list";
  static const String mediaDetailsListingURL = "${baseUrl}media/detail";
  static const String mediaDeleteURL = "${baseUrl}media/delete";
  static const String mediaEditURL = "${baseUrl}media/edit";
  static const String mediaUploadURL = "${baseUrl}media/upload";

  // Vloo Library
  static const String vlooLibraryCategories = "${baseUrl}vloo-library/folders";
  static const String vlooLibraryGetImages = "${baseUrl}vloo-library/get";
  static const String vlooLibraryGetRecentImages = "${baseUrl}template/recent-uploaded-media";


  // Storage
  static const String getStoragePlanList = "${baseUrl}plan-listing";
  static const String usedStorageURL = "${baseUrl}storage/show-used-capacity";
  static const String placeStorageOrderURL = "${baseUrl}order/make-Order";



  // Local URL links for support pages
  static const String aboutUsURL = "https://vloo.6lgx.com/about-us";
  static const String contactUsURL = "https://vloo.6lgx.com/contact-us";
  static const String helpURL = "https://vloo.6lgx.com/help";
  static const String shareAnalysisURL = "https://vloo.6lgx.com/help";

}
