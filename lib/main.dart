import 'package:basic_project/providers/auth_provider.dart';
import 'package:basic_project/providers/language_provider.dart';
import 'package:basic_project/providers/theme_provider.dart';
import 'package:basic_project/screens/about_screen.dart';
import 'package:basic_project/screens/auth_screen.dart';
import 'package:basic_project/screens/home_screen.dart';
import 'package:basic_project/screens/setting_screen.dart';
import 'package:basic_project/screens/splash_screen.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();


//to edit the navigation and status bar
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   systemNavigationBarColor: Colors.blue, // navigation bar color
  //   statusBarColor: Colors.blue,
  // )); // status b

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AuthProvider()),
        ChangeNotifierProvider.value(value: LanguageProvider()),
        ChangeNotifierProvider.value(value: ThemeProvider()),
      ],
      child: Consumer<AuthProvider>(
        builder: (context, auth, _) => MaterialApp(
          
          title: 'Basic App',
          themeMode: Provider.of<ThemeProvider>(context).tm,
          darkTheme: ThemeData(
              primarySwatch: Provider.of<ThemeProvider>(context).primaryColor,
              accentColor: Provider.of<ThemeProvider>(context).accentColor,
              canvasColor:
                  Color.fromRGBO(11, 22, 55, 1), //this for the background
              cardColor: Colors.indigo[900],
              buttonTheme: ButtonThemeData(buttonColor: Colors.red),
              unselectedWidgetColor: Colors.white70,
              textTheme: ThemeData.dark().textTheme.copyWith(
                  headline1:
                      TextStyle(color: Colors.white70, fontFamily: "Raleway"),
                  headline2:
                      TextStyle(color: Colors.white70, fontFamily: "Raleway"),
                  headline3:
                      TextStyle(color: Colors.white70, fontFamily: "Raleway"),
                  headline5:
                      TextStyle(color: Colors.white70, fontFamily: "Raleway"),
                  headline6:
                      TextStyle(color: Colors.white70, fontFamily: "Raleway"),
                  subtitle1:
                      TextStyle(color: Colors.grey, fontFamily: "Raleway"))),
          theme: ThemeData(
              primarySwatch: Provider.of<ThemeProvider>(context).primaryColor,
              accentColor: Provider.of<ThemeProvider>(context).accentColor,
              canvasColor:
                  Color.fromRGBO(255, 255, 250, 1), //this for the background
              cardColor: Colors.indigo[300],
              buttonTheme: ButtonThemeData(buttonColor: Colors.red),
              unselectedWidgetColor: Colors.black,
              textTheme: ThemeData.light().textTheme.copyWith(
                  headline1:
                      TextStyle(color: Colors.black, fontFamily: "Raleway"),
                  headline2:
                      TextStyle(color: Colors.black, fontFamily: "Raleway"),
                  headline3:
                      TextStyle(color: Colors.black, fontFamily: "Raleway"),
                  headline5:
                      TextStyle(color: Colors.black, fontFamily: "Raleway"),
                  headline6:
                      TextStyle(color: Colors.black, fontFamily: "Raleway"),
                  subtitle1:
                      TextStyle(color: Colors.black45, fontFamily: "Raleway"))),
          home: auth.isAuth
              ? HomeScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogIn(),
                  builder: (ctx, AsyncSnapshot authSnapshot) =>
                      authSnapshot.connectionState == ConnectionState.waiting
                          ? SplashScreen()
                          : AuthScreen()),
        ),
      ),
    );
  }
}
