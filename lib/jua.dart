import 'package:flutter/material.dart';

class Jua extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Card(
          child: Container(
              padding: EdgeInsets.only(
                left: 16.0,
              ),
              height: 250.0,
              child: Text(
                'Information',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
              )),
        ),
        Card(
          child: Container(
              padding: EdgeInsets.only(
                left: 16.0,
              ),
              height: 250.0,
              child: Text("There's hope",
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0))),
        ),
        Card(
          child: Container(
              padding: EdgeInsets.only(
                left: 16.0,
              ),
              height: 250.0,
              child: Text('Sexual Assault',
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0))),
        ),
      ],
    );
  }
}
