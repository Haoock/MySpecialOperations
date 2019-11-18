import 'package:flutter/material.dart';

class inputButton extends StatelessWidget {
  final String text;
  final Color color;
  final double height;
  final Object cb;
  const inputButton({Key key,this.height=38,this.text="按钮",this.color=Colors.black12,this.cb=null}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell( 
      onTap: this.cb,
      child: Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(5),
        height: this.height,
        width: double.infinity,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: Text(
              "${text}",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      );
    
  }
}