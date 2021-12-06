import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';

class AutoSmsVerification {
  static const MethodChannel _channel =
      const MethodChannel('auto_sms_verification');

  static Future<String?> startListeningSms() async {
    if (Platform.isAndroid) {
      try {
        final String result = await _channel.invokeMethod('startListening');
        print(result);
        return result;
      } catch (e) {
        return e.toString();
      }
    } else {
      return null;
    }
  }

  static Future<String?> stopListening() async {
    if (Platform.isAndroid) {
      final String smsCode = await _channel.invokeMethod('stopListening');
      return smsCode;
    } else {
      return null;
    }
  }

  static Future<String?> appSignature() async {
    if (Platform.isAndroid) {
      final String signatureCode =
          await _channel.invokeMethod('appSignature');
      return signatureCode;
    } else {
      return null;
    }
  }
}
