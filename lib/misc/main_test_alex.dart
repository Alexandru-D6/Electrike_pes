import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project/domini/services/service_locator.dart';
import 'package:flutter_project/interficie/widget/google_map.dart';
import 'package:flutter_project/interficie/widget/lateral_menu_widget.dart';

import '../interficie/widget/search_bar_widget.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setUpLocator();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const String title = 'Electrike';

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: title,
    theme: ThemeData(
      primaryColor: Colors.white,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    home: const MainPage(),
  );
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavigationDrawerWidget(),
      appBar: AppBar(
        title: const Text(MyApp.title),
        backgroundColor: Colors.black,
      ),
      body: Stack(
          fit: StackFit.expand,
          children: const [
            MyMap(),
            SearchBarWidget(),
          ],
      ),
    );
  }
}