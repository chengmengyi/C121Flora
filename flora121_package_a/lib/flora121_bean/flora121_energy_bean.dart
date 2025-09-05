import 'package:flutter/material.dart';

class EnergyType{
  static const String water1="water1";
  static const String water2="water2";
  static const String sun="sun";
  static const String fertilizer1="fertilizer1";
  static const String fertilizer2="fertilizer2";
}

class Flora121EnergyBean{
  Flora121EnergyBean({
    this.energyType,
    this.currentTime,
    this.totalTime,
    this.addNum,
    this.globalKey,
    this.show,
    this.taskType,
    this.offset,
    this.baseOffset,
    this.flowerCenter,
  });

  Flora121EnergyBean.fromJson(dynamic json) {
    energyType = json['energyType'];
    currentTime = json['currentTime'];
    totalTime = json['totalTime'];
    addNum = json['addNum'];
    taskType = json['taskType'];
  }

  String? energyType;
  int? currentTime;
  int? totalTime;
  int? addNum;
  String? taskType;
  bool? show;
  GlobalKey? globalKey;
  Offset? offset;
  Offset? baseOffset;
  Offset? flowerCenter;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['energyType'] = energyType;
    map['currentTime'] = currentTime;
    map['totalTime'] = totalTime;
    map['addNum'] = addNum;
    map['taskType'] = taskType;
    return map;
  }
}