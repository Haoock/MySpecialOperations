import 'package:flutter/material.dart';
import 'dart:ui' as ui;

/// 图片裁剪
class ImageClipper extends CustomPainter {
  final ui.Image image;
  final double left;
  final double top;
  final double right;
  final double bottom;

  ImageClipper(this.image,{this.left = 0.5,this.top = 0.5,this.right = 0.5,this.bottom = 0.5});
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    Paint paint = Paint();
    canvas.drawImageRect(
        image,
        Rect.fromLTRB(image.width * left, image.height * top,
            image.width * right, image.height * bottom),
        Rect.fromLTWH(0, 0, size.width, size.height),
        paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}