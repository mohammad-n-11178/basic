import 'dart:async';
import 'package:basic_project/providers/auth_provider.dart';
import 'package:basic_project/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';
import '../providers/theme_provider.dart';
import '../shared/constants.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState()  {
    Provider.of<ThemeProvider>(context, listen: false).getThemeMode();
    Provider.of<LanguageProvider>(context, listen: false).getLanguage();
    Provider.of<ThemeProvider>(context, listen: false).getThemeColors();
    Provider.of<AuthProvider>(context, listen: false).tryAutoLogIn();


    super.initState();
    // Timer(
    //     Duration(seconds: 5),
    //     () => Navigator.of(context).pushReplacement(MaterialPageRoute(
    //         builder: (BuildContext context) => HomeScreen())));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        backgroundColor: Provider.of<ThemeProvider>(context).primaryColor,
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: Container(
                  height: 90,
                  width: 90,
                  child: Image.asset('assets/images/flutter.png'),
                ),
              ),
            ),
          ],
        ));
  }
}
