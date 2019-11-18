import 'package:flutter/material.dart';

class inputText extends StatelessWidget{
  final String text;
  final bool password;
  final bool isfocused;
  TextEditingController controller=new TextEditingController();
  inputText({Key key,this.text="输入内容",this.controller,this.password=false,this.isfocused=false}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        controller: this.controller,
        autofocus: this.isfocused,
        obscureText: this.password,
        decoration: InputDecoration(
          labelText: this.text,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(width: 10),
          ),
        ),
        onChanged: (value){
          print("值改变了");
        },
      ),
      height: 48.00,
    );
  }


}