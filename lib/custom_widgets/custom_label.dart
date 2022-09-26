import 'package:flutter/material.dart';

class CustomLabel extends StatelessWidget {
  final String label;

  final Color labelColor;
  final FontWeight labelWeight;

  final double labelSize;

  CustomLabel({
   @required this.label,
    this.labelColor = Colors.white,
    this.labelWeight = FontWeight.w700,
    this.labelSize = 14,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontFamily: 'Montserrat',
        color: labelColor,
        fontWeight: labelWeight,
        fontSize: labelSize,
      ),
    );
  }
}
