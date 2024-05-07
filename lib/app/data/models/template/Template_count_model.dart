/// totalTemplates : 50
/// savedTemplates : 0
/// liveTemplate : 0

class TemplateCountModel {
  TemplateCountModel({
      int? totalTemplates, 
      int? savedTemplates, 
      int? liveTemplate,}){
    _totalTemplates = totalTemplates;
    _savedTemplates = savedTemplates;
    _liveTemplate = liveTemplate;
}

  TemplateCountModel.fromJson(dynamic json) {
    _totalTemplates = json['totalTemplates'];
    _savedTemplates = json['savedTemplates'];
    _liveTemplate = json['liveTemplate'];
  }
  int? _totalTemplates;
  int? _savedTemplates;
  int? _liveTemplate;
TemplateCountModel copyWith({  int? totalTemplates,
  int? savedTemplates,
  int? liveTemplate,
}) => TemplateCountModel(  totalTemplates: totalTemplates ?? _totalTemplates,
  savedTemplates: savedTemplates ?? _savedTemplates,
  liveTemplate: liveTemplate ?? _liveTemplate,
);
  int? get totalTemplates => _totalTemplates;
  int? get savedTemplates => _savedTemplates;
  int? get liveTemplate => _liveTemplate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['totalTemplates'] = _totalTemplates;
    map['savedTemplates'] = _savedTemplates;
    map['liveTemplate'] = _liveTemplate;
    return map;
  }

}