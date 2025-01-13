import 'package:flutter_test/flutter_test.dart';
import 'package:auto_sms_verification/auto_sms_verification.dart';
import 'package:auto_sms_verification/auto_sms_verification_platform_interface.dart';
import 'package:auto_sms_verification/auto_sms_verification_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockAutoSmsVerificationPlatform
    with MockPlatformInterfaceMixin
    implements AutoSmsVerificationPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final AutoSmsVerificationPlatform initialPlatform = AutoSmsVerificationPlatform.instance;

  test('$MethodChannelAutoSmsVerification is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelAutoSmsVerification>());
  });

  test('getPlatformVersion', () async {
    AutoSmsVerification autoSmsVerificationPlugin = AutoSmsVerification();
    MockAutoSmsVerificationPlatform fakePlatform = MockAutoSmsVerificationPlatform();
    AutoSmsVerificationPlatform.instance = fakePlatform;

    expect(await autoSmsVerificationPlugin.getPlatformVersion(), '42');
  });
}
