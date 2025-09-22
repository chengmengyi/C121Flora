class Flora121CashTaskConfigBean {
  Flora121CashTaskConfigBean({
      this.task1, 
      this.task2, 
      this.task3, 
      this.task4, 
      this.task5,});

  Flora121CashTaskConfigBean.fromJson(dynamic json) {
    if (json['task1'] != null) {
      task1 = [];
      json['task1'].forEach((v) {
        task1?.add(Task1.fromJson(v));
      });
    }
    if (json['task2'] != null) {
      task2 = [];
      json['task2'].forEach((v) {
        task2?.add(Task1.fromJson(v));
      });
    }
    if (json['task3'] != null) {
      task3 = [];
      json['task3'].forEach((v) {
        task3?.add(Task1.fromJson(v));
      });
    }
    if (json['task4'] != null) {
      task4 = [];
      json['task4'].forEach((v) {
        task4?.add(Task1.fromJson(v));
      });
    }
    if (json['task5'] != null) {
      task5 = [];
      json['task5'].forEach((v) {
        task5?.add(Task1.fromJson(v));
      });
    }
  }
  List<Task1>? task1;
  List<Task1>? task2;
  List<Task1>? task3;
  List<Task1>? task4;
  List<Task1>? task5;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (task1 != null) {
      map['task1'] = task1?.map((v) => v.toJson()).toList();
    }
    if (task2 != null) {
      map['task2'] = task2?.map((v) => v.toJson()).toList();
    }
    if (task3 != null) {
      map['task3'] = task3?.map((v) => v.toJson()).toList();
    }
    if (task4 != null) {
      map['task4'] = task4?.map((v) => v.toJson()).toList();
    }
    if (task5 != null) {
      map['task5'] = task5?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Task1 {
  Task1({
      this.taskName, 
      this.taskNum,});

  Task1.fromJson(dynamic json) {
    taskName = json['taskName'];
    taskNum = json['taskNum'];
  }
  String? taskName;
  int? taskNum;

  Task1 copy() => Task1(taskName: taskName, taskNum: taskNum);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['taskName'] = taskName;
    map['taskNum'] = taskNum;
    return map;
  }

  @override
  String toString() {
    return 'Task1{taskName: $taskName, taskNum: $taskNum}';
  }
}