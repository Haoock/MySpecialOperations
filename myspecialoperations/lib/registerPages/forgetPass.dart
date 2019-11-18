import 'package:flutter/material.dart';
import '../widgets/inputButton.dart';

class ForgetPassPage extends StatefulWidget {
  ForgetPassPage({Key key}) : super(key: key);

  _ForgetPassPageState createState() => _ForgetPassPageState();
}

class _ForgetPassPageState extends State<ForgetPassPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("找 回 密 码"),  
      ),
      body: ListView(children: <Widget>[
        Container(
            margin: EdgeInsets.only(left: 8,top: 4),
            child: Row(
              children: <Widget>[
                Text("   手 机 号 码      ",style: TextStyle(fontWeight: FontWeight.w200,color: Colors.black38),),
                Container(
                  width: 250,
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: "输入使用的手机号码", border: InputBorder.none),
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
                Text("   证 件 类 型      ",style: TextStyle(fontWeight: FontWeight.w200,color: Colors.black38),),
                Container(
                  width: 250,
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: "中国居民身份证", border: InputBorder.none,enabled: false,hintStyle: TextStyle(fontWeight: FontWeight.w200,color: Colors.black)),
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
                Text("   证 件 号 码      ",style: TextStyle(fontWeight: FontWeight.w200,color: Colors.black38),),
                Container(
                  width: 250,
                  child: TextField(
                    obscureText: false,
                    decoration: InputDecoration(
                        hintText: "请准确完整填写", border: InputBorder.none),
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
                Text("   新            密      ",style: TextStyle(fontWeight: FontWeight.w200,color: Colors.black38),),
                Container(
                  width: 250,
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: "不少于6位", border: InputBorder.none,),
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
                Text("   密 码 确 认      ",style: TextStyle(fontWeight: FontWeight.w200,color: Colors.black38),),
                Container(
                  width: 250,
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: "请再次输入密码", border: InputBorder.none,),
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
                Container(
                  width: 200,
                  child: TextField(
                    
                    decoration: InputDecoration(
                        hintText: "输入获取的短信验证码", border: InputBorder.none,),
                  ),),
                Container(
                  width: 150,
                  child: MaterialButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    child: Text("获取验证码"),
                    onPressed: (){},)
                ),
              ],
            ),
          ),
          Divider(
            height: 2,
          ),
          Container(
          padding: EdgeInsets.only(left: 30,right: 30,top: 8,bottom: 8),
          child: inputButton(text: "提交",color: Colors.blue),
          color: Color.fromARGB(233, 233, 233, 233),)
          
          

      ],), 
      );
  }
}