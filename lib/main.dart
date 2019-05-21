import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import './arifu.dart';
import './jua.dart';
import './ongea.dart';
import 'more_pages/splash.dart';

void main() {
  runApp(Welinda());
}

class Welinda extends StatelessWidget {
  bool hasRun = false;

  Future<dynamic> checkIfFirstLaunch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('hasRun');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
        future: checkIfFirstLaunch(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          print('SNAPSHOT: ' + snapshot.data.toString());
          if (snapshot.data == null) {
            hasRun = false;
          } else {
            hasRun = true;
          }
          return MaterialApp(
              debugShowCheckedModeBanner : false,
            theme: ThemeData(
                primarySwatch: Colors.purple,
                accentColor: Color.fromRGBO(201, 230, 245, 1.0)),
            home: !hasRun
                ? MySplashScreen()
                : DefaultTabController(
                    length: 3,
                    child: Scaffold(
                      appBar: AppBar(
                        elevation:
                            Theme.of(context).platform == TargetPlatform.iOS
                                ? 0.0
                                : 4.0,
                        title: Text(
                          "WeLinda",
                        ),
                        centerTitle: true,
                        bottom: TabBar(tabs: [
                          Tab(
                            icon: Icon(Icons.info_outline),
                            text: 'Jua',
                          ),
                          Tab(
                            icon: Icon(Icons.import_contacts),
                            text: 'Arifu',
                          ),
                          Tab(
                            icon: Icon(Icons.forum),
                            text: 'Ongea',
                          )
                        ]),
                      ),
                      body: TabBarView(children: [
                        Jua(),
                        Arifu(),
                        Ongea(),
                      ]),
                    ),
                  ),
          );
        });
  }
}
