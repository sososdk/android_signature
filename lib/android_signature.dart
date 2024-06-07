import 'dart:async';

import 'package:flutter/services.dart';

/// Get android package signature.
///
/// *Only working on `Android Devices`.*
class AndroidSignature {
  static const MethodChannel _channel =
      MethodChannel('sososdk.github.com/android_signature');

  /// Get Signatures.
  static Future<List<Uint8List>> get signatures =>
      _channel.invokeMethod<List>('getSignature').then(
          (value) => value!.map((e) => e as Uint8List).toList(growable: false));
}
