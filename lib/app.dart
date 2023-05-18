import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:login_ui_api_task/routes.dart';
import 'package:login_ui_api_task/theme.dart';
import 'package:login_ui_api_task/ui/theme/text.dart';
import 'package:login_ui_api_task/utils/constants.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  late SnackBar noInternetSnackBar;
  @override
  void initState() {
    super.initState();
    noInternetSnackBar = SnackBar(
      content: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(
            Icons.info,
            color: Colors.white,
          ),
          SizedBox(width: 6),
          DesignText(
            'No Internet Connection',
            fontSize: 12,
            fontWeight: 600,
            color: Colors.white,
          )
        ],
      ),
      duration: const Duration(seconds: 30),
      backgroundColor: Colors.black.withOpacity(0.85),
      behavior: SnackBarBehavior.floating,
    );
    Connectivity().onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.none) {
        scaffoldMessengerKey.currentState!.showSnackBar(noInternetSnackBar);
      } else {
        scaffoldMessengerKey.currentState!.hideCurrentSnackBar();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: scaffoldMessengerKey,
      title: Constants.appName,
      routes: appRoutes,
      themeMode: ThemeMode.light, //darkMode.isDark ? ThemeMode.dark :
      theme: theme,
      darkTheme: darkTheme,
    );
  }
}
