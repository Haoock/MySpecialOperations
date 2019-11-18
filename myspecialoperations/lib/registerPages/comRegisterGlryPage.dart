import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'package:xml/xml.dart' as xml;

class comRegisterGlryPage extends StatefulWidget {
  Map data;
  comRegisterGlryPage({@required this.data, Key key}) : super(key: key);

  _comRegisterGlryPageState createState() {
    this.data.forEach((k, v) => print('${k}:${v}'));
    _comRegisterGlryPageState mystate = new _comRegisterGlryPageState();
    mystate.getData(this.data);
    return mystate;
  }
}

class _comRegisterGlryPageState extends State<comRegisterGlryPage> {
  List glryxx = new List();
  Map<String, String> fddbr = new Map();
  Map<String, String> jsfzr = new Map();
  Map<String, String> aqfzr = new Map();
  Map data;
  var jszcbm = {'101', '102'};
  var jszc = {'101': '高级工程师', '102': '工程师'};
  final fd_zshm_controller = new TextEditingController();
  final fd_sfzh_controller = new TextEditingController();
  final fd_ryzw_controller = new TextEditingController();
  final fd_ryxm_controller = new TextEditingController();
  final fd_phone_controller = new TextEditingController();

  final js_zshm_controller = new TextEditingController();
  final js_sfzh_controller = new TextEditingController();
  final js_ryzw_controller = new TextEditingController();
  final js_ryxm_controller = new TextEditingController();
  final js_phone_controller = new TextEditingController();

  final aq_zshm_controller = new TextEditingController();
  final aq_sfzh_controller = new TextEditingController();
  final aq_ryzw_controller = new TextEditingController();
  final aq_ryxm_controller = new TextEditingController();
  final aq_phone_controller = new TextEditingController();

  final xkbm_controller = new TextEditingController();
  getData(Map _data) {
    data = _data;
  }

