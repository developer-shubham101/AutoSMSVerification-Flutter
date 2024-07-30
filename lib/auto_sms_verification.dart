import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';

class AutoSmsVerification {
  static const MethodChannel _channel =
      const MethodChannel('auto_sms_verification');

  /// Starts listening for SMS messages, only for Android platform
  static Future<String?> startListeningSms() async {
    if (Platform.isAndroid) {
      try {
        // Invoke the method to start listening for SMS messages
        final String result = await _channel.invokeMethod('startListening');
        print(result);
        return result;
      } catch (e) {
        // Return the error message in case of an exception
        return e.toString();
      }
    } else {
      // Return null for non-Android platforms
      return null;
    }
  }

  /// Stops listening for SMS messages, only for Android platform
  static Future<String?> stopListening() async {
    if (Platform.isAndroid) {
      // Invoke the method to stop listening for SMS messages
      final String smsCode = await _channel.invokeMethod('stopListening');
      return smsCode;
    } else {
      return null;
    }
  }

  /// Retrieves the app signature, only for Android platform
  static Future<String?> appSignature() async {
    if (Platform.isAndroid) {
      // Invoke the method to get the app signature
      final String signatureCode = await _channel.invokeMethod('appSignature');
      return signatureCode;
    } else {
      return null;
    }
  }
}
