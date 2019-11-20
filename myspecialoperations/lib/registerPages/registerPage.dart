import 'package:flutter/material.dart';
import '../widgets/inputButton.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:image/image.dart' as ex;
import 'idcardPage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:toast/toast.dart';

class RegisterFirstPage extends StatefulWidget {
  RegisterFirstPage({Key key}) : super(key: key);

  _RegisterFirstPageState createState() => _RegisterFirstPageState();
}

enum Character { man, woman }

class _RegisterFirstPageState extends State<RegisterFirstPage> {
  GlobalKey<FormState> _formKey = GlobalKey();
  String photoPath;
  final idCardController = TextEditingController();
  final passWordController = TextEditingController();
  final usernameController = TextEditingController();
  final phonenumController = TextEditingController();
  Character _character = Character.man;
  static const platform =
      const MethodChannel('samples.flutter.dev/myspecialoperations');
  String sex;
  String path = "/mnt/sdcard/img";
  File _image1;
  File _image2;
  File _image3;
  File _image4;
  File _image5;
  File _image6;
  File _image7;
  File _image8;
  File _image9;
  String username;
  Map data = Map();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("注册"),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            Container(
              child: Container(
                child: Text("基本信息",
                    style:
                        TextStyle(fontWeight: FontWeight.w400, fontSize: 18)),
                margin: EdgeInsets.only(left: 8, top: 8),
              ),
              color: Color.fromARGB(233, 233, 233, 233),
              height: 40,
            ),
            SizedBox(height: 3),
            Container(
              margin: EdgeInsets.only(left: 8),
              child: Row(
                children: <Widget>[
                  Text("证件类型："),
                  Container(
                    width: 280,
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: "中国居民身份证",
                          border: InputBorder.none,
                          enabled: false,
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.w200,
                              color: Colors.black)),
                    ),
                  )
                ],
              ),
            ),
            Divider(
              height: 2,
            ),
            Container(
                height: 200,
                child: AspectRatio(
                    aspectRatio: 16.0 / 9.0,
                    child: photoPath != null
                        ? Image.file(File(photoPath))
                        : Image.asset("images/idCard.png"))),
            Divider(
              height: 2,
            ),
            Container(
              padding: EdgeInsets.only(left: 30, right: 30, top: 8, bottom: 8),
              child: inputButton(
                text: "拍摄身份证照片",
                color: Colors.blue,
                cb: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(
                          builder: (context) => IdCardCameraPage()))
                      .then((obj) {
                    setState(() {
                      photoPath = obj["src"];
                    });
                  });
                },
              ),
            ),
            Divider(
              height: 2,
            ),
            Container(
              margin: EdgeInsets.only(left: 8),
              child: Row(
                children: <Widget>[
                  Text("证件号码："),
                  Container(
                    width: 280,
                    child: TextFormField(
                        controller: idCardController,
                        obscureText: false,
                        decoration: InputDecoration(
                            hintText: "请输入证件号码", border: InputBorder.none),
                        validator: validateIdCardNum,
                      )
                  )
                ],
              ),
            ),
            Divider(
              height: 2,
            ),
            Container(
              margin: EdgeInsets.only(left: 8),
              child: Row(
                children: <Widget>[
                  Text("   姓  名："),
                  Container(
                    width: 280,
                    child: TextFormField(
                      controller: usernameController,
                      obscureText: false,
                      decoration: InputDecoration(
                          hintText: "请输入真实姓名", border: InputBorder.none),
                      validator: validatePersonName,
                    ),
                  )
                ],
              ),
            ),
            Divider(
              height: 2,
            ),
            Container(
                margin: EdgeInsets.only(left: 8),
                child: Row(
                  children: <Widget>[
                    Text("   性  别："),
                    Radio(
                      value: Character.man,
                      groupValue: _character,
                      onChanged: (Character value) {
                        setState(() {
                          _character = value;
                          print(_character);
                        });
                      },
                    ),
                    Container(
                      child: Text("男"),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 5),
                      child: Radio(
                        value: Character.woman,
                        groupValue: _character,
                        onChanged: (Character value) {
                          setState(() {
                            _character = value;
                            print(_character);
                          });
                        },
                      ),
                    ),
                    Container(
                      child: Text("女"),
                    ),
                  ],
                )),
            Container(
              margin: EdgeInsets.only(left: 8),
              child: Row(
                children: <Widget>[
                  Text("   密  码 ："),
                  Container(
                    width: 280,
                    child: TextFormField(
                      controller: passWordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: "不少于8位",
                          border: InputBorder.none),
                      validator: validatePassword,
                    ),
                  )
                ],
              ),
            ),
            Divider(
              height: 2,
            ),
            Container(
              margin: EdgeInsets.only(left: 8),
              child: Row(
                children: <Widget>[
                  Text("确认密码："),
                  Container(
                    width: 280,
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: "请再次输入密码", border: InputBorder.none),
                      validator: conformPassword,
                    ),
                  )
                ],
              ),
            ),
            Container(
              child: Container(
                child: Row(
                  children: <Widget>[
                    Text("详细信息",
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 18)),
                    Text("（用于身份验证，请务必正确填写）",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Color.fromARGB(192, 128, 138, 135)))
                  ],
                ),
                margin: EdgeInsets.only(left: 8, top: 4, bottom: 4),
              ),
              color: Color.fromARGB(233, 233, 233, 233),
              height: 40,
            ),
            Container(
              margin: EdgeInsets.only(left: 8),
              child: Row(
                children: <Widget>[
                  Text("手机号码(+86)："),
                  Container(
                    width: 248,
                    child: TextFormField(
                      controller: phonenumController,
                      obscureText: false,
                      decoration: InputDecoration(
                          hintText: "请准确填写您的手机号", border: InputBorder.none),
                      validator: validatePhoneNum,
                    ),
                  )
                ],
              ),
            ),
            Divider(
              height: 2,
            ),
            Container(
              margin: EdgeInsets.only(left: 8),
              child: Row(
                children: <Widget>[
                  Text("人脸拍照"),
                  Container(
                    width: 280,
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: "（请按照要求拍摄9张照片）",
                          border: InputBorder.none,
                          enabled: false,
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.w200,
                              color: Colors.black)),
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: double.infinity,
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 8),
              child: Row(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border(
                            left: BorderSide(width: 2.0),
                            top: BorderSide(width: 2.0),
                            right: BorderSide(width: 1.0))),
                    padding: EdgeInsets.only(right: 8),
                    height: 150,
                    width: 110,
                    child: _image1 == null ? Container() : Image.file(_image1),
                  ),
                  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border(
                            left: BorderSide(width: 1.0),
                            top: BorderSide(width: 2.0),
                            right: BorderSide(width: 1.0))),
                    padding: EdgeInsets.only(right: 8),
                    height: 150,
                    width: 110,
                    child: _image2 == null ? Container() : Image.file(_image2),
                  ),
                  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border(
                            left: BorderSide(width: 1.0),
                            top: BorderSide(width: 2.0),
                            right: BorderSide(width: 2.0))),
                    padding: EdgeInsets.only(right: 8),
                    height: 150,
                    width: 110,
                    child: _image3 == null ? Container() : Image.file(_image3),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 8),
              child: Row(
                children: <Widget>[
                  Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border: Border(
                              top: BorderSide(width: 1.0),
                              bottom: BorderSide(width: 1.0),
                              left: BorderSide(width: 2.0),
                              right: BorderSide(width: 1.0))),
                      padding: EdgeInsets.only(right: 8),
                      height: 50,
                      width: 110,
                      child: RaisedButton(
                        onPressed: () {
                          _onbuttonPressed();
                        },
                        child: Text("向左抬头"),
                        color: Colors.lightBlue,
                      )),
                  Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(width: 1.0),
                            bottom: BorderSide(width: 1.0),
                            left: BorderSide(width: 1.0),
                            right: BorderSide(width: 1.0)),
                      ),
                      padding: EdgeInsets.only(right: 8),
                      height: 50,
                      width: 110,
                      child: RaisedButton(
                        onPressed: () {},
                        child: Text("向前抬头"),
                        color: Colors.lightBlue,
                      )),
                  Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(width: 1.0),
                            bottom: BorderSide(width: 1.0),
                            left: BorderSide(width: 1.0),
                            right: BorderSide(width: 2.0)),
                      ),
                      padding: EdgeInsets.only(right: 8),
                      height: 50,
                      width: 110,
                      child: RaisedButton(
                        onPressed: () {},
                        child: Text("向右抬头"),
                        color: Colors.lightBlue,
                      )),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 8),
              child: Row(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border(
                            left: BorderSide(width: 2.0),
                            top: BorderSide(width: 1.0),
                            right: BorderSide(width: 1.0))),
                    padding: EdgeInsets.only(right: 8),
                    height: 150,
                    width: 110,
                    child: _image4 == null ? Container() : Image.file(_image4),
                  ),
                  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border(
                            left: BorderSide(width: 1.0),
                            top: BorderSide(width: 1.0),
                            right: BorderSide(width: 1.0))),
                    padding: EdgeInsets.only(right: 8),
                    height: 150,
                    width: 110,
                    child: _image5 == null ? Container() : Image.file(_image5),
                  ),
                  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border(
                            left: BorderSide(width: 1.0),
                            top: BorderSide(width: 1.0),
                            right: BorderSide(width: 2.0))),
                    padding: EdgeInsets.only(right: 8),
                    height: 150,
                    width: 110,
                    child: _image6 == null ? Container() : Image.file(_image6),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 8),
              child: Row(
                children: <Widget>[
                  Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border: Border(
                              top: BorderSide(width: 1.0),
                              bottom: BorderSide(width: 1.0),
                              left: BorderSide(width: 2.0),
                              right: BorderSide(width: 1.0))),
                      padding: EdgeInsets.only(right: 8),
                      height: 50,
                      width: 110,
                      child: RaisedButton(
                        onPressed: () {},
                        child: Text("向左看"),
                        color: Colors.lightBlue,
                      )),
                  Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(width: 1.0),
                            bottom: BorderSide(width: 1.0),
                            left: BorderSide(width: 1.0),
                            right: BorderSide(width: 1.0)),
                      ),
                      padding: EdgeInsets.only(right: 8),
                      height: 50,
                      width: 110,
                      child: RaisedButton(
                        onPressed: () {},
                        child: Text("向前看"),
                        color: Colors.lightBlue,
                      )),
                  Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(width: 1.0),
                            bottom: BorderSide(width: 1.0),
                            left: BorderSide(width: 1.0),
                            right: BorderSide(width: 2.0)),
                      ),
                      padding: EdgeInsets.only(right: 8),
                      height: 50,
                      width: 110,
                      child: RaisedButton(
                        onPressed: () {},
                        child: Text("向右看"),
                        color: Colors.lightBlue,
                      )),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 8),
              child: Row(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(width: 1.0),
                          left: BorderSide(width: 2.0),
                          right: BorderSide(width: 1.0)),
                    ),
                    padding: EdgeInsets.only(right: 8),
                    height: 150,
                    width: 110,
                    child: _image7 == null ? Container() : Image.file(_image7),
                  ),
                  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(width: 1.0),
                          left: BorderSide(width: 1.0),
                          right: BorderSide(width: 1.0)),
                    ),
                    padding: EdgeInsets.only(right: 8),
                    height: 150,
                    width: 110,
                    child: _image8 == null ? Container() : Image.file(_image8),
                  ),
                  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(width: 1.0),
                          left: BorderSide(width: 1.0),
                          right: BorderSide(width: 2.0)),
                    ),
                    padding: EdgeInsets.only(right: 8),
                    height: 150,
                    width: 110,
                    child: _image9 == null ? Container() : Image.file(_image9),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 8),
              child: Row(
                children: <Widget>[
                  Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border: Border(
                              top: BorderSide(width: 1.0),
                              bottom: BorderSide(width: 2.0),
                              left: BorderSide(width: 2.0),
                              right: BorderSide(width: 1.0))),
                      padding: EdgeInsets.only(right: 8),
                      height: 50,
                      width: 110,
                      child: RaisedButton(
                        onPressed: () {},
                        child: Text("向左低头"),
                        color: Colors.lightBlue,
                      )),
                  Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(width: 1.0),
                            bottom: BorderSide(width: 2.0),
                            left: BorderSide(width: 1.0),
                            right: BorderSide(width: 1.0)),
                      ),
                      padding: EdgeInsets.only(right: 8),
                      height: 50,
                      width: 110,
                      child: RaisedButton(
                        onPressed: () {},
                        child: Text("向前低头"),
                        color: Colors.lightBlue,
                      )),
                  Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(width: 1.0),
                            bottom: BorderSide(width: 2.0),
                            left: BorderSide(width: 1.0),
                            right: BorderSide(width: 2.0)),
                      ),
                      padding: EdgeInsets.only(right: 8),
                      height: 50,
                      width: 110,
                      child: RaisedButton(
                        onPressed: () {},
                        child: Text("向右低头"),
                        color: Colors.lightBlue,
                      )),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 30, right: 30, top: 8, bottom: 8),
              child: inputButton(
                text: "下一步",
                color: Colors.blue,
                cb: () {
                  if (_formKey.currentState.validate()) {
                    print("登录成功1111");
                    // if(_image1!=null){
                    // _provideDatas2();
                    // }else{
                    //   Toast.show("请拍摄人脸照片", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                    // }

                  }

                  // if(this.photoPath!=null){

                  // }else{
                  //   Toast.show("请先拍摄身份证照片", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                  // }

                  //_provideDatas(File(photoPath));
                },
              ),
              color: Color.fromARGB(233, 233, 233, 233),
            )
          ],
        ),
      ),
    );
  }

  // _provideDatas() async {
  //   try {
  //     Response response = await Dio().get(
  //         "http://192.168.43.100:8080/specialOperations/addinfo?idNum=${idCardController.text}&password=${passWordController.text}&name=${usernameController.text}&sex=${sex}&phoneNum=${phonenumController.text}");
  //     print(response);
  //   } catch (e) {
  //     print(e);
  //   }
  // }
  String validateIdCardNum(value) {
    print("这是身份证的号码"+value);
    RegExp idCardExp = RegExp(
        r'^[1-9]\d{5}(18|19|([23]\d))\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\d{3}[0-9Xx]$');
    if (value.isEmpty) {
      return '证件号码不能为空';
    } else if (!idCardExp.hasMatch(value)) {
      return '请输入正确的证件号码';
    }
    return null;
  }

  String validatePersonName(value) {
    print("这是人员姓名"+value);
    RegExp personName = RegExp(r'^([\u4e00-\u9fa5]){2,7}$');
    if (usernameController.text.isEmpty) {
      return '姓名不能为空';
    } else if (!personName.hasMatch(value)) {
      return '请输入2至7位的姓名';
    }
    return null;
  }

  String validatePassword(value) {
    print("这是密码"+value);
    RegExp psw = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$');
    if (value.isEmpty) {
      return '密码不能为空';
    } else if (!psw.hasMatch(value)) {
      return '请输入正确格式的密码';
    }
    return null;
  }

  String conformPassword(value) {
    print("这是确认密码"+value);
    if (value != passWordController.text) {
      return '两次输入的密码不一致';
    }
    return null;
  }

  String validatePhoneNum(value) {
    print("这是电话号码"+value);
    RegExp phoneExp = RegExp(
        r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');
    if (value.isEmpty) {
      return '手机号码不能为空';
    } else if (!phoneExp.hasMatch(value)) {
      return '请输入正确的手机号码';
    }
    return null;
  }

  void _provideDatas2() {
    this.data['username'] = idCardController.text;
    print("这是用户的身份证号码" + this.data['username']);
    this.data['ryxm'] = usernameController.text;
    print("这是用户的姓名" + this.data['ryxm']);
    if (_character == Character.woman) {
      this.data['sex'] = "0";
    } else {
      this.data['sex'] = "1";
    }
    print("这是用户的性别：" + data['sex']);
    this.data['psd'] = passWordController.text;
    print("这是用户的密码：" + data['psd']);
    this.data['phone'] = phonenumController.text;
    print("这是用户的手机号码" + data['phone']);
  }

  void _provideDatas(image) async {
    List<int> imageBytes = await image.readAsBytes();
    // List<int> pictureBytes1=await _image1.readAsBytes();
    // List<int> pictureBytes2=await _image1.readAsBytes();
    // List<int> pictureBytes3=await _image1.readAsBytes();
    // List<int> pictureBytes4=await _image1.readAsBytes();
    // List<int> pictureBytes5=await _image1.readAsBytes();
    // List<int> pictureBytes6=await _image1.readAsBytes();
    // List<int> pictureBytes7=await _image1.readAsBytes();
    // List<int> pictureBytes8=await _image1.readAsBytes();
    // List<int> pictureBytes9=await _image1.readAsBytes();
    this.data['sfzlj'] = base64Encode(imageBytes);
    this.data['username'] = idCardController.text;
    print("这是用户的身份证号码" + this.data['username']);
    this.data['ryxm'] = usernameController.text;
    print("这是用户的姓名" + this.data['ryxm']);
    if (_character == Character.woman) {
      this.data['sex'] = "0";
    } else {
      this.data['sex'] = "1";
    }
    print("这是用户的性别：" + data['sex']);
    this.data['psd'] = passWordController.text;
    print("这是用户的密码：" + data['psd']);
    this.data['phone'] = phonenumController.text;
    print("这是用户的手机号码" + data['phone']);
    // this.data['ybzp_1']=base64Encode(pictureBytes1);
    // this.data['ybzp_2']=base64Encode(pictureBytes2);
    // this.data['ybzp_3']=base64Encode(pictureBytes3);
    // this.data['ybzp_4']=base64Encode(pictureBytes4);
    // this.data['ybzp_5']=base64Encode(pictureBytes5);
    // this.data['ybzp_6']=base64Encode(pictureBytes6);
    // this.data['ybzp_7']=base64Encode(pictureBytes7);
    // this.data['ybzp_8']=base64Encode(pictureBytes8);
    // this.data['ybzp_9']=base64Encode(pictureBytes9);
    String soap = '''<soapenv:Envelope  
  xmlns:q0="http://DBUtil/"  
  xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"  
  xmlns:xsd="http://www.w3.org/2001/XMLSchema"  
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">  
  <soapenv:Header>
  </soapenv:Header>  
  <soapenv:Body> 
    <q0:insertTzzyInfo>''' +
        "<arg0>" +
        data['username'] +
        "</arg0>" +
        "<arg1>" +
        data['psd'] +
        "</arg1>" +
        "<arg2>" +
        data['ryxm'] +
        "</arg2>" +
        "<arg3>" +
        data['sex'] +
        "</arg3>" +
        "<arg4>" +
        data['sfzlj'] +
        "</arg4>" +
        "<arg5>" +
        "" +
        "</arg5>" +
        "<arg6>" +
        data['phone'] +
        "</arg6>" +
        "<arg7>" +
        "" +
        "</arg7>" +
        "<arg8>" +
        "" +
        "</arg8>" +
        "<arg9>" +
        "" +
        "</arg9>" +
        "<arg10>" +
        "" +
        "</arg10>" +
        "<arg11>" +
        "" +
        "</arg11>" +
        "<arg12>" +
        "" +
        "</arg12>" +
        "<arg13>" +
        "" +
        "</arg13>" +
        "<arg14>" +
        "" +
        "</arg14>" +
        "<arg15>" +
        "" +
        "</arg15>" +
        '''</q0:insertTzzyInfo>
</soapenv:Body>  
</soapenv:Envelope>  
''';
    http.Response response = await http.post(
      'http://47.100.95.17:8080/MytzzyJAXWS/DBTest',
      headers: {
        'Content-Type': 'text/xml;charset=UTF-8',
      },
      body: utf8.encode(soap),
    );
    if (response.statusCode == 200) {
      print(response.statusCode);
      print(response.body);
      print("注册成功。。。。。。。。。。。。。。。");
      Navigator.pushNamed(context, '/thirdPage');
    } else {
      print(response.statusCode);
      print(response.body);
      print("注册失败。。。。。。。。。。。。。。。");
      throw Exception("Error while fetching data");
    }
  }

  void _onbuttonPressed() async {
    try {
      String path_cachedir = await _toAndroidCamera();
//    _image1=await _toAndroidCamera();
      if (path_cachedir != null) {
//      _image2=File(path+"/pic2.jpg");
//      File[] list_of_file=cachedir.
        print(path_cachedir);
        print("试试");
        File pic1 = new File(path_cachedir + "/pic1.jpg");
        File pic2 = new File(path_cachedir + "/pic2.jpg");
        File pic3 = new File(path_cachedir + "/pic3.jpg");
        File pic4 = new File(path_cachedir + "/pic4.jpg");
        File pic5 = new File(path_cachedir + "/pic5.jpg");
        File pic6 = new File(path_cachedir + "/pic6.jpg");
        File pic7 = new File(path_cachedir + "/pic7.jpg");
        File pic8 = new File(path_cachedir + "/pic8.jpg");
        File pic9 = new File(path_cachedir + "/pic9.jpg");
//      _resizeIdcard(pic1);
//      _resizeIdcard(pic2);
//
//      _image2=pic2;
//      _image3=pic3;
//      _image4=pic4;
//      _image5=pic5;
//      _image6=pic6;
//      _image7=pic7;
//      _image8=pic8;
//      _image9=pic9;
        var bool1 = await pic1.exists();
        if (bool1) {
          _image1 = pic1;
        } else {
          print("pic1不存在！！！");
        }

        var bool2 = await pic2.exists();
        if (bool2) {
          _image2 = pic2;
        } else {
          print("pic2不存在！！！");
        }

        var bool3 = await pic3.exists();
        if (bool3) {
          _image3 = pic3;
        } else {
          print("pic3不存在！！！");
        }

        var bool4 = await pic4.exists();
        if (bool4) {
          _image4 = pic4;
        } else {
          print("pic4不存在！！！");
        }

        var bool5 = await pic5.exists();
        if (bool5) {
          _image5 = pic5;
        } else {
          print("pic5不存在！！！");
        }

        var bool6 = await pic6.exists();
        if (bool6) {
          _image6 = pic6;
        } else {
          print("pic6不存在！！！");
        }

        var bool7 = await pic7.exists();
        if (bool7) {
          _image7 = pic7;
        } else {
          print("pic7不存在！！！");
        }

        var bool8 = await pic8.exists();
        if (bool8) {
          _image8 = pic8;
        } else {
          print("pic8不存在！！！");
        }

        var bool9 = await pic9.exists();
        if (bool9) {
          _image9 = pic9;
        } else {
          print("pic9不存在！！！");
        }
      }
      setState(() {});
    } catch (e) {
      print("Failed onbuttonPressed '${e.message}'.");
    }
  }

  Future<String> _toAndroidCamera() async {
    String imagePath = await platform.invokeMethod('newCamera');
    print("这是------------------------" + imagePath);
    return imagePath == null ? null : imagePath;
  }
}