  @override
  Widget build(BuildContext context) {
    fddbr['jszcbm'] = '101';
    jsfzr['jszcbm'] = '102';
    aqfzr['jszcbm'] = '101';
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("企业注册"),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            child: Container(
              child: Text("企业管理人员:",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18)),
              margin: EdgeInsets.only(left: 8, top: 8),
            ),
            color: Color.fromARGB(233, 233, 233, 233),
            height: 40,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Divider(height: 0),
              Container(
                child: Container(
                  child: Text("法定代表人",
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 16)),
                  margin: EdgeInsets.only(left: 8, top: 8),
                ),
                color: Color.fromARGB(150, 233, 233, 233),
              ),
              Divider(height: 0),
              Container(
                margin: EdgeInsets.only(left: 8),
                child: Row(
                  children: <Widget>[
                    Text("证书号："),
                    Expanded(
                      child: TextField(
                        controller: fd_zshm_controller,
                        obscureText: false,
                        decoration: InputDecoration(
                            hintText: "", border: InputBorder.none),
                      ),
                    )
                  ],
                ),
              ),
              Divider(height: 0),
              Container(
                margin: EdgeInsets.only(left: 8),
                child: Row(
                  children: <Widget>[
                    Text("身份证号："),
                    Expanded(
                      child: TextField(
                        controller: fd_sfzh_controller,
                        obscureText: false,
                        decoration: InputDecoration(
                            hintText: "", border: InputBorder.none),
                      ),
                    )
                  ],
                ),
              ),
              Divider(height: 0),
              Container(
                margin: EdgeInsets.only(left: 8),
                child: Row(
                  children: <Widget>[
                    Text("职务："),
                    Expanded(
                      child: TextField(
                        controller: fd_ryzw_controller,
                        obscureText: false,
                        decoration: InputDecoration(
                            hintText: "", border: InputBorder.none),
                      ),
                    )
                  ],
                ),
              ),
              Divider(height: 0),
              Container(
                margin: EdgeInsets.only(left: 8),
                child: Row(
                  children: <Widget>[
                    Text("人员姓名："),
                    Expanded(
                      child: TextField(
                        controller: fd_ryxm_controller,
                        obscureText: false,
                        decoration: InputDecoration(
                            hintText: "", border: InputBorder.none),
                      ),
                    )
                  ],
                ),
              ),
              Divider(height: 0),
              Container(
                margin: EdgeInsets.only(left: 8),
                child: Row(
                  children: <Widget>[
                    Text("技术职称："),
                    Container(
                      child: DropdownButton<String>(
                        value: this.fddbr['jszcbm'],
                        style: TextStyle(color: Colors.blue),
                        onChanged: (String newValue) {
                          setState(() {
                            this.fddbr['jszcbm'] = newValue;
                          });
                        },
                        items: this
                            .jszcbm
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(this.jszc[value]),
                          );
                        }).toList(),
                      ),
                    )
                  ],
                ),
              ),
              Divider(height: 0),
              Container(
                margin: EdgeInsets.only(left: 8),
                child: Row(
                  children: <Widget>[
                    Text("电话："),
                    Expanded(
                      child: TextField(
                        controller: fd_phone_controller,
                        obscureText: false,
                        decoration: InputDecoration(
                            hintText: "", border: InputBorder.none),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Divider(height: 0),
              Container(
                child: Container(
                  child: Text("技术负责人",
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 16)),
                  margin: EdgeInsets.only(left: 8, top: 8),
                ),
                color: Color.fromARGB(150, 233, 233, 233),
              ),
              Divider(height: 0),
              Container(
                margin: EdgeInsets.only(left: 8),
                child: Row(
                  children: <Widget>[
                    Text("证书号："),
                    Expanded(
                      child: TextField(
                        controller: js_zshm_controller,
                        obscureText: false,
                        decoration: InputDecoration(
                            hintText: "", border: InputBorder.none),
                      ),
                    )
                  ],
                ),
              ),
              Divider(height: 0),
              Container(
                margin: EdgeInsets.only(left: 8),
                child: Row(
                  children: <Widget>[
                    Text("身份证号："),
                    Expanded(
                      child: TextField(
                        controller: js_sfzh_controller,
                        obscureText: false,
                        decoration: InputDecoration(
                            hintText: "", border: InputBorder.none),
                      ),
                    )
                  ],
                ),
              ),
              Divider(height: 0),
              Container(
                margin: EdgeInsets.only(left: 8),
                child: Row(
                  children: <Widget>[
                    Text("职务："),
                    Expanded(
                      child: TextField(
                        controller: js_ryzw_controller,
                        obscureText: false,
                        decoration: InputDecoration(
                            hintText: "", border: InputBorder.none),
                      ),
                    )
                  ],
                ),
              ),
              Divider(height: 0),
              Container(
                margin: EdgeInsets.only(left: 8),
                child: Row(
                  children: <Widget>[
                    Text("人员姓名："),
                    Expanded(
                      child: TextField(
                        controller: js_ryxm_controller,
                        obscureText: false,
                        decoration: InputDecoration(
                            hintText: "", border: InputBorder.none),
                      ),
                    )
                  ],
                ),
              ),
              Divider(height: 0),
              Container(
                margin: EdgeInsets.only(left: 8),
                child: Row(
                  children: <Widget>[
                    Text("技术职称："),
                    Container(
                      child: DropdownButton<String>(
                        value: this.jsfzr['jszcbm'],
                        style: TextStyle(color: Colors.blue),
                        onChanged: (String newValue) {
                          setState(() {
                            this.jsfzr['jszcbm'] = newValue;
                          });
                        },
                        items: this
                            .jszcbm
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(this.jszc[value]),
                          );
                        }).toList(),
                      ),
                    )
                  ],
                ),
              ),
              Divider(height: 0),
              Container(
                margin: EdgeInsets.only(left: 8),
                child: Row(
                  children: <Widget>[
                    Text("电话："),
                    Expanded(
                      child: TextField(
                        controller: js_phone_controller,
                        obscureText: false,
                        decoration: InputDecoration(
                            hintText: "", border: InputBorder.none),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Divider(height: 0),
              Container(
                child: Container(
                  child: Text("安全负责人",
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 16)),
                  margin: EdgeInsets.only(left: 8, top: 8),
                ),
                color: Color.fromARGB(150, 233, 233, 233),
              ),
              Divider(height: 0),
              Container(
                margin: EdgeInsets.only(left: 8),
                child: Row(
                  children: <Widget>[
                    Text("证书号："),
                    Expanded(
                      child: TextField(
                        controller: aq_zshm_controller,
                        obscureText: false,
                        decoration: InputDecoration(
                            hintText: "", border: InputBorder.none),
                      ),
                    )
                  ],
                ),
              ),
              Divider(height: 0),
              Container(
                margin: EdgeInsets.only(left: 8),
                child: Row(
                  children: <Widget>[
                    Text("身份证号："),
                    Expanded(
                      child: TextField(
                        controller: aq_sfzh_controller,
                        obscureText: false,
                        decoration: InputDecoration(
                            hintText: "", border: InputBorder.none),
                      ),
                    )
                  ],
                ),
              ),
              Divider(height: 0),
              Container(
                margin: EdgeInsets.only(left: 8),
                child: Row(
                  children: <Widget>[
                    Text("职务："),
                    Expanded(
                      child: TextField(
                        controller: aq_ryzw_controller,
                        obscureText: false,
                        decoration: InputDecoration(
                            hintText: "", border: InputBorder.none),
                      ),
                    )
                  ],
                ),
              ),
              Divider(height: 0),
              Container(
                margin: EdgeInsets.only(left: 8),
                child: Row(
                  children: <Widget>[
                    Text("人员姓名："),
                    Expanded(
                      child: TextField(
                        controller: aq_ryxm_controller,
                        obscureText: false,
                        decoration: InputDecoration(
                            hintText: "", border: InputBorder.none),
                      ),
                    )
                  ],
                ),
              ),
              Divider(height: 0),
              Container(
                margin: EdgeInsets.only(left: 8),
                child: Row(
                  children: <Widget>[
                    Text("技术职称："),
                    Container(
                      child: DropdownButton<String>(
                        value: this.aqfzr['jszcbm'],
                        style: TextStyle(color: Colors.blue),
                        onChanged: (String newValue) {
                          setState(() {
                            this.aqfzr['jszcbm'] = newValue;
                          });
                        },
                        items: this
                            .jszcbm
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(this.jszc[value]),
                          );
                        }).toList(),
                      ),
                    )
                  ],
                ),
              ),
              Divider(height: 0),
              Container(
                margin: EdgeInsets.only(left: 8),
                child: Row(
                  children: <Widget>[
                    Text("电话："),
                    Expanded(
                      child: TextField(
                        controller: aq_phone_controller,
                        obscureText: false,
                        decoration: InputDecoration(
                            hintText: "", border: InputBorder.none),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(left: 30, right: 30, top: 8, bottom: 8),
            child: CupertinoButton(
              child: Text('注册'),
              color: Colors.blue,
              onPressed: () {
                _PostInfo();
              },
            ),
            color: Color.fromARGB(233, 233, 233, 233),
          )
        ],
      ),
    );
  }

  void saveInfo() {
    fddbr['zshm'] = fd_zshm_controller.text;
    fddbr['sfzh'] = fd_sfzh_controller.text;
    fddbr['ryzw'] = fd_ryzw_controller.text;
    fddbr['ryxm'] = fd_ryxm_controller.text;
    fddbr['phone'] = fd_phone_controller.text;

    jsfzr['zshm'] = js_zshm_controller.text;
    jsfzr['sfzh'] = js_sfzh_controller.text;
    jsfzr['ryzw'] = js_ryzw_controller.text;
    jsfzr['ryxm'] = js_ryxm_controller.text;
    jsfzr['phone'] = js_phone_controller.text;

    aqfzr['zshm'] = aq_zshm_controller.text;
    aqfzr['sfzh'] = aq_sfzh_controller.text;
    aqfzr['ryzw'] = aq_ryzw_controller.text;
    aqfzr['ryxm'] = aq_ryxm_controller.text;
    aqfzr['phone'] = aq_phone_controller.text;

    data['xkbm'] = xkbm_controller.text;

    data.forEach((k, v) => print('{$k}:{$v}'));
    fddbr.forEach((k, v) => print('{$k}:{$v}'));
    jsfzr.forEach((k, v) => print('{$k}:{$v}'));
    aqfzr.forEach((k, v) => print('{$k}:{$v}'));
  }

  Future<void> _PostInfo() async {
    saveInfo();
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
        builder.element("insertCompanyInfo",namespace: q0, nest: () {
          builder.element("arg0", nest: data['username']);
          builder.element("arg1", nest: data['pwd']);
          builder.element("arg2", nest: data['ejptid']);

          builder.element("arg3", nest: data['dwbm']);
          builder.element("arg4", nest: data['dwid']);
          builder.element("arg5", nest: data['zzjgdm']);
          builder.element("arg6", nest: data['dwname']);
          builder.element("arg7", nest: data['dwaddrpro']);
          builder.element("arg8", nest: data['dwaddrcity']);
          builder.element("arg9", nest: data['dwaddr']);
          builder.element("arg10", nest: data['phone']);
          builder.element("arg11", nest: data['zzfblj']);

          builder.element("arg12", nest: fddbr['zshm']);
          builder.element("arg13", nest: fddbr['sfzh']);
          builder.element("arg14", nest: fddbr['ryzw']);
          builder.element("arg15", nest: fddbr['ryxm'] );
          builder.element("arg16", nest: fddbr['phone']);
          builder.element("arg17", nest: fddbr['jszcbm']);

          builder.element("arg18", nest: jsfzr['zshm']);
          builder.element("arg19", nest: jsfzr['sfzh']);
          builder.element("arg20", nest: jsfzr['ryzw']);
          builder.element("arg21", nest: jsfzr['ryxm']);
          builder.element("arg22", nest: jsfzr['phone']);
          builder.element("arg23", nest: jsfzr['jszcbm']);

          builder.element("arg24", nest: aqfzr['zshm']);
          builder.element("arg25", nest: aqfzr['sfzh']);
          builder.element("arg26", nest: aqfzr['ryzw']);
          builder.element("arg27", nest: aqfzr['ryxm']);
          builder.element("arg28", nest: aqfzr['phone']);
          builder.element("arg29", nest: aqfzr['jszcbm']);
        });
      });
    });

    var soapXML = builder.build();
    var soap = soapXML.toString();
    print(soap);
    http.Response response = await http.post(
      url,
      headers: {
        'Content-Type': 'text/xml;charset=UTF-8',
        'SOAPAction':''
      },
      body: utf8.encode(soap),
    );
    if (response.statusCode == 200) {
      print(response.statusCode);
      print(response.body);
      Toast.show('注册成功', context);
    } else {
      print(response.statusCode);
      print(response.body);
      //throw Exception("Error while fetching data");
      Toast.show('注册失败', context);
    }
  }
}
