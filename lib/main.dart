import 'dart:async';
import 'package:food_delivery/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'utils/theme_config.dart';
import 'view_models/shared_pref_view_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  debugPaintSizeEnabled = false;
  runApp(MyApp());
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final isPlatformDark =
        WidgetsBinding.instance.window.platformBrightness == Brightness.dark;
    final initTheme = isPlatformDark ? darkBlueTheme : lightTheme;
    return ThemeProvider(
      initTheme: initTheme,
      child: Builder(
        builder: (context) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider.value(value: SharedPrefProvider()),
            ],
            child: GetMaterialApp(
              theme: ThemeProvider.of(context),
              debugShowCheckedModeBanner: false,
              home: SplashPage(),
              /*routes: {
                '/home': (BuildContext context) => new HomePage(),
                '/bottom': (BuildContext context) => new BottomBar(),
                '/restuarent': (BuildContext context) => new RestuarentPage(),
                '/cart': (BuildContext context) => new CartPage(),
              },*/
            ),
          );
        },
      ),
    );
  }
}
