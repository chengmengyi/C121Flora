class Flora121SignBean{
  String? signType;
  String? signedTimer;
  int? addNum;
  int? day;
  Flora121SignBean({
    this.signType,
    this.signedTimer,
    this.addNum,
    this.day,
  });

  Flora121SignBean.fromJson(dynamic json) {
    signType = json['signType'];
    signedTimer = json['signedTimer'];
    addNum = json['addNum'];
    day = json['day'];
  }


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['signType'] = signType;
    map['signedTimer'] = signedTimer;
    map['addNum'] = addNum;
    map['day'] = day;
    return map;
  }
}