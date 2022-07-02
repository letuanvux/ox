import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';

class Utils
{
  static List<Widget> buildWidget<M>(List<M> models, Widget Function(int index, M model) builder) {
    return models.asMap().map<int, Widget>(
      (index, model) => MapEntry(index, builder(index, model))
    ).values.toList();
  }

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

  static ImageProvider<Object> getImageUrl(String url) {
    // Default image
    if (url.isEmpty) return const AssetImage("assets/images/bg.jpg");
    if (Uri.parse(url).host.isNotEmpty) {
      return Image.network(url).image;
    }  
    else{
      return AssetImage(url);
    } 
  }
}