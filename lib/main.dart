import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:redrondo22/page/login_page.dart';
import 'package:redrondo22/page/view_page.dart';
import 'package:redrondo22/page/welcome_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GlobalKey<NavigatorState> navKey = new GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        navigatorKey: navKey,
        theme: ThemeData(fontFamily: 'Comfortaa'),
        initialRoute: WelcomePage.welcomePageUrl,
        routes: <String, WidgetBuilder>{
          LoginPage.loginPageUrl: (BuildContext context) => new LoginPage(),
          MainPage.mainPageUrl: (BuildContext context) => new MainPage(),
          WelcomePage.welcomePageUrl: (BuildContext context) =>
          new WelcomePage(),
        });
  }


}
