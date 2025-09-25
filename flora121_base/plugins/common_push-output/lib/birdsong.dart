import 'dart:async';

import 'package:flutter/services.dart';

class Birdsong {
  static Birdsong instance = Birdsong._internal();

  Birdsong._internal();

  final MethodChannel _method = const MethodChannel("hi.birdsong.birdsong/method");
  final EventChannel _event = EventChannel("hi.birdsong.birdsong/event");
  final StreamController<BirdsongResponse> _tap = StreamController.broadcast();
  final StreamController<BirdsongResponse> _trigger = StreamController.broadcast();

  Future<void> initialize({required BirdsongImage image, required String button}) async {
    assert(button.isNotEmpty);
    await _method.invokeMethod("initialize", {"image": image.toMap(), "button": button});
  }

  bool _received = false;

  void _receive() {
    if (_received) return;
    _received = true;
    _event.receiveBroadcastStream().listen((e) {
      switch (e["method"]) {
        case "tap":
          _tap.sink.add(BirdsongResponse.from(e["data"]));
          break;
        case "trigger":
          _trigger.sink.add(BirdsongResponse.from(e["data"]));
          break;
      }
    });
  }

  Stream<BirdsongResponse> get onTap {
    _receive();
    return _tap.stream;
  }

  Stream<BirdsongResponse> get onTrigger {
    _receive();
    return _trigger.stream;
  }

  Future<void> repeat({
    required List<BirdsongText> content,
    Duration duration = const Duration(hours: 1),
  }) async {
    await _method.invokeMethod("repeat", {
      "content": content.map((e) => e.toMap()).toList(),
      "duration": duration.inSeconds,
    });
  }

  Future<bool> subscribe({required String topic}) async {
    return (await _method.invokeMethod("subscribe", {"topic": topic})) == true;
  }

  Future<void> present({
    required List<BirdsongText> content,
    Duration duration = const Duration(minutes: 30),
  }) async {
    await _method.invokeMethod("present", {
      "content": content.map((e) => e.toMap()).toList(),
      "duration": duration.inSeconds,
    });
  }

  Future<void> request({bool allowGotoSettings = false}) async {
    await _method.invokeMethod("request", {"allow_goto_settings": allowGotoSettings});
  }

  Future<bool> has() async {
    return (await _method.invokeMethod("has")) == true;
  }

  Future<void> show({
    required int id,
    required String title,
    required String body,
    required String tag,
    String bigImage = "",
    String smallImage = "",
  }) async {
    assert(tag.isNotEmpty && tag != "firebase" && tag != "repeat" && tag != "present");
    await _method.invokeMethod("show", {
      "id": id,
      "title": title,
      "body": body,
      "tag": tag,
      "bigImage": bigImage,
      "smallImage": smallImage,
    });
  }
}

final class BirdsongText {
  final String title;
  final String body;

  BirdsongText({required this.title, required this.body});

  Map<String, dynamic> toMap() => {"title": title, "body": body};
}

final class BirdsongImage {
  final String big;
  final String small;

  BirdsongImage({required this.big, this.small = ""});

  Map<String, dynamic> toMap() => {"big": big, "small": small};
}

final class BirdsongResponse {
  final String source;

  BirdsongResponse({required this.source});

  factory BirdsongResponse.from(dynamic map) => BirdsongResponse(source: map["source"]);
}
