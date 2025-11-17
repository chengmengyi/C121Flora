class Flora121GoldProgressBean {
  Flora121GoldProgressBean({
      this.goldType, 
      this.cashMoney, 
      this.cashType, 
      this.currentProgress, 
      this.totalProgress,});

  Flora121GoldProgressBean.fromJson(dynamic json) {
    goldType = json['goldType'];
    cashMoney = json['cashMoney'];
    cashType = json['cashType'];
    currentProgress = json['currentProgress'];
    totalProgress = json['totalProgress'];
  }
  String? goldType;
  int? cashMoney;
  String? cashType;
  double? currentProgress;
  int? totalProgress;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['goldType'] = goldType;
    map['cashMoney'] = cashMoney;
    map['cashType'] = cashType;
    map['currentProgress'] = currentProgress;
    map['totalProgress'] = totalProgress;
    return map;
  }

}