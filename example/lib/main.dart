import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_free_streamer/flutter_free_streamer.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  var streamer = FlutterFreeStreamer((){
    print('网络播放失败');
  });

  @override
  void initState() {
    super.initState();

    //FlutterFreeStreamer();

    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: ListView(
          children: <Widget>[
            FlatButton(
              onPressed: () async {
                var result = await streamer.init('http://newconceptmp3.wordbye.com/1/en/E001.mp3');
                print(result);
                var result1 = await streamer.play();

                print('-----------------------------');
                print(result1);
//                new Timer(Duration(milliseconds: 300), (){
//                  FlutterFreeStreamer.pause();
//
//                });

              },
              child: Text('播放网上'),
            ),
            FlatButton(
              onPressed: () async {
                var result = await streamer.init('assets/audio.mp3');
                print(result);
                await streamer.play();

              },
              child: Text('播放本地'),
            ),
            FlatButton(
              onPressed: () async {
                var result = await streamer.progress();
                print(result);
              },
              child: Text('progress'),
            ),
            FlatButton(
              onPressed: () async {
                var result = await streamer.duration();
                print(result);
              },
              child: Text('duration'),
            ),
            FlatButton(
              onPressed: () async {
                var result = await streamer.seek(7.058);
                print(result);
              },
              child: Text('seek 10'),
            ),
            FlatButton(
              onPressed: () async {
                var result = await streamer.isPlaying();
                print(result);
              },
              child: Text('isPlaying'),
            ),
            FlatButton(
              onPressed: () async {
                var result = await streamer.state();
                print(result);
              },
              child: Text('state'),
            ),
          ],
        ),
      ),
    );
  }
}
