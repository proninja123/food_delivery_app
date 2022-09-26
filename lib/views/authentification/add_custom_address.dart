import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:food_delivery/custom_widgets/filled_button.dart';
import 'package:food_delivery/views/home_ui/bottom_bar_ui/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/app_colors.dart';

class AddAddress extends StatefulWidget {
  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  String _selectedLocation;
  FocusNode focusNode4 = new FocusNode();
  FocusNode focusNode1 = new FocusNode();
  FocusNode focusNode2 = new FocusNode();
  FocusNode focusNode3 = new FocusNode();
  bool current = false;
  bool custom = false;
  List<String> _locations = ['Home', 'Office'];

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
                        'Add address',
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
                padding: const EdgeInsets.only(top: 45.0, left: 36, right: 36),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        if (current == false) {
                          setState(() {
                            current = true;
                          });
                        } else {
                          setState(() {
                            current = false;
                          });
                        }
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 2.0, left: 8),
                            child: Container(
                              height: 13,
                              width: 13,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color:
                                        ThemeProvider.of(context).brightness ==
                                                Brightness.light
                                            ? Color(0xff8A94A3)
                                            : Colors.white),
                                color:
                                    current == true ? head : Colors.transparent,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Current Location',
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
                              Text(
                                'Using GPS',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: ThemeProvider.of(context).brightness ==
                                          Brightness.light
                                      ? head
                                      : Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: ThemeProvider.of(context).brightness ==
                                        Brightness.light
                                    ? Colors.red.withOpacity(0.07)
                                    : Color(0xff222C44).withOpacity(0.07),
                                spreadRadius: 16,
                                blurRadius: 16,
                                offset: Offset(0, 5))
                          ],
                          color: ThemeProvider.of(context).brightness ==
                                  Brightness.light
                              ? Colors.white
                              : Color(0xff222C44),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(12),
                            topLeft: Radius.circular(12),
                          )),
                      child: Row(
                        children: [
                          Text(
                            '   Detected locations',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: ThemeProvider.of(context).brightness ==
                                      Brightness.light
                                  ? head
                                  : Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 55,
                      color: ThemeProvider.of(context).brightness ==
                              Brightness.light
                          ? button_red.withOpacity(0.01)
                          : head,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 12.0),
                              child: Icon(
                                Icons.location_on_outlined,
                                color: ThemeProvider.of(context).brightness ==
                                        Brightness.light
                                    ? Color(0xff8A94A3)
                                    : Colors.white,
                                size: 20,
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Medelin street',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color:
                                        ThemeProvider.of(context).brightness ==
                                                Brightness.light
                                            ? head
                                            : Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  '77th Street. 90 W 22nd St, SD',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color:
                                        ThemeProvider.of(context).brightness ==
                                                Brightness.light
                                            ? head
                                            : Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 70,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: ThemeProvider.of(context).brightness ==
                                        Brightness.light
                                    ? Colors.red.withOpacity(0.07)
                                    : Color(0xff222C44).withOpacity(0.07),
                                spreadRadius: 12,
                                blurRadius: 12,
                                offset: Offset(0, 5))
                          ],
                          color: ThemeProvider.of(context).brightness ==
                                  Brightness.light
                              ? Colors.white
                              : Color(0xff222C44),
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(12),
                            bottomLeft: Radius.circular(12),
                          )),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 14.0, bottom: 19, left: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 2.0),
                              child: Icon(
                                Icons.location_on_outlined,
                                color: ThemeProvider.of(context).brightness ==
                                        Brightness.light
                                    ? Color(0xff8A94A3)
                                    : Colors.white,
                                size: 20,
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Medelin street',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color:
                                        ThemeProvider.of(context).brightness ==
                                                Brightness.light
                                            ? head
                                            : Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  '77th Street. 90 W 22nd St, SD',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color:
                                        ThemeProvider.of(context).brightness ==
                                                Brightness.light
                                            ? head
                                            : Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 36.0, top: 36, right: 36),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        if (custom == false) {
                          setState(() {
                            custom = true;
                          });
                        } else {
                          setState(() {
                            custom = false;
                          });
                        }
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 2.0, left: 8),
                            child: Container(
                              height: 13,
                              width: 13,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color:
                                        ThemeProvider.of(context).brightness ==
                                                Brightness.light
                                            ? Color(0xff8A94A3)
                                            : Colors.white),
                                color:
                                    custom == true ? head : Colors.transparent,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Enter custom address',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: ThemeProvider.of(context).brightness ==
                                          Brightness.light
                                      ? head
                                      : Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: ThemeProvider.of(context).brightness ==
                                        Brightness.light
                                    ? Colors.red.withOpacity(0.07)
                                    : Color(0xff222C44).withOpacity(0.07),
                                spreadRadius: 4,
                                blurRadius: 4,
                                offset: Offset(0, 5))
                          ],
                          color: ThemeProvider.of(context).brightness ==
                                  Brightness.light
                              ? Colors.white
                              : head,
                          borderRadius: BorderRadius.all(
                            Radius.circular(18),
                          ),
                          border: Border.all(color: Color(0xffDBDBDB))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: TextField(
                              focusNode: focusNode1,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'House, street, locality',
                                hintStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: ThemeProvider.of(context).brightness ==
                                          Brightness.light
                                      ? head.withOpacity(0.45)
                                      : Colors.white.withOpacity(0.45),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                ),
                                contentPadding: EdgeInsets.zero,
                              ),
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: ThemeProvider.of(context).brightness ==
                                        Brightness.light
                                    ? head
                                    : Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 13,
                    ),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: ThemeProvider.of(context).brightness ==
                                        Brightness.light
                                    ? Colors.red.withOpacity(0.07)
                                    : Color(0xff222C44).withOpacity(0.07),
                                spreadRadius: 4,
                                blurRadius: 4,
                                offset: Offset(0, 5))
                          ],
                          color: ThemeProvider.of(context).brightness ==
                                  Brightness.light
                              ? Colors.white
                              : head,
                          borderRadius: BorderRadius.all(
                            Radius.circular(18),
                          ),
                          border: Border.all(color: Color(0xffDBDBDB))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: TextField(
                              focusNode: focusNode2,
                              onTap: () {},
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Landmarks, other information',
                                hintStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: ThemeProvider.of(context).brightness ==
                                          Brightness.light
                                      ? head.withOpacity(0.45)
                                      : Colors.white.withOpacity(0.45),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                ),
                                contentPadding: EdgeInsets.zero,
                              ),
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: ThemeProvider.of(context).brightness ==
                                        Brightness.light
                                    ? head
                                    : Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 47,
                          width: 129,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: ThemeProvider.of(context)
                                                .brightness ==
                                            Brightness.light
                                        ? Colors.red.withOpacity(0.07)
                                        : Color(0xff222C44).withOpacity(0.07),
                                    spreadRadius: 4,
                                    blurRadius: 4,
                                    offset: Offset(0, 5))
                              ],
                              color: ThemeProvider.of(context).brightness ==
                                      Brightness.light
                                  ? Colors.white
                                  : head,
                              borderRadius: BorderRadius.all(
                                Radius.circular(18),
                              ),
                              border: Border.all(color: Color(0xffDBDBDB))),
                          child: DropdownButton(
                            focusNode: focusNode4,
                            onTap: () {
                              /* focusNode1.unfocus();
                              focusNode2.unfocus();
                              focusNode3.unfocus();*/

                              print('hhhhhhhhhhhhhhhhhhhh');
                            },
                            underline: Container(color: Colors.transparent),
                            icon: Icon(
                              Icons.keyboard_arrow_down_sharp,
                              color: button_red,
                            ),
                            elevation: 0,
                            autofocus: true,
                            hint: Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Text(
                                'Home/Office',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Montserrat',
                                    color:
                                        ThemeProvider.of(context).brightness ==
                                                Brightness.light
                                            ? head.withOpacity(0.45)
                                            : Colors.white.withOpacity(0.45),
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'Montserrat',
                                color: ThemeProvider.of(context).brightness ==
                                        Brightness.light
                                    ? head
                                    : Colors.white,
                                fontWeight: FontWeight.w500),
                            value: _selectedLocation,
                            onChanged: (newValue) {
                              setState(() {
                                _selectedLocation = newValue;
                              });
                            },
                            items: _locations.map((location) {
                              return DropdownMenuItem(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: new Text(location),
                                ),
                                value: location,
                              );
                            }).toList(),
                          ),
                        ),
                        SizedBox(
                          height: 13,
                        ),
                        Container(
                          height: 50,
                          width: 162,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: ThemeProvider.of(context)
                                                .brightness ==
                                            Brightness.light
                                        ? Colors.red.withOpacity(0.07)
                                        : Color(0xff222C44).withOpacity(0.07),
                                    spreadRadius: 4,
                                    blurRadius: 4,
                                    offset: Offset(0, 5))
                              ],
                              color: ThemeProvider.of(context).brightness ==
                                      Brightness.light
                                  ? Colors.white
                                  : head,
                              borderRadius: BorderRadius.all(
                                Radius.circular(18),
                              ),
                              border: Border.all(color: Color(0xffDBDBDB))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: TextField(
                                  focusNode: focusNode3,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Pincode',
                                    hintStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      color: ThemeProvider.of(context)
                                                  .brightness ==
                                              Brightness.light
                                          ? head.withOpacity(0.45)
                                          : Colors.white.withOpacity(0.45),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                    ),
                                    contentPadding: EdgeInsets.zero,
                                  ),
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color:
                                        ThemeProvider.of(context).brightness ==
                                                Brightness.light
                                            ? head
                                            : Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 28.0, right: 28, top: 50, bottom: 20),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        /*  Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) => BottomBar(),
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            var begin = Offset(1.0, 0.0);
                            var end = Offset.zero;
                            var curve = Curves.ease;

                            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                            return SlideTransition(
                              position: animation.drive(tween),
                              child: child,
                            );
                          },
                        ));*/
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => BottomBar()),
                            (Route<dynamic> route) => false);
                      },
                      child: FilledButton(
                        btnHeight: 56,
                        btnRadius: 8,
                        btnColor: button_red,
                        btnText: "Add address",
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
                              'Add address',
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
