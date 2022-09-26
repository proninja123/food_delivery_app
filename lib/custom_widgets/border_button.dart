import 'package:flutter/material.dart';

class BorderButton extends StatelessWidget {
  final double btnHeight;
  final double btnRadius;
  final FontWeight btnFontWeight;
  final String btnText;
  final Color btnBackgroundColor;
  final double btnFontSize;
  final Color btnTextColor;
  final Color btnBorderColor;
final double btnWidth ;
  BorderButton({
    this.btnHeight = 50,
    this.btnRadius = 8,
    this.btnFontWeight = FontWeight.w700,
    this.btnText,
    this.btnBackgroundColor = Colors.white,
    this.btnFontSize = 14,
    this.btnTextColor = Colors.white,
    this.btnBorderColor,
    this.btnWidth=double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(btnRadius),
        ),
        border: Border.all(
          color: btnBorderColor,
        ),
      ),
      height: btnHeight,
      width: btnWidth,
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
