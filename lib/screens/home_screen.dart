import 'package:basic_project/providers/language_provider.dart';
import 'package:basic_project/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(Provider.of<LanguageProvider>(context)
            .getTexts("the_current_lang")),
      ),
      appBar: AppBar(),
      drawer: MyDrawer(),
    );
  }
}
