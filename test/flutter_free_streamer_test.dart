import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_free_streamer/flutter_free_streamer.dart';

void main() {
  const MethodChannel channel = MethodChannel('flutter_free_streamer');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await FlutterFreeStreamer.platformVersion, '42');
  });
}
