class Flora121CashRankBean {
  Flora121CashRankBean({
      this.cashMoney, 
      this.cashType, 
      this.currentProgress, 
      this.totalProgress,});

  Flora121CashRankBean.fromJson(dynamic json) {
    cashMoney = json['cashMoney'];
    cashType = json['cashType'];
    currentProgress = json['currentProgress'];
    totalProgress = json['totalProgress'];
  }
  int? cashMoney;
  String? cashType;
  int? currentProgress;
  int? totalProgress;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cashMoney'] = cashMoney;
    map['cashType'] = cashType;
    map['currentProgress'] = currentProgress;
    map['totalProgress'] = totalProgress;
    return map;
  }

}