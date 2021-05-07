import 'package:basic_project/providers/auth_provider.dart';
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
        child: Column(children: [
          Text(Provider.of<LanguageProvider>(context)
              .getTexts("the_current_lang")),
          OutlinedButton(
              onPressed: () => Provider.of<AuthProvider>(context,listen: false).getUser(),
              child: Text("get_user"))
        ]),
      ),
      appBar: AppBar(),
      drawer: MyDrawer(),
    );
  }
}
