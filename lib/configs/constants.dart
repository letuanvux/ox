import 'package:firebase_auth/firebase_auth.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';

FirebaseAuth auth = FirebaseAuth.instance;

class VLTx {
  static const apiKey = "AIzaSyBcTL5PUdS8ocpvY2Tv9Ke2zVl1MuPieXU";
  static const channelId = "UC8_LniraZUr0O9e2PjTW0vg";

  static Future<String> getDeviceId() async {
    String deviceId = '';
    DeviceInfoPlugin devicePlugin = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      final deviceInfo = await devicePlugin.androidInfo;
      deviceId = deviceInfo.androidId!;
    }
    if (Platform.isIOS) {
      final deviceInfo = await devicePlugin.iosInfo;
      deviceId = deviceInfo.identifierForVendor!;
    }
    return deviceId;
  }
}
