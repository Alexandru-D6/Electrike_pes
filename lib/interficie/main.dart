import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project/interficie/constants.dart';
import 'package:flutter_project/interficie/widget/my_map_widget.dart';

import 'widget/lateral_menu_widget.dart';
import 'widget/floating_text_field.dart';
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
          primaryColor: mPrimaryColor,
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
  Widget build(BuildContext context) => Scaffold(
        drawer: const NavigationDrawerWidget(),
        // endDrawer: NavigationDrawerWidget(),
        appBar: AppBar(
          title: const Text(MyApp.title),
          backgroundColor: mPrimaryColor,
        ),
        body: const MyMap(),
        floatingActionButton: FloatingActionButton(
          onPressed: (){},//_getMyLocation,
          tooltip: 'Zoom',
          child: const Icon(Icons.my_location),
        ),
      );

}
