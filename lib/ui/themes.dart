import 'package:flutter/material.dart';

final boxDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: const BorderRadius.all(Radius.circular(5)),
  boxShadow: [
      BoxShadow(
      offset: const Offset(4, 4),
      blurRadius: 10,
      color: Colors.grey.withOpacity(.2),
    ),
    BoxShadow(
      offset: const Offset(-3, 0),
      blurRadius: 15,
      color: Colors.grey.withOpacity(.1),
    )
  ],
);

final matchDecoration = BoxDecoration(
  color: Colors.green.withOpacity(0.45),
  border: Border.all(color: Colors.green),
  borderRadius: const BorderRadius.all(Radius.circular(5)),
  boxShadow: [
      BoxShadow(
      offset: const Offset(4, 4),
      blurRadius: 10,
      color: Colors.grey.withOpacity(.2),
    ),
    BoxShadow(
      offset: const Offset(-3, 0),
      blurRadius: 15,
      color: Colors.grey.withOpacity(.1),
    )
  ],
);

class VLTxTheme
{
  static const String bgImage = "assets/images/bg_cloud.jpg";

  static const kPrimaryColor = Colors.green;
  static const kSecondaryColor = Color(0xFFF5F6FC);
  static const kBgLightColor = Color(0xFFF2F4FC);
  static const kBgDarkColor = Color(0xFFEBEDFA);
  static const kBadgeColor = Color(0xFFEE376E);
  static const kGrayColor = Color(0xFF8793B2);
  static const kTitleTextColor = Color(0xFF30384D);
  static const kTextColor = Color(0xFF4D5875);
  
  static const double defaultPadding = 10;
  static const double defaultRadius = 5;
  static const defaultDuration = Duration(milliseconds: 250);
}
