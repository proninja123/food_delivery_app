import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:food_delivery/views/home_ui/seller_menu_information_module/seller_menu_gallery.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';

class InformationPage extends StatefulWidget {
  @override
  _InformationPageState createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: ThemeProvider.of(context).brightness == Brightness.light
                  ? Colors.white
                  : Color(0xff131824),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24)),
              boxShadow: [
                BoxShadow(
                    color:
                        ThemeProvider.of(context).brightness == Brightness.light
                            ? Colors.black.withOpacity(0.1)
                            : Color(0xff222C44).withOpacity(0.07),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(0, 0))
              ],
            ),
            child: Column(
              children: [
                SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.only(left: 22, right: 22, top: 16),
                    child: Container(
                      child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 6,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: EdgeInsets.all(5),
                            child: InkWell(
                              onTap: () {
                                if (index == 5) {
                                  Navigator.of(context).push(PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        Gallery(),
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
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
                                }
                              },
                              child: Container(
                                width: 82,
                                height: 72,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'images/Rectangle 28.png'),
                                        fit: BoxFit.cover)),
                                child: index == 5
                                    ? Container(
                                        width: 82,
                                        height: 72,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12)),
                                            color:
                                                Colors.black.withOpacity(0.72)),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'View all\n   (22+)',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: 'Montserrat',
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Container(),
                              ),
                            ),
                          );
                        },
                        gridDelegate:
                            new SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 22.0, right: 22, top: 50),
                  child: Container(
                    decoration: BoxDecoration(
                        color: ThemeProvider.of(context).brightness ==
                                Brightness.light
                            ? Colors.white
                            : Color(0xff222C44),
                        boxShadow: [
                          BoxShadow(
                              color: ThemeProvider.of(context).brightness ==
                                      Brightness.light
                                  ? Colors.black.withOpacity(0.07)
                                  : Color(0xff222C44).withOpacity(0.07),
                              spreadRadius: 10,
                              blurRadius: 10,
                              offset: Offset(3, 3))
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(14))),
                    child: Column(
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.only(left: 22, right: 20, top: 17),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(top: 3),
                                  child: Icon(
                                    Icons.location_on_outlined,
                                    color: Color(0xff8A94A3),
                                    size: 22,
                                  )),
                              SizedBox(
                                width: 18,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '404 Pizza Restaurant\nCalle 9 #39-13, Medellín, Antioquia\nParque Lleras - Poblado',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Montserrat',
                                        color: ThemeProvider.of(context)
                                                    .brightness ==
                                                Brightness.light
                                            ? head
                                            : Colors.white,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 12, left: 16, right: 20, bottom: 25),
                          child: Container(
                            height: 151,
                            decoration: BoxDecoration(
                                border: Border.all(width: 1.5, color: head),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4))),
                            child: Center(
                                child: Text(
                              'LOCATION MAP',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Montserrat',
                                  color: ThemeProvider.of(context).brightness ==
                                          Brightness.light
                                      ? head
                                      : Colors.white,
                                  fontWeight: FontWeight.w700),
                            )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 20, top: 23),
                  child: Container(
                    decoration: BoxDecoration(
                        color: ThemeProvider.of(context).brightness ==
                                Brightness.light
                            ? Colors.white
                            : Color(0xff222C44),
                        boxShadow: [
                          BoxShadow(
                              color: ThemeProvider.of(context).brightness ==
                                      Brightness.light
                                  ? Colors.black.withOpacity(0.07)
                                  : Color(0xff222C44).withOpacity(0.07),
                              spreadRadius: 10,
                              blurRadius: 10,
                              offset: Offset(3, 3))
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(14))),
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 24, right: 24, top: 35, bottom: 18),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.access_time_rounded,
                            color: Color(0xff8A94A3),
                            size: 22,
                          ),
                          SizedBox(
                            width: 18,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Open Hours',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Montserrat',
                                    color:
                                        ThemeProvider.of(context).brightness ==
                                                Brightness.light
                                            ? head
                                            : Colors.white,
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                height: 14,
                              ),
                              Text(
                                'Monday - 10am to 5pm',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Montserrat',
                                    color:
                                        ThemeProvider.of(context).brightness ==
                                                Brightness.light
                                            ? head
                                            : Colors.white),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Text('Tuesday - 10am to 5pm',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Montserrat',
                                    color:
                                        ThemeProvider.of(context).brightness ==
                                                Brightness.light
                                            ? head
                                            : Colors.white,
                                  )),
                              SizedBox(
                                height: 7,
                              ),
                              Text(
                                'Wednesday - 10am to 5pm',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Montserrat',
                                    color:
                                        ThemeProvider.of(context).brightness ==
                                                Brightness.light
                                            ? head
                                            : Colors.white),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Text(
                                'Thirsday - 10am to 5pm',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Montserrat',
                                  color: ThemeProvider.of(context).brightness ==
                                          Brightness.light
                                      ? head
                                      : Colors.white,
                                ),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Text(
                                'Friday - 10am to 5pm',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Montserrat',
                                    color:
                                        ThemeProvider.of(context).brightness ==
                                                Brightness.light
                                            ? head
                                            : Colors.white),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(left: 65, right: 30, top: 30),
                    child: Container(
                      height: 0.1,
                      color: head,
                    )),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 28, top: 13),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 14),
                        child: Icon(
                          Icons.lunch_dining,
                          color: ThemeProvider.of(context).brightness ==
                                  Brightness.light
                              ? Color(0xff293340)
                              : Colors.white,
                          size: 22,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        //width: ScreenUtil().setWidth(250),
                        child: Wrap(
                          children: List.generate(
                            7,
                            (index) {
                              return Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: FilterChip(
                                  backgroundColor:
                                      ThemeProvider.of(context).brightness ==
                                              Brightness.light
                                          ? Colors.white
                                          : Color(0xff131824),
                                  selectedColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(color: head),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4))),
                                  label: Text(
                                    'PIZZA',
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontFamily: 'Montserrat',
                                        color: ThemeProvider.of(context)
                                                    .brightness ==
                                                Brightness.light
                                            ? head
                                            : head,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  onSelected: (val) {
                                    setState(() {});
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(left: 65, right: 30, top: 15),
                    child: Container(
                      height: 0.1,
                      color: head,
                    )),
                Padding(
                  padding:
                      EdgeInsets.only(left: 28, right: 28, top: 12, bottom: 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.people_alt_outlined,
                        color: ThemeProvider.of(context).brightness ==
                                Brightness.light
                            ? Color(0xff8A94A3)
                            : Colors.white,
                        size: 22,
                      ),
                      SizedBox(
                        width: 18,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '\$20 for two people approx.',
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Montserrat',
                                color: ThemeProvider.of(context).brightness ==
                                        Brightness.light
                                    ? head
                                    : Colors.white,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 25, right: 25, top: 29, bottom: 0),
            child: Container(
              height: 50,
              decoration: new BoxDecoration(
                color: button_red,
                boxShadow: [
                  BoxShadow(
                      color: ThemeProvider.of(context).brightness ==
                              Brightness.light
                          ? Colors.red.withOpacity(0.3)
                          : Color(0xff222C44).withOpacity(0.07),
                      spreadRadius: 8,
                      blurRadius: 8,
                      offset: Offset(3, 3))
                ],
                borderRadius: new BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
              child: FlatButton(
                  onPressed: () async {},
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.phone,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'CALL 987-897-7771',
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Montserrat',
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
