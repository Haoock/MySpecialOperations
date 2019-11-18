import 'dart:collection';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myspecialoperations/registerPages/comRegisterGlryPage.dart';
import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class comRegisterPage extends StatefulWidget {
  comRegisterPage({Key key}) : super(key: key);

  _comRegisterPageState createState() => _comRegisterPageState();
}

class _comRegisterPageState extends State<comRegisterPage> {
  Map data = {'dwid': '01', 'ejptid': '171001', 'zzfblj': '100000000'};
  static const key = "u1BvOHzUOcklgNpn1MaWvdn9DT4LyzSX";
  static const iv = "12345678";
  /*
  String username; //用户名  公司名
  String pwd; //密码
  String dwname; // 用户单位名称
  String dwaddrpro; // 单位地址（省）  【选】
  String dwaddrcity; // 单位地址（市）   【选】
  String dwaddr; // 单位地址
  String phone; // 单位联系电话
  String zzfblj; // 企业营业执照副本路径
  String zzjgdm; // 组织机构代码
  String ejptid; // 二级平台编码（用于审核注册申请） 【选】*/

  final usernameController = TextEditingController(); //用户名  公司名
  final pwdController1 = TextEditingController(); //密码1
  final pwdController2 = TextEditingController(); //密码2
  final dwnameController = TextEditingController(); // 用户单位名称
  final dwaddrController = TextEditingController(); // 单位地址
  final dwaddrcityController = TextEditingController(); // 单位地址
  final phoneController = TextEditingController(); // 单位联系电话
  final zzjgdmController = TextEditingController(); // 组织机构代码
  final dwbmController = TextEditingController(); // 单位编码
  var _imgPath;
  var companytype = {
    '01': '设备产权单位',
    '02': '安装单位',
    '03': '检测单位',
    '04': '施工单位',
    '05': '建设单位',
    '06': '监理单位',
    '07': '勘察单位',
    '08': '设计单位',
    '09': '考试中心'
  };
  var ejpt = {
    '171001': '徐州市安监站智慧安监',
    '171002': '徐州开发区智慧安监',
    '171003': '徐州贾汪区智慧安监',
    '171004': '徐州新城区智慧安监',
    '171005': '丰县建设工程智慧安监',
    '171006': '沛县建设工程智慧安监',
    '171007': '徐州铜山区智慧安监',
    '171008': '睢宁建设工程智慧安监',
    '171009': '新沂建设工程智慧安监',
    '171010': '邳州建设工程智慧安监',
    '171011': '徐州轨道交通智慧安监',
    '171012': '徐州高新区智慧安监',
    '171013': '徐州监察支队智慧安监'
  };
  var ejptid = {
    '171001',
    '171002',
    '171003',
    '171004',
    '171005',
    '171006',
    '171007',
    '171008',
    '171009',
    '171010',
    '171011',
    '171012',
    '171013'
  };
  var companytypeid = {'01', '02', '03', '04', '05', '06', '07', '08', '09'};
  var province = {
    '01': '安徽省',
    '02': '澳门特别行政区',
    '03': '北京市',
    '04': '重庆市',
    '05': '福建省',
    '06': '甘肃省',
    '07': '广东省',
    '08': '广西壮族自治区',
    '09': '贵州省',
    '10': '海南省',
    '11': '河北省',
    '12': '河南省',
    '13': '黑龙江省',
    '14': '湖北省',
    '15': '湖南省',
    '16': '吉林省',
    '17': '江苏省',
    '18': '江西省',
    '19': '辽宁省',
    '20': '内蒙古自治区',
    '21': '宁夏回族自治区',
    '22': '青海省',
    '23': '山东省',
    '24': '山西省',
    '25': '陕西省',
    '26': '上海市',
    '27': '四川省',
    '28': '天津市',
    '29': '西藏自治区',
    '30': '新疆维吾尔自治区',
    '31': '云南省',
    '32': '浙江省',
    '33': '台湾'
  };
  var provinceid = {
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    '07',
    '08',
    '09',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '29',
    '30',
    '31',
    '32',
    '33'
  };

