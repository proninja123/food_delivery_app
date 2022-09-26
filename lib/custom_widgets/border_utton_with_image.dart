import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ImageBorderButton extends StatelessWidget {
  final double btnHeight;
  final double btnRadius;
  final FontWeight btnFontWeight;
  final String btnText;
  final Color btnBackgroundColor;
  final double btnFontSize;
  final Color btnTextColor;
  final Color btnBorderColor;
  final String prefixImage;

  ImageBorderButton({
    this.btnHeight = 50,
    this.btnRadius = 8,
    this.btnFontWeight = FontWeight.w700,
    this.btnText,
    this.btnBackgroundColor = Colors.white,
    this.btnFontSize = 14,
    this.btnTextColor = Colors.white,
    this.btnBorderColor,
    this.prefixImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(btnRadius)),
        border: Border.all(
          color: btnBorderColor,
          width: 2,
        ),
      ),
      height: btnHeight,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                prefixImage,
                matchTextDirection: true,
                color: btnTextColor,
                height: 19,
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                btnText,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: btnTextColor,
                  fontWeight: btnFontWeight,
                  fontSize: btnFontSize,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
