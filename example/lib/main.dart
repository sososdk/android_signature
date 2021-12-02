import 'dart:async';
import 'dart:typed_data';

import 'package:android_signature/android_signature.dart';
import 'package:crypto/crypto.dart' as crypto;
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Uint8List>? _signatures;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    List<Uint8List> signatures = await AndroidSignature.signatures;

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _signatures = signatures;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('md5: ${_signatures?.map((e) => e.md5).join('\n')}\n'),
              Text('sha1: ${_signatures?.map((e) => e.sha1).join('\n')}\n'),
              Text('sha256: ${_signatures?.map((e) => e.sha256).join('\n')}\n'),
            ],
          ),
        ),
      ),
    );
  }
}

extension SignatureExtension on Uint8List {
  String get md5 => crypto.md5.convert(this).toString();

  String get sha1 => crypto.sha1.convert(this).toString();

  String get sha256 => crypto.sha256.convert(this).toString();
}
