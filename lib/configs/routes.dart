import 'package:flutter/material.dart';


import '../ui/error404_page.dart';
import '../ui/home/home_page.dart';
import '../ui/splash_page.dart';
// auth
import '../ui/auth/forgot_page.dart';
import '../ui/auth/login_page.dart';
import '../ui/auth/signup_page.dart';
import '../ui/auth/otp_page.dart';
import '../ui/auth/profile_page.dart';
import '../ui/auth/verify_email_page.dart';
// lotto
import '../ui/lotto/lotto_page.dart';
import '../ui/lotto/calendar_page.dart';

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
