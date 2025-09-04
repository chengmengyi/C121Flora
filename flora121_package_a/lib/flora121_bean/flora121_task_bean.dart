class Flora121TaskBean {
  Flora121TaskBean({
    this.taskText,
    this.timeStr,
    this.currentPro,
    this.totalPro,
    this.healthReward,
    this.taskType,
  });

  Flora121TaskBean.fromJson(dynamic json) {
    taskText = json['taskText'];
    timeStr = json['timeStr'];
    currentPro = json['currentPro'];
    totalPro = json['totalPro'];
    healthReward = json['healthReward'];
    taskType = json['taskType'];
  }
  String? taskText;
  String? timeStr;
  int? currentPro;
  int? totalPro;
  int? healthReward;
  String? taskType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['taskText'] = taskText;
    map['timeStr'] = timeStr;
    map['currentPro'] = currentPro;
    map['totalPro'] = totalPro;
    map['healthReward'] = healthReward;
    map['taskType'] = taskType;
    return map;
  }
}