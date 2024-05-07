/// ConnectedScreens : 0
/// OfflineScreens : 0
/// ScreensWithoutContent : 0

class ScreenCount {
  ScreenCount({
      int? connectedScreens,
      int? offlineScreens,
      int? screensWithoutContent,}){
    _connectedScreens = connectedScreens;
    _offlineScreens = offlineScreens;
    _screensWithoutContent = screensWithoutContent;
}

  ScreenCount.fromJson(dynamic json) {
    _connectedScreens = json['ConnectedScreens'];
    _offlineScreens = json['OfflineScreens'];
    _screensWithoutContent = json['ScreensWithoutContent'];
  }
  int? _connectedScreens;
  int? _offlineScreens;
  int? _screensWithoutContent;
ScreenCount copyWith({  int? connectedScreens,
  int? offlineScreens,
  int? screensWithoutContent,
}) => ScreenCount(  connectedScreens: connectedScreens ?? _connectedScreens,
  offlineScreens: offlineScreens ?? _offlineScreens,
  screensWithoutContent: screensWithoutContent ?? _screensWithoutContent,
);
  int? get connectedScreens => _connectedScreens;
  int? get offlineScreens => _offlineScreens;
  int? get screensWithoutContent => _screensWithoutContent;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ConnectedScreens'] = _connectedScreens;
    map['OfflineScreens'] = _offlineScreens;
    map['ScreensWithoutContent'] = _screensWithoutContent;
    return map;
  }

}