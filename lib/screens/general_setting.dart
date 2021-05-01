import 'package:basic_project/providers/language_provider.dart';
import 'package:basic_project/providers/theme_provider.dart';
import 'package:basic_project/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:slide_popup_dialog/slide_popup_dialog.dart' as slideDialog;

import 'package:provider/provider.dart';

class GeneralSetting extends StatelessWidget {
  static const routeName = "generalScreen";
  final bool fromOnBoarding;

  GeneralSetting({this.fromOnBoarding = false});

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);

    void _showLangDialog() {
      slideDialog.showSlideDialog(
        context: context,
        child: Provider.value(
          value:
              Provider.of<LanguageProvider>(context, listen: false).currentLang,
          child: Column(
            children: [
              buildLanguageListTile(
                  Languages.English, lan.getTexts("english"), context),
              buildLanguageListTile(
                  Languages.Arabic, lan.getTexts("arabic"), context),
              buildLanguageListTile(
                  Languages.Turkish, lan.getTexts("turkish"), context),
            ],
          ),
        ),
      );
    }

    return Directionality(
        textDirection: TextDirection.ltr,
        child: Scaffold(
          appBar: fromOnBoarding
              ? AppBar(
                  backgroundColor: Theme.of(context).canvasColor, elevation: 0)
              : AppBar(
                  title: Text(lan.getTexts("general_setting")),
                ),
          drawer: fromOnBoarding ? null : MyDrawer(),
          body: Column(
            children: [
              Expanded(
                  child: ListView(
                children: [
                  if (fromOnBoarding == false)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.all(20),
                          child: Text(lan.getTexts("language"),
                              style: Theme.of(context).textTheme.headline5),
                        ),
                        InkWell(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 12,left: 12),
                            child: Container(
                              child: Text(lan.getTexts("the_current_lang")),
                            ),
                          ),
                          onTap: _showLangDialog,
                        )
                      ],
                    ),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      lan.getTexts("theme_app"),
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                  buildRadioThemeListTile(ThemeMode.system,
                      lan.getTexts("System_default_theme"), null, context),
                  buildRadioThemeListTile(
                      ThemeMode.light,
                      lan.getTexts("light_theme"),
                      Icons.wb_sunny_outlined,
                      context),
                  buildRadioThemeListTile(
                      ThemeMode.dark,
                      lan.getTexts("dark_theme"),
                      Icons.nightlight_round,
                      context),
                  SizedBox(height: 40),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      lan.getTexts("color_scheme"),
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                  SizedBox(height: 8),
                  buildListTile(context, "primary"),
                  buildListTile(context, "accent"),
                  SizedBox(height: 30),
                  SizedBox(height: fromOnBoarding ? 80 : 1),
                ],
              )),
            ],
          ),
        ));
  }

  Widget buildLanguageListTile(
      Languages langvalue, String txt, BuildContext ctx2) {
    return ListTile(
        onTap: () {
          Provider.of<LanguageProvider>(ctx2, listen: false)
              .changeLanguage(langvalue);
          Navigator.of(ctx2).pop();
        },
        title: Text(
          txt,
          style: Theme.of(ctx2).textTheme.bodyText1,
        ));
  }

  Widget buildRadioThemeListTile(
      ThemeMode themeVal, String txt, IconData icon, BuildContext ctx1) {
    return RadioListTile(
        secondary: Icon(icon, color: Theme.of(ctx1).accentColor),
        value: themeVal,
        groupValue: Provider.of<ThemeProvider>(ctx1, listen: true).tm,
        onChanged: (newThemeVal) =>
            Provider.of<ThemeProvider>(ctx1, listen: false)
                .themeModeChange(newThemeVal),
        title: Text(
          txt,
          style: Theme.of(ctx1).textTheme.bodyText1,
        ));
  }

  ListTile buildListTile(BuildContext context, txt) {
    var primaryColor =
        Provider.of<ThemeProvider>(context, listen: true).primaryColor;
    var accentColor =
        Provider.of<ThemeProvider>(context, listen: true).accentColor;

    var lan = Provider.of<LanguageProvider>(context, listen: true);

    return ListTile(
      title: Text(
        txt == "primary" ? lan.getTexts("primary") : lan.getTexts("accent"),
        style: Theme.of(context).textTheme.bodyText1,
      ),
      trailing: CircleAvatar(
          backgroundColor: txt == "primary" ? primaryColor : accentColor),
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext ctx) {
              return Provider.value(
                  value: Provider.of<LanguageProvider>(ctx, listen: false)
                      .currentLang,
                  child: AlertDialog(
                    elevation: 4,
                    titlePadding: const EdgeInsets.all(0.0),
                    contentPadding: const EdgeInsets.all(0.0),
                    content: SingleChildScrollView(
                      child: ColorPicker(
                        pickerColor: txt == "primary"
                            ? Provider.of<ThemeProvider>(ctx, listen: true)
                                .primaryColor
                            : Provider.of<ThemeProvider>(ctx, listen: true)
                                .accentColor,
                        onColorChanged: (newColor) =>
                            Provider.of<ThemeProvider>(context, listen: false)
                                .onChanged(newColor, txt == "primary" ? 1 : 2),
                        colorPickerWidth: 300.0,
                        pickerAreaHeightPercent: 0.7,
                        enableAlpha: false,
                        displayThumbColor: true,
                        showLabel: false,
                      ),
                    ),
                  ));
            });
      },
    );
  }
}
