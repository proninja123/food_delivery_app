import 'dart:async';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:food_delivery/views/home_ui/about_order_filter_module/OrderSummery.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:expandable/expandable.dart';
import '../../../utils/app_colors.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TrackOrder extends StatefulWidget {
  @override
  _TrackOrderState createState() => _TrackOrderState();
}

class _TrackOrderState extends State<TrackOrder> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height - 30,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image:
                        ThemeProvider.of(context).brightness == Brightness.light
                            ? AssetImage('images/gl.png')
                            : AssetImage('images/gd.png'),
                    fit: BoxFit.cover),
              ),
              child: GoogleMap(
                mapType: MapType.hybrid,
                initialCameraPosition: _kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 121,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: ThemeProvider.of(context).brightness ==
                              Brightness.light
                          ? Colors.white
                          : Color(0xff222C44),
                      boxShadow: [
                        BoxShadow(
                            color: ThemeProvider.of(context).brightness ==
                                    Brightness.light
                                ? Colors.red.withOpacity(0.07)
                                : Color(0xff222C44).withOpacity(0.07),
                            blurRadius: 6,
                            offset: Offset(0, 3))
                      ],
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 24, right: 24, top: 23),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Icon(
                                    Icons.arrow_back,
                                    size: 24,
                                    color:
                                        ThemeProvider.of(context).brightness ==
                                                Brightness.light
                                            ? head
                                            : Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Pizza Hut',
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            color: ThemeProvider.of(context)
                                                        .brightness ==
                                                    Brightness.light
                                                ? head
                                                : Colors.white,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 20,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 7,
                                        ),
                                        Text(
                                          'Delivering to',
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            color: ThemeProvider.of(context)
                                                        .brightness ==
                                                    Brightness.light
                                                ? head.withOpacity(0.3)
                                                : Colors.white.withOpacity(0.3),
                                            fontWeight: FontWeight.w700,
                                            fontSize: 12,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 2.5,
                                        ),
                                        Text(
                                          '3456, Civil Street, Fuente Del',
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            color: ThemeProvider.of(context)
                                                        .brightness ==
                                                    Brightness.light
                                                ? head
                                                : Colors.white,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          'Fresno. 123456',
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            color: ThemeProvider.of(context)
                                                        .brightness ==
                                                    Brightness.light
                                                ? head
                                                : Colors.white,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 9,
                                          height: 9,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: button_green),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          'Live Tracking',
                                          style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              color: button_green,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                              wordSpacing: 0.15),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 20, bottom: 45),
                  child: Container(
                    height: 301,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(22)),
                      color: ThemeProvider.of(context).brightness ==
                              Brightness.light
                          ? Colors.white
                          : Color(0xff131824),
                      boxShadow: [
                        BoxShadow(
                            color: ThemeProvider.of(context).brightness ==
                                    Brightness.light
                                ? button_red.withOpacity(0.15)
                                : button_red.withOpacity(0.15),
                            blurRadius: 41,
                            offset: Offset(0, 12))
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: 39,
                            ),
                            Text(
                              'Track Invoice',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: ThemeProvider.of(context).brightness ==
                                        Brightness.light
                                    ? head
                                    : Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              'ID: 242345',
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
                            SizedBox(
                              height: 13,
                            ),
                            Container(
                              height: 24,
                              width: 183,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30),
                                  ),
                                  border: Border.all(color: button_red)),
                              child: Row(
                                children: [
                                  Container(
                                    height: 24,
                                    width: 60,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(30),
                                        ),
                                        color: button_red),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 13,
                            ),
                            Text(
                              'Arriving in 45 minutes',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: button_red,
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(
                              height: 13,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: AssetImage(
                                          'images/person.png',
                                        ),
                                        fit: BoxFit.cover,
                                      )),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Johnson Smith',
                                      style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        color: ThemeProvider.of(context)
                                                    .brightness ==
                                                Brightness.light
                                            ? head
                                            : Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          'images/svg/star_20210401_174429079.svg',
                                          height: 8.6,
                                          width: 10,
                                          fit: BoxFit.cover,
                                          matchTextDirection: false,
                                        ),
                                        SizedBox(
                                          width: 5.5,
                                        ),
                                        Text(
                                          '4.9 (245)',
                                          style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              color: ThemeProvider.of(context)
                                                          .brightness ==
                                                      Brightness.light
                                                  ? head
                                                  : Colors.white,
                                              fontSize: 9,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 40,
                                ),
                                Container(
                                  height: 21.2,
                                  width: 21.2,
                                  child: SvgPicture.asset(
                                    'images/svg/noun_call_3836231.svg',
                                    height: 21.2,
                                    width: 21.2,
                                    color: button_green,
                                    fit: BoxFit.cover,
                                    matchTextDirection: false,
                                  ),
                                ),
                                SizedBox(
                                  width: 24.5,
                                ),
                                Container(
                                  height: 23.42,
                                  width: 21.7,
                                  child: SvgPicture.asset(
                                    'images/svg/noun_chat_945168.svg',
                                    height: 23.42,
                                    width: 21.7,
                                    color:
                                        ThemeProvider.of(context).brightness ==
                                                Brightness.light
                                            ? head
                                            : Colors.white,
                                    fit: BoxFit.contain,
                                    matchTextDirection: false,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      OrderSummery(),
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
                          },
                          child: Container(
                            height: 65,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(22),
                                  bottomRight: Radius.circular(22)),
                              color: button_red,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'View order details',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
/*
*/
