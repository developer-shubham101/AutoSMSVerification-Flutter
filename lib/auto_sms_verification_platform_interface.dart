import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'auto_sms_verification_method_channel.dart';

abstract class AutoSmsVerificationPlatform extends PlatformInterface {
  /// Constructs a AutoSmsVerificationPlatform.
  AutoSmsVerificationPlatform() : super(token: _token);

  static final Object _token = Object();

  static AutoSmsVerificationPlatform _instance = MethodChannelAutoSmsVerification();

  /// The default instance of [AutoSmsVerificationPlatform] to use.
  ///
  /// Defaults to [MethodChannelAutoSmsVerification].
  static AutoSmsVerificationPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [AutoSmsVerificationPlatform] when
  /// they register themselves.
  static set instance(AutoSmsVerificationPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
