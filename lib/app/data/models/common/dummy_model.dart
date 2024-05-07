

class DummyModel {
  String? storage, prize,  currentPlan;

  DummyModel(
      {this.storage,
      this.currentPlan,
      this.prize,});

  DummyModel.fromJson(Map<String, dynamic> json) {
    storage = json['storage'] ?? '';
    prize = json['prize'] ?? '';
    currentPlan = json['currentPlan'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['storage'] = storage;
    data['prize'] = prize;
    data['currentPlan'] = currentPlan;
    return data;
  }
}
