import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'auto_sms_verification_platform_interface.dart';

/// An implementation of [AutoSmsVerificationPlatform] that uses method channels.
class MethodChannelAutoSmsVerification extends AutoSmsVerificationPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('auto_sms_verification');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