  var pid = "01";
  var cid = "0101";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("企业注册"),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            child: Container(
              child: Text("注册申请",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18)),
              margin: EdgeInsets.only(left: 8, top: 8),
            ),
            color: Color.fromARGB(233, 233, 233, 233),
            height: 40,
          ),
          Container(
            margin: EdgeInsets.only(left: 8),
            child: Row(
              children: <Widget>[
                Text("用户名："),
                Expanded(
                  child: TextField(
                    controller: usernameController,
                    obscureText: false,
                    decoration: InputDecoration(
                        hintText: "请输入公司名", border: InputBorder.none),
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
                Text("   密  码 ："),
                Expanded(
                  child: TextField(
                    controller: pwdController1,
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: "不少于6位", border: InputBorder.none),
                  ),
                )
              ],
            ),
          ),
          Divider(
            height: 0,
          ),
          Container(
            margin: EdgeInsets.only(left: 8),
            child: Row(
              children: <Widget>[
                Text("确认密码："),
                Expanded(
                  child: TextField(
                    controller: pwdController2,
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: "请再次输入密码", border: InputBorder.none),
                  ),
                )
              ],
            ),
          ),
          Divider(
            height: 0,
          ),
          Container(
            child: Container(
              child: Row(
                children: <Widget>[
                  Text("企业信息",
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 18)),
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
                Text("单位类别："),
                Container(
                  child: DropdownButton<String>(
                    value: this.data['dwid'],
                    style: TextStyle(color: Colors.blue),
                    onChanged: (String newValue) {
                      setState(() {
                        this.data['dwid'] = newValue;
                      });
                    },
                    items: this
                        .companytypeid
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(this.companytype[value]),
                      );
                    }).toList(),
                  ),
                )
              ],
            ),
          ),
          Divider(
            height: 0,
          ),
          Container(
            margin: EdgeInsets.only(left: 8),
            child: Row(
              children: <Widget>[
                Text("二级平台："),
                Container(
                  child: DropdownButton<String>(
                    value: this.data['ejptid'],
                    style: TextStyle(color: Colors.blue),
                    onChanged: (String newValue) {
                      setState(() {
                        this.data['ejptid'] = newValue;
                      });
                    },
                    items: this
                        .ejptid
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(this.ejpt[value]),
                      );
                    }).toList(),
                  ),
                )
              ],
            ),
          ),
          Divider(
            height: 0,
          ),
          Container(
            margin: EdgeInsets.only(left: 8),
            child: Row(
              children: <Widget>[
                Text("单位名称："),
                Expanded(
                  child: TextField(
                    controller: dwnameController,
                    obscureText: false,
                    decoration:
                        InputDecoration(hintText: "", border: InputBorder.none),
                  ),
                )
              ],
            ),
          ),
          Divider(
            height: 0,
          ),
          Container(
            margin: EdgeInsets.only(left: 8),
            child: Row(
              children: <Widget>[
                Text("单位编码："),
                Expanded(
                  child: TextField(
                    controller: dwbmController,
                    obscureText: false,
                    decoration:
                        InputDecoration(hintText: "", border: InputBorder.none),
                  ),
                )
              ],
            ),
          ),
          Divider(
            height: 0,
          ),
          Container(
            margin: EdgeInsets.only(left: 8),
            child: Row(
              children: <Widget>[
                Text("组织机构代码："),
                Expanded(
                  child: TextField(
                    controller: zzjgdmController,
                    obscureText: false,
                    decoration:
                        InputDecoration(hintText: "", border: InputBorder.none),
                  ),
                )
              ],
            ),
          ),
          Divider(
            height: 0,
          ),
          Container(
            margin: EdgeInsets.only(left: 8),
            child: Row(
              children: <Widget>[
                Text("单位地址（省）："),
                Container(
                  child: DropdownButton<String>(
                    value: this.pid,
                    style: TextStyle(color: Colors.blue),
                    onChanged: (String newValue) {
                      setState(() {
                        this.pid = newValue;
                      });
                    },
                    items: this
                        .provinceid
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(this.province[value]),
                      );
                    }).toList(),
                  ),
                )
              ],
            ),
          ),
         
          Divider(
            height: 0,
          ),
          Container(
            margin: EdgeInsets.only(left: 8),
            child: Row(
              children: <Widget>[
                Text("单位地址(市)："),
                Expanded(
                  child: TextField(
                    controller: dwaddrcityController,
                    obscureText: false,
                    decoration:
                        InputDecoration(hintText: "", border: InputBorder.none),
                  ),
                )
              ],
            ),
          ),
          Divider(
            height: 0,
          ),
          Container(
            margin: EdgeInsets.only(left: 8),
            child: Row(
              children: <Widget>[
                Text("单位地址："),
                Expanded(
                  child: TextField(
                    controller: dwaddrController,
                    obscureText: false,
                    decoration:
                        InputDecoration(hintText: "", border: InputBorder.none),
                  ),
                )
              ],
            ),
          ),
          Divider(
            height: 0,
          ),
          Container(
            margin: EdgeInsets.only(left: 8),
            child: Row(
              children: <Widget>[
                Text("联系电话："),
                Expanded(
                  child: TextField(
                    controller: phoneController,
                    obscureText: false,
                    decoration:
                        InputDecoration(hintText: "", border: InputBorder.none),
                  ),
                )
              ],
            ),
          ),
          Divider(),
          Container(
            child: Container(
              child: Text("企业营业执照副本",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18)),
              margin: EdgeInsets.only(left: 8, top: 8),
            ),
            color: Color.fromARGB(233, 233, 233, 233),
            height: 40,
          ),
          Column(
            children: <Widget>[
              _ImageView(_imgPath),
              RaisedButton(
                onPressed: _takePhoto,
                child: Text("拍照"),
              ),
              RaisedButton(
                onPressed: _openGallery,
                child: Text("选择照片"),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(left: 30, right: 30, top: 8, bottom: 8),
            child: CupertinoButton(
              child: Text('下一步'),
              color: Colors.blue,
              onPressed: () {
                //_getImgByte();
                _restoreInfo();
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) =>
                          new comRegisterGlryPage(data: this.data)),
                );
              },
            ),
            color: Color.fromARGB(233, 233, 233, 233),
          )
        ],
      ),
    );
  }

  /*图片控件*/
  Widget _ImageView(imgPath) {
    if (imgPath == null) {
      return Center(
        child: Text("请选择图片或拍照"),
      );
    } else {
      return Image.file(
        imgPath,
        height: 200,
      );
    }
  }

  /*拍照*/
  _takePhoto() async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.camera, maxWidth: 1200, maxHeight: 1600);
    _getImgByte(image);
    setState(() {
      _imgPath = image;
    });
  }

  /*相册*/
  _openGallery() async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.gallery, maxWidth: 1200, maxHeight: 1600);
    _getImgByte(image);
    setState(() {
      _imgPath = image;
    });
  }

  Future<File> testCompressAndGetFile(File file, String targetPath) async {
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 88,
      rotate: 180,
    );

    print(file.lengthSync());
    print(result.lengthSync());

    return result;
  }

  void _getImgByte(image) async {
    List<int> imageBytes = await image.readAsBytes();
    this.data['zzfblj'] = base64Encode(imageBytes);
    //print(this.data['zzfblj']);
  }

  void _restoreInfo() async {
    this.data['username'] = usernameController.text; //用户名  公司名
    this.data['pwd'] = pwdController1.text; //密码
    this.data['dwname'] = dwnameController.text; // 用户单位名称
    this.data['dwaddr'] = dwaddrController.text; // 单位地址
    this.data['phone'] = phoneController.text; // 单位联系电话
    this.data['zzjgdm'] = zzjgdmController.text; // 组织机构代码
    this.data['dwbm'] = dwbmController.text; //单位编码
    this.data['dwaddrpro'] = province[this.pid];
    this.data['dwaddrcity'] = dwaddrcityController.text;
    
  }

}
