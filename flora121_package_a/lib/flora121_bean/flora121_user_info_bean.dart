class Flora121UserInfoBean {
  Flora121UserInfoBean({
    this.id,
    this.headIcon,
    this.userId,
    this.healthNum,});

  Flora121UserInfoBean.fromJson(dynamic json) {
    id = json['id'];
    headIcon = json['headIcon'];
    userId = json['userId'];
    healthNum = json['healthNum'];
  }
  int? id;
  String? headIcon;
  String? userId;
  int? healthNum;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['headIcon'] = headIcon;
    map['userId'] = userId;
    map['healthNum'] = healthNum;
    return map;
  }
}