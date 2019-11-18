import 'package:flutter/material.dart';

class Mainpage extends StatefulWidget {
  Mainpage({Key key}) : super(key: key);

  @override
  _MainpageState createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("主页面"),
      ),
      body:Container(child: Text("登录成功！这是主页面"),)

    );
  }
}
