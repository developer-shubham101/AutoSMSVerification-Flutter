# auto_sms_verification

With the `auto_sms_verification` plugin, you can perform SMS-based user verification in your Android app automatically, without requiring the user to manually type verification codes, and without requiring any extra app permissions.

Please check the original doc as well https://developers.google.com/identity/sms-retriever/overview

## Getting Started
### Import package
```dart
import 'package:auto_sms_verification/auto_sms_verification.dart';
```
### Get Signature Code
```dart
var appSignature = await AutoSmsVerification.appSignature();
```
### Add Widget
listen SMS

```dart
void _startListeningOtpCode() async {
    var sms = await AutoSmsVerification.startListeningSms();
    _smsCode = getCode(sms) ?? '';
}
```

Call function in initState
```dart
@override
void initState() {
    super.initState();
    _startListeningOtpCode();
}
```

Stop Listening on dispose function
```dart
@override
  void dispose() {
    AutoSmsVerification.stopListening();
    super.dispose();
  }
```

### Parse OTP from SMS
```dart
String? getCode(String? sms) {
    if (sms != null) {
      final intRegex = RegExp(r'\d+', multiLine: true);
      final code = intRegex.allMatches(sms).first.group(0);
      return code;
    }
    return null;
}
```

### Example Sms
```html
<#> MyApp: your one time code is 5664
fr4edrDVWsr
```


