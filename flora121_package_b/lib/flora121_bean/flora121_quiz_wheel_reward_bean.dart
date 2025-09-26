import 'package:flutter/material.dart';

class Flora121QuizWheelRewardType{
  static const String none="none";
  static const String received="received";
  static const String unReceived="unReceived";
}

class Flora121QuizWheelRewardBean{
  String? type;
  GlobalKey? globalKey;
  Flora121QuizWheelRewardBean({
    this.type,
    this.globalKey,
});

  Flora121QuizWheelRewardBean.fromJson(dynamic json) {
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    return map;
  }

}