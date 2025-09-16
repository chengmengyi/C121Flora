class Flora121QuizBean {
  Flora121QuizBean({
      this.question, 
      this.a, 
      this.b, 
      this.answer,
      this.selectedAnswer,
  });

  Flora121QuizBean.fromJson(dynamic json) {
    question = json['question'];
    a = json['a'];
    b = json['b'];
    answer = json['answer'];
  }
  String? question;
  String? a;
  String? b;
  String? answer;
  String? selectedAnswer;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['question'] = question;
    map['a'] = a;
    map['b'] = b;
    map['answer'] = answer;
    return map;
  }

}