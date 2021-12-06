import 'dart:async';

import 'package:auto_sms_verification/auto_sms_verification.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _smsCode = "";

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  @override
  void dispose() {
    AutoSmsVerification.stopListening();

    super.dispose();
  }

  Future<void> initPlatformState() async {
    var appSignature = await AutoSmsVerification.appSignature();
    print(['appSignature is ', appSignature]);
    var smsCode = await AutoSmsVerification.startListeningSms();
    setState(() {
      _smsCode = getCode(smsCode) ?? '';
    });
  }

  String? getCode(String? sms) {
    if (sms != null) {
      final intRegex = RegExp(r'\d+', multiLine: true);
      final code = intRegex.allMatches(sms).first.group(0);

      return code;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('SMS Code is: $_smsCode\n'),
        ),
      ),
    );
  }
}
