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
      onGenerateRoute: onGenerateRoute
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey<FormState> _formKey = GlobalKey();
  var _isShowClear = false;
  var _isShowPwd = false;
  FocusNode _focusNodeUserName = new FocusNode();
  FocusNode _focusNodePassWord = new FocusNode();
  String USERS_TZRY = "users_tzry";
  String USERS_COMPANY = "users_company";
  String user = 'users_tzry';
  String inputInfo = "请输入身份证或手机号码";
  var usernameController = new TextEditingController();
  var pwdController = new TextEditingController();
  String username;
  String pwd;
  String token;

  XmlDocument responseXML;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: GestureDetector(
        onTap: () {
          print("空白区域");
          _focusNodePassWord.unfocus();
          _focusNodeUserName.unfocus();
        },
        child: Container(
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                Center(
                  child: Container(
                    height: 100,
                    width: 100,
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
                            this.inputInfo = "请输入企业名称";
                          });
                        },
                      ),
                    ),
                  ],
                ),
                TextFormField(
                  controller: usernameController,
                  keyboardType: TextInputType.number,
                  focusNode: _focusNodeUserName,
                  decoration: InputDecoration(
                    labelText: "用户名",
                    hintText: '${this.inputInfo}',
                    prefixIcon: Icon(Icons.person),
                    suffixIcon: (_isShowClear)
                        ? IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              usernameController.clear();
                            },
                          )
                        : null,
                  ),
                  validator: validateUserName,
                ),
                // inputText(
                //   text: '${this.inputInfo}',
                //   password: false,
                //   controller: usernameController,
                // ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: pwdController,
                  focusNode: _focusNodePassWord,
                  decoration: InputDecoration(
                      labelText: "密码",
                      hintText: "请输入密码",
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon((_isShowPwd)
                            ? Icons.visibility
                            : Icons.visibility_off),
                        // 点击改变显示或隐藏密码
                        onPressed: () {
                          setState(() {
                            _isShowPwd = !_isShowPwd;
                          });
                        },
                      )),
                  obscureText: !_isShowPwd,
                  validator: validatePassWord,
                ),
                // inputText(
                //   text: "用户密码",
                //   password: true,
                //   controller: pwdController,
                // ),
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
                    _focusNodePassWord.unfocus();
                    _focusNodeUserName.unfocus();
                    if (_formKey.currentState.validate()) {
                      //只有输入通过验证，才会执行这里
                      //todo 登录操作
                      print("账号：" + usernameController.text);
                      print("密码：" + pwdController.text);
                      Login();
                    }
                  },
                ),
              ],
            ),
          ),
          padding: EdgeInsets.all(30),
        ),
      ),
    );
  }

  String validateUserName(value) {
    RegExp phoneExp = RegExp(
        r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');
    RegExp idCardExp =RegExp(r'^[1-9]\d{5}(18|19|([23]\d))\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\d{3}[0-9Xx]$');
    /*
    注释：编码规则顺序从左至右依次为6位数字地址码，8位数字出生年份日期码，3位数字顺序码，1位数字校验码（可为x）。

[1-9]\d{5}                 前六位地区，非0打头

(18|19|([23]\d))\d{2}      出身年份，覆盖范围为 1800-3999 年

((0[1-9])|(10|11|12))      月份，01-12月

(([0-2][1-9])|10|20|30|31) 日期，01-31天

\d{3}[0-9Xx]：              顺序码三位 + 一位校验码
    */

    if (value.isEmpty) {
      return '用户名不能为空!';
    } else if (value.length==11) {
      if(!phoneExp.hasMatch(value)){
      return '请输入正确的手机号';
      }else{
        return null;
      }
      
    }else if(value.length==18){
      if(!idCardExp.hasMatch(value)){
      return '请输入正确的身份证号码';
      }else{
        return null;
      }
    }else{
      return '请输入正确身份证号码或者手机号';
    }
  }

  String validatePassWord(value) {
    if (value.isEmpty) {
      return '密码不能为空';
    } else if (value.trim().length < 8) {
      return '密码长度不正确';
    }
    return null;
  }

  Future<void> Login() async {
    username = usernameController.text;
    pwd = pwdController.text;
    //await postLogin();
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
