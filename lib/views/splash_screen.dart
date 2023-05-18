import 'package:flutter/material.dart';
import 'package:login_ui_api_task/services/token_handler.dart';
import 'package:login_ui_api_task/ui/widgets/progress_circle.dart';
import 'package:login_ui_api_task/utils/design_colors.dart';
import 'package:login_ui_api_task/views/home/home.dart';
import 'package:login_ui_api_task/views/login/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkToken();
  }

  void checkToken() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final String token = await TokenHandler.getToken();
      if (token.isNotEmpty) {
        if (mounted) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
            (route) => false,
          );
        }
      } else {
        if (mounted) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
            (route) => false,
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: DesignProgress(
        color: DesignColor.prepPruple,
      ),
    ));
  }
}
