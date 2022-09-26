
import 'package:food_delivery/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class FormInputWithHint extends StatelessWidget {
  final String label;
  final bool obscureText;
  final TextInputType keyboardType;
  final Icon prefixIcon;
  final Widget suffixIcon;
  final Key key;
  final String errorText;
  final Function onChanged;
  final FocusNode focusNode;
  final String initialValue;
  final String hintText;
  final int maxLine;
  final bool isEnabled;

  final double textFieldHeight;

  FormInputWithHint({
    @required this.label,
    this.obscureText = false,
    this.keyboardType,
    this.prefixIcon,
    this.suffixIcon,
    this.key,
    this.isEnabled = true,
    this.maxLine = 1,
    this.errorText,
    @required this.onChanged,
    @required this.focusNode,
    this.initialValue,
    this.hintText,
    this.textFieldHeight = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          child: Text(label,
              style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              )),
        ),
        SizedBox(
          height: 5,
        ),
        TextFormField(
          focusNode: focusNode,
          decoration: InputDecoration(
            filled: true,
            fillColor: head.withOpacity(0.2),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(width: 0, style: BorderStyle.none),
            ),
            contentPadding: EdgeInsets.symmetric(
              vertical: textFieldHeight,
              horizontal: 10,
            ),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            errorText: errorText,
            errorMaxLines: 3,
            hintText: hintText,
          ),
          style: TextStyle(fontSize: 18, letterSpacing: 0.7),
          obscureText: obscureText,
          keyboardType: keyboardType,
          maxLines: maxLine,
          key: key,
          //onChanged: onChanged,
          initialValue: initialValue,
        ),
      ],
    );
  }
}
