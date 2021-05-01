import 'package:basic_project/providers/language_provider.dart';
import 'package:basic_project/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart' as intl; //this for auto dirctionality
import 'dart:ui' as ui;

// import 'package:hexcolor/hexcolor.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    var txt = Provider.of<LanguageProvider>(context, listen: true);

    Widget buildRadioThemeListTile(
        ThemeMode themeVal, String txt, IconData icon, BuildContext ctx1) {
      return RadioListTile(
          secondary: Icon(icon, color: Theme.of(ctx1).accentColor),
          value: themeVal,
          groupValue: Provider.of<ThemeProvider>(ctx1, listen: true).tm,
          onChanged: (newThemeVal) {
            Provider.of<ThemeProvider>(ctx1, listen: false)
                .themeModeChange(newThemeVal);
            Navigator.of(context).pop();
          },
          title: Text(
            txt,
            style: Theme.of(ctx1).textTheme.bodyText1,
          ));
    }

    Widget buildRadioLanguageListTile(
        Languages langvalue, String text, BuildContext ctx2) {
      return RadioListTile(
          value: langvalue,
          groupValue:
              Provider.of<LanguageProvider>(ctx2, listen: true).currentLang,
          onChanged: (newlangvalue) {
            Provider.of<LanguageProvider>(ctx2, listen: false)
                .changeLanguage(langvalue);
            Navigator.of(context).pop();
          },
          title: Text(
            text,
            style: Theme.of(ctx2).textTheme.bodyText1,
          ));
    }

    _buildItem(
        String text, String text2, IconData icon, Color color, Function fun) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: InkWell(
          child: Row(
            children: [
              Icon(icon, color: color),
              SizedBox(width: 10),
              Text(text),
              Spacer(),
              Text(
                text2,
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.grey[300],
              ),
            ],
          ),
          onTap: fun,
        ),
      );
    }

    void _buildshowthemeDialog(BuildContext context) {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              buildRadioThemeListTile(ThemeMode.system,
                  txt.getTexts("System_default_theme"), null, context),
              buildRadioThemeListTile(
                  ThemeMode.light,
                  txt.getTexts("light_theme"),
                  Icons.wb_sunny_outlined,
                  context),
              buildRadioThemeListTile(ThemeMode.dark,
                  txt.getTexts("dark_theme"), Icons.nightlight_round, context),
            ]);
          });
    }

    void _buildshowLanguageSheet(BuildContext context) {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              buildRadioLanguageListTile(
                  Languages.English, txt.getTexts("english"), context),
              buildRadioLanguageListTile(
                  Languages.Arabic, txt.getTexts("arabic"), context),
              buildRadioLanguageListTile(
                  Languages.Turkish, txt.getTexts("turkish"), context),
            ]);
          });
    }

    return Directionality(
      textDirection:
          intl.Bidi.detectRtlDirectionality(txt.getTexts("test_direction"))
              ? ui.TextDirection.rtl
              : ui.TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Settings",
            style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(
              icon: Icon(Icons.arrow_back,
                  color: Provider.of<ThemeProvider>(context).accentColor),
              onPressed: () => Navigator.of(context).pop()),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 220,
                    child: Column(
                      children: [
                        Container(
                            margin: EdgeInsets.symmetric(horizontal: 10.0),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.blueAccent[100],
                                    Colors.blueAccent[200],
                                    Colors.blue,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(15.0),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 5.0,
                                    offset: Offset(3.0, 3.0),
                                    color: Colors.black.withOpacity(0.05),
                                    spreadRadius: 4.0,
                                  ),
                                ]),
                            height: 150)
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Row(
                      children: [
                        Spacer(),
                        Column(
                          children: [
                            CircleAvatar(
                              radius: 45,
                              backgroundImage: NetworkImage(
                                  "https://images.unsplash.com/photo-1598897516650-e4dc73d8e417?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=700&q=80"),
                            ),
                            Text("Alice Margret"),
                            Text(
                              "@aliceMargret",
                              style: TextStyle(color: Colors.grey[400]),
                            ),
                          ],
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                ],
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Text(
                  txt.getTexts("accout_settings"),
                  style: TextStyle(color: Colors.grey[400], fontSize: 13),
                ),
              ),
              Divider(),
              _buildItem(
                txt.getTexts("email"),
                "alice@email.com",
                Icons.alternate_email_outlined,
                Colors.blue,
                () {},
              ),
              SizedBox(height: 10),
              _buildItem(
                txt.getTexts("change_password"),
                "",
                Icons.lock_open_outlined,
                Colors.green,
                () {},
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: Text(
                  txt.getTexts("general_settings"),
                  style: TextStyle(color: Colors.grey[400], fontSize: 13),
                ),
              ),
              Divider(),
              _buildItem(
                txt.getTexts("language"),
                txt.getTexts("the_current_lang"),
                Icons.language_outlined,
                Colors.grey,
                () => _buildshowLanguageSheet(context),
              ),
              SizedBox(height: 10),
              _buildItem(
                txt.getTexts("theme_app"),
                Provider.of<ThemeProvider>(context).themeText,
                Icons.color_lens_outlined,
                Colors.indigo,
                () => _buildshowthemeDialog(context),
              ),
              SizedBox(height: 10),
              _buildItem(
                txt.getTexts("notifications"),
                "",
                Icons.notifications_none_outlined,
                Colors.orange,
                () {},
              ),
              Divider(),
              _buildItem(
                txt.getTexts("Logout"),
                "",
                Icons.login_outlined,
                Colors.red,
                () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
