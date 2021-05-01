import 'package:basic_project/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatelessWidget {
  final url = "MohammadRabieeNasri@my.uopeole.edu";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('About'),
          centerTitle: true,
        ),
        body: Container(
          child: Stack(
            children: [
              Container(
                  height: SizeConfig.safeBlockVertical * 20,
                  child: Center(
                      child: Text("Basic App",
                          style: TextStyle(
                            letterSpacing: 2.0,
                            fontSize: 26,
                          )))),
              SizedBox(
                height: SizeConfig.safeBlockVertical * 10,
              ),
              Container(
                  height: SizeConfig.safeBlockVertical * 28,
                  child: Center(
                      child: Text("version 0.0.1",
                          style: TextStyle(
                            color:
                                Theme.of(context).accentColor.withOpacity(0.5),
                            fontSize: 18,
                          )))),
              Container(
                height: SizeConfig.safeBlockVertical * 60,
                child: Center(
                  child: Image.asset(
                    "assets/images/flutter.png",
                    height: 80,
                    width: 80,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Container(
                height: SizeConfig.safeBlockVertical * 85,
                child: Center(
                    child: Text("Developed by:",
                        style: TextStyle(
                          color: Theme.of(context).accentColor.withOpacity(0.5),
                          fontSize: 16,
                        ))),
              ),
              Positioned(
                height: SizeConfig.safeBlockVertical * 100,
                width: SizeConfig.safeBlockVertical * 50,
                child: Container(
                  child: Center(
                    child: Container(
                      child: SelectableText.rich(
                          TextSpan(children: [
                            TextSpan(
                                text: "MohammadRabieeNasri@my.uopeole.edu",
                                style: TextStyle(color: Colors.blue)),
                          ]), onTap: () async {
                        try {
                          await canLaunch(url)
                              ? await launch(url)
                              : throw "Can not launch the url";
                        } catch (e) {
                          debugPrint(e.toString());
                        }
                      }),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
