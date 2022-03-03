import 'package:flutter/material.dart';


import '../pages/splash_page.dart';
import '../pages/home_page.dart';
// lotto
import '../pages/lotto/lotto_page.dart';
import '../pages/lotto/prize_page.dart';
import '../pages/lotto/prize_detail_page.dart';
import '../pages/lotto/prize_bridge_page.dart';
import '../pages/lotto/lotto_suggest.dart';

class VLTxRoutes {
  static const splash = '/splash';
  static const home = '/';
  static const dashboard = '/dashboard';  
  static const notification = '/notification';
  static const settings = '/settings';
  // lotto
  static const lotto = '/lotto';
  static const suggest = '/lotto/suggest';
  static const prize = '/prize';
  static const detail = '/prize/detail';
  static const bridge = '/prize/bridge';

  static Map<String, WidgetBuilder> routes() {
    return <String, WidgetBuilder>{
      VLTxRoutes.splash: (context) => const SplashPage(),
      VLTxRoutes.home: (context) => const HomePage(),      
      // lotto
      VLTxRoutes.lotto: (context) => const LottoPage(),      
    };
  }
}
