import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:todoappv2/view/screens/login_screen/login_screen.dart';
import 'package:todoappv2/view/screens/statistics/statistics_screen.dart';
import 'package:todoappv2/view_model/data/local/shared_keys.dart';
import 'package:todoappv2/view_model/data/local/shared_preference.dart';
import 'package:todoappv2/view_model/utilis/colors.dart';
import 'package:todoappv2/view_model/utilis/images.dart';
class TodoSplashScreen extends StatelessWidget {
  const TodoSplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        duration: 5000,
        splash: AppImages.logo,
        splashIconSize: 200,
        nextScreen: (LocalData.get(key: SharedKeys.token)!=null)?const StatisticsTaskScreen():const TodoLoginScreen(),
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: AppColors.background);
  }
}
