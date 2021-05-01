import 'package:basic_project/providers/auth_provider.dart';
import 'package:basic_project/providers/language_provider.dart';
import 'package:basic_project/providers/theme_provider.dart';
import 'package:basic_project/screens/general_setting.dart';
import 'package:basic_project/screens/home_screen.dart';
import 'package:basic_project/screens/splash_screen.dart';
import 'package:basic_project/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'screens/setting_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();


//to edit the navigation and status bar
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   systemNavigationBarColor: Colors.blue, // navigation bar color
  //   statusBarColor: Colors.blue,
  // )); // status b

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<ThemeProvider>(
      create: (ctx) => ThemeProvider(),
    ),
    ChangeNotifierProvider<LanguageProvider>(
      create: (ctx) => LanguageProvider(),
    ),
    ChangeNotifierProvider<AuthProvider>(
      create: (ctx) => AuthProvider(),
    ),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
        home: MyHomePage());
  }
}
