import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:food_delivery/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:expandable/expandable.dart';

class OrderSummery extends StatefulWidget {
  @override
  _OrderSummeryState createState() => _OrderSummeryState();
}

class _OrderSummeryState extends State<OrderSummery> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 85,
                width: double.infinity,
                decoration: BoxDecoration(
                    color:
                        ThemeProvider.of(context).brightness == Brightness.light
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
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 24, right: 24, top: 28),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              width: 50,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  // Image.asset('images/location-map.png',fit: BoxFit.contain,height: 20,),
                                  Icon(
                                    Icons.arrow_back,
                                    size: 24,
                                    color:
                                        ThemeProvider.of(context).brightness ==
                                                Brightness.light
                                            ? head
                                            : Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Text(
                            'Order summary',
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
                          Container(
                            width: 50,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 25.0, right: 24, top: 32.6),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      color: ThemeProvider.of(context).brightness ==
                              Brightness.light
                          ? Colors.white
                          : Color(0xff222C44),
                      boxShadow: [
                        BoxShadow(
                            color: ThemeProvider.of(context).brightness ==
                                    Brightness.light
                                ? Colors.red.withOpacity(0.05)
                                : Color(0xff131824).withOpacity(0.07),
                            spreadRadius: 16,
                            blurRadius: 16,
                            offset: Offset(1, 2))
                      ]),
                  height: 84,
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 21,
                      right: 0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Delivery address',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Montserrat',
                            color: ThemeProvider.of(context).brightness ==
                                    Brightness.light
                                ? head
                                : Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(
                              'images/svg/position-pin.svg',
                              matchTextDirection: true,
                              color: Color(0xff8A94A3),
                              height: 12,
                              width: 12,
                              fit: BoxFit.contain, //Color(0xff515970),
                            ),
                            //Icon(Icons.location_on_outlined,size: 16,color: Color(0xff8A94A3),),
                            SizedBox(
                              width: 12,
                            ),
                            Text(
                              '77th Street. 90 W 22nd St, SD',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: ThemeProvider.of(context).brightness ==
                                        Brightness.light
                                    ? head
                                    : Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25.0, right: 24, top: 13),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      color: ThemeProvider.of(context).brightness ==
                              Brightness.light
                          ? Colors.white
                          : Color(0xff222C44),
                      boxShadow: [
                        BoxShadow(
                            color: ThemeProvider.of(context).brightness ==
                                    Brightness.light
                                ? Colors.red.withOpacity(0.05)
                                : Color(0xff131824).withOpacity(0.07),
                            spreadRadius: 16,
                            blurRadius: 16,
                            offset: Offset(1, 2))
                      ]),
                  height: 84,
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 21,
                      right: 41,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Contact details',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Montserrat',
                                color: ThemeProvider.of(context).brightness ==
                                        Brightness.light
                                    ? head
                                    : Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              '+1 24521 12345',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: ThemeProvider.of(context).brightness ==
                                        Brightness.light
                                    ? head
                                    : Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'Change',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Montserrat',
                            color: button_red,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25.0, right: 24, top: 13),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      color: ThemeProvider.of(context).brightness ==
                              Brightness.light
                          ? Colors.white
                          : Color(0xff222C44),
                      boxShadow: [
                        BoxShadow(
                            color: ThemeProvider.of(context).brightness ==
                                    Brightness.light
                                ? Colors.red.withOpacity(0.05)
                                : Color(0xff131824).withOpacity(0.07),
                            spreadRadius: 16,
                            blurRadius: 16,
                            offset: Offset(1, 2))
                      ]),
                  height: 180,
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 21,
                      right: 21,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Order',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Montserrat',
                            color: ThemeProvider.of(context).brightness ==
                                    Brightness.light
                                ? head
                                : Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 13,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //Icon(Icons.location_on_outlined,size: 16,color: Color(0xff8A94A3),),

                            Text(
                              'Mexican green Wave, Extra\ncheese,Soft crust, XL',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: ThemeProvider.of(context).brightness ==
                                        Brightness.light
                                    ? head
                                    : Colors.white,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "\$7.00",
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: button_green,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 13,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //Icon(Icons.location_on_outlined,size: 16,color: Color(0xff8A94A3),),

                            Text(
                              'Pizza from Mexico, Cheese\nburst, Pan base, Small',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: ThemeProvider.of(context).brightness ==
                                        Brightness.light
                                    ? head
                                    : Colors.white,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "\$7.00",
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: button_green,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 13,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //Icon(Icons.location_on_outlined,size: 16,color: Color(0xff8A94A3),),

                            Text(
                              'Italian Pasta',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: ThemeProvider.of(context).brightness ==
                                        Brightness.light
                                    ? head
                                    : Colors.white,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "\$8.00",
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: button_green,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25.0, right: 24, top: 13),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      color: ThemeProvider.of(context).brightness ==
                              Brightness.light
                          ? Colors.white
                          : Color(0xff222C44),
                      boxShadow: [
                        BoxShadow(
                            color: ThemeProvider.of(context).brightness ==
                                    Brightness.light
                                ? Colors.red.withOpacity(0.05)
                                : Color(0xff131824).withOpacity(0.07),
                            spreadRadius: 16,
                            blurRadius: 16,
                            offset: Offset(1, 2))
                      ]),
                  height: 180,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 21,
                      right: 21,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //Icon(Icons.location_on_outlined,size: 16,color: Color(0xff8A94A3),),

                            Text(
                              'Total cost of items',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: ThemeProvider.of(context).brightness ==
                                        Brightness.light
                                    ? head
                                    : Colors.white,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "\$22.00",
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: button_green,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 13,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //Icon(Icons.location_on_outlined,size: 16,color: Color(0xff8A94A3),),

                            Text(
                              'Delivery cost',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: ThemeProvider.of(context).brightness ==
                                        Brightness.light
                                    ? head
                                    : Colors.white,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "\$1.00",
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: button_green,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 13,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //Icon(Icons.location_on_outlined,size: 16,color: Color(0xff8A94A3),),

                            Text(
                              'Offer Discount',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: ThemeProvider.of(context).brightness ==
                                        Brightness.light
                                    ? head
                                    : Colors.white,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "\$1.00",
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: button_green,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "Coupon: FREEDELIVERY21",
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: ThemeProvider.of(context).brightness ==
                                      Brightness.light
                                  ? button_red
                                  : Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //Icon(Icons.location_on_outlined,size: 16,color: Color(0xff8A94A3),),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Total',
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      color: ThemeProvider.of(context)
                                                  .brightness ==
                                              Brightness.light
                                          ? head
                                          : Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  'You saved \$1 With this order',
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      color: ThemeProvider.of(context)
                                                  .brightness ==
                                              Brightness.light
                                          ? button_green
                                          : Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            Text(
                              "\$22.00",
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: button_green,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
