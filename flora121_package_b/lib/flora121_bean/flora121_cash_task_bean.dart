class Flora121CashTaskBean {
  Flora121CashTaskBean({
      this.cashMoney, 
      this.cashType, 
      this.cashTaskIndex, 
      this.currentProgress, 
      this.totalProgress, 
      this.cashAccount,});

  Flora121CashTaskBean.fromJson(dynamic json) {
    cashMoney = json['cashMoney'];
    cashType = json['cashType'];
    cashTaskIndex = json['cashTaskIndex'];
    currentProgress = json['currentProgress'];
    totalProgress = json['totalProgress'];
    cashAccount = json['cashAccount'];
  }
  int? cashMoney;
  String? cashType;
  String? cashTaskIndex;
  String? currentProgress;
  String? totalProgress;
  String? cashAccount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cashMoney'] = cashMoney;
    map['cashType'] = cashType;
    map['cashTaskIndex'] = cashTaskIndex;
    map['currentProgress'] = currentProgress;
    map['totalProgress'] = totalProgress;
    map['cashAccount'] = cashAccount;
    return map;
  }

}