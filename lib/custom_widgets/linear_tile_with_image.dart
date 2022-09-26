import 'package:food_delivery/utils/sizes.dart';
import 'package:flutter/material.dart';

class LinearTileWithImage extends StatelessWidget {
  final String title;
  final String imagePath;
  final double imageHeight;
  final double imageWidth;
  final double fontSize;
  final FontWeight fontWeight;
  final Color titleColor;

  LinearTileWithImage(
      {@required this.title,
      @required this.imagePath,
      this.imageHeight = Sizes.HEIGHT_35,
      this.imageWidth = Sizes.HEIGHT_35,
      this.fontSize = Sizes.FONT_14,
      this.fontWeight = FontWeight.w400,
      this.titleColor = Colors.black});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: TextStyle(
          color: titleColor,
          fontWeight: fontWeight,
          fontSize: fontSize,
        ),
      ),
      leading: Image(
        image: AssetImage(imagePath),
        height: imageHeight,
        width: imageWidth,
      ),
    );
  }
}
