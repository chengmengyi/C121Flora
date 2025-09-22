import 'package:flora121_base/flora121_hep/flora121_hep.dart';

class Flora121ValueBean {
  Flora121ValueBean({
      this.oldUsersAward, 
      this.cashBubble, 
      this.giveUp, 
      this.dayCheckin, 
      this.diceAward, 
      this.wheelAward,
      this.quizAward,
      this.newUsersAward,
  });

  Flora121ValueBean.fromJson(dynamic json) {
    newUsersAward=json["new_users_award"];
    oldUsersAward = json['old_users_award'] != null ? OldUsersAward.fromJson(json['old_users_award']) : null;
    cashBubble = json['cash_bubble'] != null ? CashBubble.fromJson(json['cash_bubble']) : null;
    giveUp = json['give_up'] != null ? GiveUp.fromJson(json['give_up']) : null;
    dayCheckin = json['day_checkin'] != null ? DayCheckin.fromJson(json['day_checkin']) : null;
    diceAward = json['dice_award'] != null ? DiceAward.fromJson(json['dice_award']) : null;
    wheelAward = json['wheel_award'] != null ? WheelAward.fromJson(json['wheel_award']) : null;
    quizAward = json['quiz_award'] != null ? QuizAward.fromJson(json['quiz_award']) : null;
  }
  int? newUsersAward;
  OldUsersAward? oldUsersAward;
  CashBubble? cashBubble;
  GiveUp? giveUp;
  DayCheckin? dayCheckin;
  DiceAward? diceAward;
  WheelAward? wheelAward;
  QuizAward? quizAward;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["new_users_award"]=newUsersAward;
    if (oldUsersAward != null) {
      map['old_users_award'] = oldUsersAward?.toJson();
    }
    if (cashBubble != null) {
      map['cash_bubble'] = cashBubble?.toJson();
    }
    if (giveUp != null) {
      map['give_up'] = giveUp?.toJson();
    }
    if (dayCheckin != null) {
      map['day_checkin'] = dayCheckin?.toJson();
    }
    if (diceAward != null) {
      map['dice_award'] = diceAward?.toJson();
    }
    if (wheelAward != null) {
      map['wheel_award'] = wheelAward?.toJson();
    }
    if (quizAward != null) {
      map['quiz_award'] = quizAward?.toJson();
    }
    return map;
  }

}

class QuizAward {
  QuizAward({
    this.prize,});

  QuizAward.fromJson(dynamic json) {
    if (json['prize'] != null) {
      prize = [];
      json['prize'].forEach((v) {
        prize?.add(Prize.fromJson(v));
      });
    }
  }
  List<Prize>? prize;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (prize != null) {
      map['prize'] = prize?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}


class WheelAward {
  WheelAward({
      this.prize,});

  WheelAward.fromJson(dynamic json) {
    if (json['prize'] != null) {
      prize = [];
      json['prize'].forEach((v) {
        prize?.add(Prize.fromJson(v));
      });
    }
  }
  List<Prize>? prize;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (prize != null) {
      map['prize'] = prize?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Prize {
  Prize({
      this.firstNumber, 
      this.prize, 
      this.endNumber,});

  Prize.fromJson(dynamic json) {
    firstNumber = json['first_number'].toString().toDouble();
    var list = json['prize'];
    prize=[];
    if(null!=list){
      for(var value in list){
        prize?.add(value.toString().toDouble());
      }
    }
    endNumber = json['end_number'].toString().toDouble();
  }
  double? firstNumber;
  List<double>? prize;
  double? endNumber;
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['first_number'] = firstNumber;
    map['prize'] = prize;
    map['end_number'] = endNumber;
    return map;
  }

}

class DiceAward {
  DiceAward({
      this.prize,});

  DiceAward.fromJson(dynamic json) {
    if (json['prize'] != null) {
      prize = [];
      json['prize'].forEach((v) {
        prize?.add(Prize.fromJson(v));
      });
    }
  }
  List<Prize>? prize;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (prize != null) {
      map['prize'] = prize?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class DayCheckin {
  DayCheckin({
      this.prize,});

  DayCheckin.fromJson(dynamic json) {
    prize = json['prize'] != null ? json['prize'].cast<int>() : [];
  }
  List<int>? prize;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['prize'] = prize;
    return map;
  }

}

class GiveUp {
  GiveUp({
      this.quantity, 
      this.prize,});

  GiveUp.fromJson(dynamic json) {
    quantity = json['quantity'];
    if (json['prize'] != null) {
      prize = [];
      json['prize'].forEach((v) {
        prize?.add(Prize.fromJson(v));
      });
    }
  }
  int? quantity;
  List<Prize>? prize;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['quantity'] = quantity;
    if (prize != null) {
      map['prize'] = prize?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class CashBubble {
  CashBubble({
      this.prize,});

  CashBubble.fromJson(dynamic json) {
    if (json['prize'] != null) {
      prize = [];
      json['prize'].forEach((v) {
        prize?.add(Prize.fromJson(v));
      });
    }
  }
  List<Prize>? prize;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (prize != null) {
      map['prize'] = prize?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class OldUsersAward {
  OldUsersAward({
      this.prize,});

  OldUsersAward.fromJson(dynamic json) {
    if (json['prize'] != null) {
      prize = [];
      json['prize'].forEach((v) {
        prize?.add(Prize.fromJson(v));
      });
    }
  }
  List<Prize>? prize;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (prize != null) {
      map['prize'] = prize?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}
