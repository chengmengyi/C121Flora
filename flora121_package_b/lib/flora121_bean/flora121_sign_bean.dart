class Flora121SignBean{
  String? signedTimer;
  int? addNum;
  int? day;
  Flora121SignBean({
    this.signedTimer,
    this.addNum,
    this.day,
  });

  Flora121SignBean.fromJson(dynamic json) {
    signedTimer = json['signedTimer'];
    addNum = json['addNum'];
    day = json['day'];
  }


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['signedTimer'] = signedTimer;
    map['addNum'] = addNum;
    map['day'] = day;
    return map;
  }
}