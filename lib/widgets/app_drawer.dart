import 'package:basic_project/providers/language_provider.dart';
import 'package:basic_project/screens/auth_form.dart';
import 'package:basic_project/screens/general_setting.dart';
import 'package:basic_project/screens/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/about_screen.dart';
// import 'package:store/models/user.dart';
// import 'package:provider/provider.dart';
// import 'package:store/screens/account-setting.dart';

class MyDrawer extends StatelessWidget {
  // final UserInformation brew;

  @override
  Widget build(BuildContext context) {
    bool _isthereuser = false;

    var txt = Provider.of<LanguageProvider>(context, listen: true);

    return Drawer(
        child: ListView(
      children: [
        UserAccountsDrawerHeader(
            accountName: Text(''
                // userData.name,
                ),
            accountEmail: Text(" "
                // userData.email,
                ),
            currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.blue[800], child: Icon(Icons.person)),
            decoration: BoxDecoration(
              color: Colors.blue[500],
              // image: DecorationImage(
              //   // image: AssetImage("assets/images/img.png" ),
              //   // fit: BoxFit.cover,
            )),
        ListTile(
          title: Text(txt.getTexts('home')),

          leading: Icon(
            Icons.home_outlined,
            color: Theme.of(context).primaryColor,
          ),
          // trailing: Icon(Icons.check_circle_outline),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => GeneralSetting()),
            );
          },
          contentPadding: EdgeInsets.fromLTRB(8, 0, 8, 0),
        ),
        // ListTile(
        //   title: Text('666'),
        //   leading: Icon(
        //     Icons.category_outlined,
        //     color: Theme.of(context).primaryColor,
        //   ),
        //   onTap: () {
        //     Navigator.of(context).pushNamed('Categories');
        //   },
        //   contentPadding: EdgeInsets.fromLTRB(8, 0, 8, 0),
        // ),
        Divider(
          thickness: 0.2,
        ),
        ListTile(
          title: Text(txt.getTexts('settings')),
          leading: Icon(
            Icons.settings_outlined,
            color: Theme.of(context).primaryColor,
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Settings()),
            );
          },
          contentPadding: EdgeInsets.fromLTRB(8, 0, 8, 0),
        ),
        ListTile(
          title: Text(txt.getTexts('about')),
          leading: Icon(
            Icons.info_outline_rounded,
            color: Theme.of(context).primaryColor,
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => About()),
            );
          },
          contentPadding: EdgeInsets.fromLTRB(8, 0, 8, 0),
        ),
        _isthereuser
            ? ListTile(
                title: Text(
                  ("Log out"),
                  style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).accentColor,
                  ),
                ),
                leading: Icon(
                  Icons.logout,
                  color: Theme.of(context).primaryColor,
                ),
                onTap: () {
                  showDialog(
                      builder: (context) {
                        return AlertDialog(
                          // backgroundColor: Color(0xFF73AEF5) ,
                          title: Text("Are you sure ?"),
                          content: Container(
                            height: 30,
                            child: Column(
                              children: [
                                Text("do you want to log out ?"),
                              ],
                            ),
                          ),
                          actions: [
                            // ignore: deprecated_member_use
                            FlatButton(
                                onPressed: () async {
                                  Navigator.of(context).pop();
                                  // await _auth.signOut();
                                },
                                child: Text('952')),
                            // ignore: deprecated_member_use
                            FlatButton(
                                onPressed: () {
                                  return Navigator.of(context).pop();
                                },
                                child: Text('54156'))
                          ],
                        );
                      },
                      context: context);
                },
                contentPadding: EdgeInsets.fromLTRB(8, 0, 8, 30),
              )
            : ListTile(
                title: Text(''),
                leading:
                    Icon(Icons.login, color: Theme.of(context).primaryColor),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AuthForm()),
                  );
                },
                contentPadding: EdgeInsets.fromLTRB(8, 0, 8, 0),
              ),
      ],
    ));
  }
}
