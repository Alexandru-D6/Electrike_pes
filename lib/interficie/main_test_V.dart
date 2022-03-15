import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project/interficie/constants.dart';

import 'widget/lateral_menu_widget.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'Electrike';

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: title,
    theme: ThemeData(
        primaryColor: mPrimaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    home: MainPage(),
  );
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class MainPager extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
    drawer: NavigationDrawerWidget(),
    // endDrawer: NavigationDrawerWidget(),
    appBar: AppBar(
      title: Text(MyApp.title),
    ),
  );
}