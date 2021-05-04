import 'package:basic_project/providers/language_provider.dart';
import 'package:basic_project/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
