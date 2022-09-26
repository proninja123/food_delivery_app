import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class FilledButton extends StatelessWidget {
  final double btnHeight;
  final double btnRadius;
  final FontWeight btnFontWeight;
  final String btnText;
  final Color btnColor;
  final double btnFontSize;
  final Color btnTextColor;
  FilledButton({
    this.btnHeight = 50,
    this.btnRadius = 8,
    this.btnFontWeight = FontWeight.w700,
    this.btnText,
    this.btnColor = button_red,
    this.btnFontSize = 14,
    this.btnTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(
            btnRadius,
          ),
        ),
        color: btnColor,
      ),
      height: btnHeight,
      width: double.infinity,
      child: Center(
        child: Text(
          btnText,
          style: TextStyle(
            fontFamily: 'Montserrat',
            color: btnTextColor,
            fontWeight: btnFontWeight,
            fontSize: btnFontSize,
          ),
        ),
      ),
    );
  }
}
