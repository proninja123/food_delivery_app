import 'package:flutter/material.dart';

class CustomSpacer extends StatelessWidget {
  final double verticalMargin;

  final double horizontalMargin;

  CustomSpacer({
    this.verticalMargin=0,
    this.horizontalMargin=0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: verticalMargin,
      width: horizontalMargin,
    );
  }
}
