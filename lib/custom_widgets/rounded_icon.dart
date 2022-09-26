import 'package:flutter/material.dart';

class RoundedIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final double iconSize ;

  RoundedIcon({
    @required this.icon,
    this.color = const Color(0xffCE4C3C),
    this.iconSize = 30,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Icon(
        icon,
        color: Colors.white,
        size: iconSize,
      ),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(
          50,
        ),
      ),
    );
  }
}
