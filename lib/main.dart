import 'package:flutter/material.dart';
import 'config.dart' as Config;
import 'page/choose_labels.dart';
import 'page/choose_peoples.dart';
import 'page/chat.dart';
import 'page/circle.dart';
import 'page/focus_time.dart';
import 'package:smart_life_lw/page/home.dart';
import 'package:smart_life_lw/page/user/user_home.dart';
import 'package:smart_life_lw/page/user/edit_profile.dart';
import 'package:smart_life_lw/page/user/login_page.dart' as ExtendsLogin;
import 'package:smart_life_lw/page/user/sign_up_page.dart' as ExtendsSignUp;
import 'package:smart_life_lw/page/splash_page.dart';
import 'routes.dart';

main() {
  ///初始化配置
  Config.GlobalConfig.init();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Config.TITLE,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.grey[50],
        scaffoldBackgroundColor: Colors.grey[50],
        dialogBackgroundColor: Colors.grey[50],
        primaryColorBrightness: Brightness.light,
        buttonColor: Colors.blue,
        iconTheme: IconThemeData(
          color: Colors.grey,
        ),
        hintColor: Colors.grey[400],
      ),
      home: Splash(),
      routes: {
        UIRoute.home: (ctx) => AppHome(),
        UIRoute.choose_labels: (context) => ChooseLabels(),
        UIRoute.choose_peoples: (context) => ChoosePeoples(),
        UIRoute.chat: (context) => Chat(),
        UIRoute.circle: (context) => SmartCircle(),
        UIRoute.focus_time: (context) => FocusTime(),
        UIRoute.login_page: (ctx) => ExtendsLogin.LoginPage(),
        UIRoute.sign_up_page: (ctx) => ExtendsSignUp.SignUpPage(),
        UIRoute.user_home: (ctx) => UserHomePage(),
        UIRoute.edit_profile: (ctx) => EditProfilePage(),
      },
    );
  }
}
