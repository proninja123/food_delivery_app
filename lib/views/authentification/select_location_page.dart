import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:food_delivery/custom_widgets/filled_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'add_custom_address.dart';
import '../../utils/app_colors.dart';

class SelectLocation extends StatefulWidget {
  final String userName ;

  SelectLocation(this.userName);

  @override
  _SelectLocationState createState() => _SelectLocationState();
}

class _SelectLocationState extends State<SelectLocation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 80,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: ThemeProvider.of(context).brightness ==
                                  Brightness.light
                              ? Colors.red.withOpacity(0.07)
                              : Color(0xff222C44).withOpacity(0.07),
                          spreadRadius: 20,
                          blurRadius: 20,
                          offset: Offset(0, 5))
                    ],
                    color:
                        ThemeProvider.of(context).brightness == Brightness.light
                            ? Colors.white
                            : Color(0xff222C44),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    )),
                child: Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Icon(
                            Icons.arrow_back,
                            color: ThemeProvider.of(context).brightness ==
                                    Brightness.light
                                ? head
                                : Colors.white,
                            size: 28,
                          )),
                      SizedBox(
                        width: 43,
                      ),
                      Text(
                        'Select your location',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: ThemeProvider.of(context).brightness ==
                                  Brightness.light
                              ? head
                              : Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 142,
                          width: 142,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.grey[300]),
                          child: Center(child: Text('Map Here')),
                        ),
                        SizedBox(
                          height: 34,
                        ),
                        Text(
                          'WHERE DO YOU LIVE/WORK?',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: ThemeProvider.of(context).brightness ==
                                    Brightness.light
                                ? head
                                : Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '77th Street. 90 W 22nd St, SD. 140301',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: ThemeProvider.of(context).brightness ==
                                    Brightness.light
                                ? head
                                : Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 28.0, right: 28, top: 150),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  AddAddress(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            var begin = Offset(1.0, 0.0);
                            var end = Offset.zero;
                            var curve = Curves.ease;

                            var tween = Tween(begin: begin, end: end)
                                .chain(CurveTween(curve: curve));

                            return SlideTransition(
                              position: animation.drive(tween),
                              child: child,
                            );
                          },
                        ));
                      },
                      child: FilledButton(
                        btnHeight: 56,
                        btnRadius: 8,
                        btnColor: button_red,
                        btnText: "Auto-Detect",
                        btnFontWeight: FontWeight.w400,
                      )/*Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          color: button_red,
                        ),
                        height: 56,
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Auto-Detect',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      )*/,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            ' Add a custom address',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: button_red,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
