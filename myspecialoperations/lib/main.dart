import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:xml/xml.dart';
import 'widgets/inputText.dart';
import 'routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
import 'package:permission_handler/permission_handler.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Myspecialoperations',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'LoginPage'),
        onGenerateRoute: onGenerateRoute);
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
    _MyHomePageState() {
    requestPermission();
  }
  String USERS_TZRY = "users_tzry";
  String USERS_COMPANY = "users_company";
  String user = 'users_tzry';
  String inputInfo = "身份证/手机号码";
  var usernameController = new TextEditingController();
  var pwdController = new TextEditingController();
  String username;
  String pwd;

  XmlDocument responseXML;
  String token;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Center(
              child: Container(
                height: 150,
                width: 150,
                child: Image.asset(
                  "images/avatar.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: RadioListTile<String>(
                    value: this.USERS_TZRY,
                    title: Text('特种人员', style: TextStyle(fontSize: 15)),
                    groupValue: this.user,
                    activeColor: Colors.blue,
                    onChanged: (value) {
                      setState(() {
                        this.user = value;
                        this.inputInfo = "身份证/手机号码";
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile<String>(
                    value: this.USERS_COMPANY,
                    title: Text('企业', style: TextStyle(fontSize: 15)),
                    groupValue: this.user,
                    activeColor: Colors.blue,
                    onChanged: (value) {
                      setState(() {
                        this.user = value;
                        this.inputInfo = "企业用户名";
                      });
                    },
                  ),
                ),
              ],
            ),
            inputText(
              text: '${this.inputInfo}',
              password: false,
              controller: usernameController,
            ),
            SizedBox(
              height: 10,
            ),
            inputText(
              text: "用户密码",
              password: true,
              controller: pwdController,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/forgetPass');
                      },
                      child: Text('找回密码', style: TextStyle(fontSize: 16)),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        if (this.user == this.USERS_TZRY) {
                          Navigator.pushNamed(context, '/registerFirst');
                        } else if (this.user == this.USERS_COMPANY) {
                          Navigator.pushNamed(context, '/comRegisterPage');
                        }
                      },
                      child: Text('新用户注册', style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            CupertinoButton(
              child: Text('登录'),
              color: Colors.blue,
              onPressed: () {
                Login();
                
              },
            ),
          ],
        ),
        padding: EdgeInsets.all(30),
      ),
    );
  }

  Future<void> Login() async {
    username = usernameController.text;
    pwd = pwdController.text;
    await postLogin();
  }

  Future<void> postLogin() async {
    //String url = 'http://10.0.2.2:8888/HellowordWeb/services/DBTest?wsdl';
    String url = 'http://47.100.95.17:8080/MytzzyJAXWS/DBTest?wsdl';

    var builder = new xml.XmlBuilder();
    final soapenv = "http://schemas.xmlsoap.org/soap/envelope/";
    final q0 = "http://DBUtil/";
    final xsd = "http://www.w3.org/2001/XMLSchema";
    final xsi = "http://www.w3.org/2001/XMLSchema-instance";
    builder.element("Envelope",namespace: soapenv,nest: () {
      builder.namespace(q0, "q0");
      builder.namespace(soapenv, "soapenv");
      builder.namespace(xsd, "xsd");
      builder.namespace(xsi, "xsi");
      builder.element("Header",namespace: soapenv);
      builder.element("Body",namespace: soapenv, nest: () {
        builder.element("login",namespace: q0, nest: () {
          builder.element("arg0", nest: xml.encodeXmlText(this.user));
          builder.element("arg1", nest: xml.encodeXmlText(this.username));
          builder.element("arg2", nest: xml.encodeXmlText(this.pwd));
        });
      });
    });

    var soapXML = builder.build();
    var soap = soapXML.toString();


    print(soap);
    http.Response response = await http.post(
      url,
      headers: {'Content-Type': 'text/xml;charset=UTF-8', 'SOAPAction': ''},
      body: utf8.encode(soap),
    );
    if (response.statusCode == 200) {
      print(response.statusCode);
      print(response.body);
      this.responseXML = xml.parse(response.body);
     
      var ret = this
          .responseXML
          .findAllElements("return")
          .map((node) => node.text)
          .first;
      if (ret=='true') {
        Toast.show('登录成功', context);
        Navigator.pushNamed(context, '/mainpage');
      } else {
        Toast.show('登录失败, 密码错误', context);
      }
    } else {
      print(response.statusCode);
      print(response.body);
      //throw Exception("Error while fetching data");
      Toast.show('登录失败， 系统错误', context);
    }
  }
  Future requestPermission() async {
    // 申请权限
    Map<PermissionGroup, PermissionStatus> permissions =
        await PermissionHandler().requestPermissions([PermissionGroup.storage]);
    // 申请结果
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.storage);
    if (permission == PermissionStatus.granted) {
      print("权限申请通过");
    } else {
      print("权限申请被拒绝");
    }
  }
}
