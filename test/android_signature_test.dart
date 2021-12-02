import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:android_signature/android_signature.dart';

void main() {
  const MethodChannel channel = MethodChannel('android_signature');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await AndroidSignature.platformVersion, '42');
  });
}
