import 'package:flutter/material.dart';

enum Flora121QuizWheelRewardType{
  none,received,unReceived,
}

class Flora121QuizWheelRewardBean{
  Flora121QuizWheelRewardType type;
  GlobalKey globalKey;
  Flora121QuizWheelRewardBean({
    required this.type,
    required this.globalKey,
});
}