import 'package:flutter/material.dart';


import '../pages/error404_page.dart';
import '../pages/splash_page.dart';
import '../pages/home_page.dart';
// auth
import '../pages/auth/forgot_page.dart';
import '../pages/auth/login_page.dart';
import '../pages/auth/signup_page.dart';
import '../pages/auth/otp_page.dart';
import '../pages/auth/profile_page.dart';
import '../pages/auth/verify_email_page.dart';
// lotto
import '../pages/lotto/lotto_page.dart';
import '../pages/lotto/calendar_page.dart';

class VLTxRoutes {
  static const home = '/home';
  static const splash = '/splash';
  static const error = '/error'; 
  static const notification = '/notification';
  static const settings = '/settings';
  // lotto
  static const lotto = '/lotto';
  static const calendar = '/lotto/calendar';
  static const suggest = '/lotto/suggest';
  static const prize = '/prize';
  static const detail = '/prize/detail';
  static const bridge = '/prize/bridge';
  // auth
  static const login = '/login';
  static const signup = '/signup';
  static const forgot = '/forgot';
  static const verify = '/verify';
  static const otp = '/otp';
  static const profile = '/profile';

  static Map<String, WidgetBuilder> routes() {
    return <String, WidgetBuilder>{ 
      VLTxRoutes.home: (context) => const HomePage(),   
      VLTxRoutes.splash: (context) => const SplashPage(),
      VLTxRoutes.error: (context) => Error404Page(),      
      // Auth
      VLTxRoutes.signup: (context) => const SignupPage(),
      VLTxRoutes.login: (context) => const LoginPage(), 
      VLTxRoutes.forgot: (context) => const ForgotPage(),
      VLTxRoutes.verify: (context) => const VerifyEmailPage(),
      VLTxRoutes.profile: (context) => const ProfilePage(),  
      VLTxRoutes.otp: (context) => const OtpPage(),  
      // lotto
      VLTxRoutes.lotto: (context) => const LottoPage(),   
      VLTxRoutes.calendar: (context) => const CalendarPage(),    

    };
  }
}
