import 'package:flutter/material.dart';
import 'config.dart' as Config;
import 'page/choose_labels.dart';
import 'page/choose_peoples.dart';
import 'page/chat.dart';
import 'page/circle.dart';
import 'page/focus_time.dart';
import 'widgets.dart';
import 'widget/circle_progress_bar.dart';
import 'extends/draglikes/drag_like.dart';
import 'routes.dart';

main() => runApp(MainApp());

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
        iconTheme: new IconThemeData(
          color: Colors.grey[700],
        ),
        hintColor: Colors.grey[400],
      ),
      home: _AppHome(),
      routes: {
        UIRoute.chooseLabels: (context) => ChooseLabels(),
        UIRoute.choosePeoples: (context) => ChoosePeoples(),
        UIRoute.chat: (context) => Chat(),
        UIRoute.circle: (context) => SmartCircle(),
        UIRoute.focusTime: (context) => FocusTime(),
      },
    );
  }
}

class _AppHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) => _AppPage();
}

class _AppPage extends StatefulWidget {
  _AppPage({Key key}) : super(key: key);

  @override
  _AppPageState createState() => _AppPageState();
}

class _AppPageState extends State<_AppPage> {
  double progress = 0.0;

  @override
  Widget build(BuildContext context) {
    return DragLikePage();
  }
}
