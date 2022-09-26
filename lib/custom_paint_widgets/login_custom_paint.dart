import 'package:food_delivery/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginCustomPaint extends CustomPainter  {
   Paint _paint;
   Paint _semiPaint;

   Paint _rightBottomEndPaint;

  LoginCustomPaint() {
    _paint = Paint()
      ..style = PaintingStyle.fill
      ..color = head;

    _semiPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20
      ..color = Colors.white;

    _rightBottomEndPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = head;
  }

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint

    canvas.drawCircle(Offset(70, Get.height * 0.25), 90, _paint);
    canvas.drawCircle(Offset(10, Get.height * 0.18), 30, _semiPaint);
    canvas.drawCircle(Offset(Get.width, Get.height * 0.35), 90, _rightBottomEndPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}
