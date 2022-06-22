import 'package:flutter/material.dart';



class VLTxTheme {
  static const String bgImage = "assets/images/bg_cloud.jpg";
  static const String notfoundImage = "assets/images/bg_cloud.jpg";

  static ImageProvider<Object> image(String url) {
    // Default image
    if (url.isEmpty) return const AssetImage(notfoundImage);
    if (Uri.parse(url).host.isNotEmpty) {
      return Image.network(url).image;
    }  
    else{
      return AssetImage(url);
    } 
  }

  static const kPrimaryColor = Colors.green;
  static const kSecondaryColor = Color(0xFFF5F6FC);
  static const kBgLightColor = Color(0xFFF2F4FC);
  static const kBgDarkColor = Color(0xFFEBEDFA);
  static const kBadgeColor = Color(0xFFEE376E);
  static const kGrayColor = Color(0xFF8793B2);
  static const kTitleTextColor = Color(0xFF30384D);
  static const kTextColor = Color(0xFF4D5875);

  static const double padding = 10;
  static const double radius = 5;
  static const duration = Duration(milliseconds: 250);

  static const gGrapeFruit =
      LinearGradient(colors: [Color(0xFFED5565), Color(0xFFDA4453)]);
  static const gMint =
      LinearGradient(colors: [Color(0xFF48CFAD), Color(0xFF37BC9B)]);
  static const gBitterSweet =
      LinearGradient(colors: [Color(0xFFFC6E51), Color(0xFFE9573F)]);
  static const gSunFlower =
      LinearGradient(colors: [Color(0xFFFFCE54), Color(0xFFF6BB42)]);
  static const gGrass =
      LinearGradient(colors: [Color(0xFFA0D468), Color(0xFF8CC152)]);
  static const gPinkRose =
      LinearGradient(colors: [Color(0xFFEC87C0), Color(0xFFD770AD)]);
  static const gLightGray =
      LinearGradient(colors: [Color(0xFFF5F7FA), Color(0xFFE6E9ED)]);

  static Color getColor(String hex) {
    return Color(int.parse("0xFF$hex"));
  }

  static BoxDecoration decoration = BoxDecoration(
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

  static BoxDecoration matchDecoration = BoxDecoration(
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
}
