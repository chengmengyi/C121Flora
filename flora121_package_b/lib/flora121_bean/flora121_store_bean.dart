class Flora121StoreBean {
  Flora121StoreBean({
      this.head, 
      this.name, 
      this.storyCn, 
      this.storyEn,
      this.type,
  });

  Flora121StoreBean.fromJson(dynamic json) {
    head = json['head'];
    name = json['name'];
    storyCn = json['story_cn'];
    storyEn = json['story_en'];
    type = json['type'];
  }
  String? head;
  String? name;
  String? storyCn;
  String? storyEn;
  String? type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['head'] = head;
    map['name'] = name;
    map['story_cn'] = storyCn;
    map['story_en'] = storyEn;
    map['type'] = type;
    return map;
  }

}