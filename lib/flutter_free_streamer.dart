import 'dart:async';
import 'dart:ui';

import 'package:flutter/services.dart';

class FlutterFreeStreamer {
   MethodChannel _channel = const MethodChannel('flutter_free_streamer');

  VoidCallback onChange;


  FlutterFreeStreamer(onChange){
    _channel.setMethodCallHandler(_audioPlayerStateChange);
    this.onChange = onChange;
  }

//  Future<String> get platformVersion async {
//    final String version = await _channel.invokeMethod('getPlatformVersion');
//    return version;
//  }

  Future<String> init(String url) async {
    var isLocal = url.indexOf("://")==-1;

    final Map<String, dynamic> params = <String, dynamic>{
      'url': url,
      'isLocal': isLocal,
    };

    var res = await _channel.invokeMethod('init', params);
    print(res);
    return 'res';
  }

  Future<bool> play() async {
    var res = await _channel.invokeMethod('play');
    return res;
  }

  Future<bool> pause() async {
    var res = await _channel.invokeMethod('pause');
    return res;
  }

  Future<bool> resume() async {
    var res = await _channel.invokeMethod('resume');
    return res;
  }

  Future<bool> stop() async {
    var res = await _channel.invokeMethod('stop');
    return res;
  }

  Future<double> progress() async {
    var res = await _channel.invokeMethod('progress');
    return res;
  }

  Future<double> duration() async {
    var res = await _channel.invokeMethod('duration');
    return res;
  }

  Future<double> getVolume() async {
    var res = await _channel.invokeMethod('getVolume');
    return res;
  }

  Future<bool> isPlaying() async {
    var res = await _channel.invokeMethod('isPlaying');
    return res;
  }

  Future<bool> seek(time) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'time': time,
    };

    var res = await _channel.invokeMethod('seek', params);
    return res;
  }

  // 3播放中;1播放完成
  Future<int> state() async {
    var res = await _channel.invokeMethod('state');
    return res;
  }


  Future<void> _audioPlayerStateChange(MethodCall call) async {
    switch (call.method) {
      case "audio.onError":
        var message = call.arguments;
        print(message);
        onChange();
        break;
      case "audio.onState":
        var message = call.arguments;
        break;
      default:
        throw new ArgumentError('Unknown method ${call.method} ');
    }
  }

}
