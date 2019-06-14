import 'dart:async';

import 'package:flutter/services.dart';

class FlutterFreeStreamer {
  static const MethodChannel _channel =
      const MethodChannel('flutter_free_streamer');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<String> init(String url) async {
    var isLocal = url.indexOf("://")==-1;

    final Map<String, dynamic> params = <String, dynamic>{
      'url': url,
      'isLocal': isLocal,
    };

    var res = await _channel.invokeMethod('init', params);
    print(res);
    return 'res';
  }

  static Future<bool> play() async {
    var res = await _channel.invokeMethod('play');
    return res;
  }

  static Future<bool> pause() async {
    var res = await _channel.invokeMethod('pause');
    return res;
  }

  static Future<bool> resume() async {
    var res = await _channel.invokeMethod('resume');
    return res;
  }

  static Future<bool> stop() async {
    var res = await _channel.invokeMethod('stop');
    return res;
  }

  static Future<double> progress() async {
    var res = await _channel.invokeMethod('progress');
    return res;
  }

  static Future<double> duration() async {
    var res = await _channel.invokeMethod('duration');
    return res;
  }

  static Future<double> getVolume() async {
    var res = await _channel.invokeMethod('getVolume');
    return res;
  }

  static Future<bool> isPlaying() async {
    var res = await _channel.invokeMethod('isPlaying');
    return res;
  }

  static Future<bool> seek(time) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'time': time,
    };

    var res = await _channel.invokeMethod('seek', params);
    return res;
  }

  // 3播放中;1播放完成
  static Future<int> state() async {
    var res = await _channel.invokeMethod('state');
    return res;
  }

}
