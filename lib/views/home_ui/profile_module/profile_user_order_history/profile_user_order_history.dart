import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import '../../../../utils/app_colors.dart';

class OrderHistory extends StatefulWidget {
  OrderHistory({this.show_backbutton});

  bool show_backbutton;

  @override
  _OrderHistoryState createState() =>
      _OrderHistoryState(show_backbutton: show_backbutton);
}

class _OrderHistoryState extends State<OrderHistory> {
  _OrderHistoryState({this.show_backbutton});

  bool show_backbutton;
  List<restaurentlist> rList = new List<restaurentlist>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timestamp) {
      // do stuff after frame is build
      setState(() {
        timeDilation = 1;
      });
    });
    rList.add(restaurentlist(
        image: 'images/vitalii-chernopyskyi-Oxb84ENcFfU-unsplash-2 2 .png',
        name: "Pizza Hut (Outlet)"));
    rList.add(restaurentlist(
        image: 'images/Background (2).png', name: " Burger King"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 30.0),
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
                          show_backbutton == true
                              ? InkWell(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                    width: 50,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        // Image.asset('images/location-map.png',fit: BoxFit.contain,height: 20,),
                                        Icon(
                                          Icons.arrow_back,
                                          size: 24,
                                          color: ThemeProvider.of(context)
                                                      .brightness ==
                                                  Brightness.light
                                              ? head
                                              : Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : Container(
                                  width: 50,
                                ),
                          Text(
                            'Order History',
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
              Container(
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.all(0),
                  shrinkWrap: true,
                  itemCount: 3,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding:
                          const EdgeInsets.only(top: 22.0, left: 24, right: 24),
                      child: Container(
                        height: 248,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(24)),
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
                                  spreadRadius: 8,
                                  blurRadius: 8,
                                  offset: Offset(1, 2))
                            ]),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 14.0, left: 25),
                                      child: Container(
                                        height: 64,
                                        width: 64,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8)),
                                            image: DecorationImage(
                                                image: AssetImage(
                                                  'images/vitalii-chernopyskyi-Oxb84ENcFfU-unsplash-2 2 .png',
                                                ),
                                                fit: BoxFit.cover)),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15.0, bottom: 0, left: 16),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 3.0, bottom: 0),
                                            child: Text(
                                              'Pizza House',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: 'Montserrat',
                                                color: ThemeProvider.of(context)
                                                            .brightness ==
                                                        Brightness.light
                                                    ? head
                                                    : Colors.white,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            '3 Dishes',
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontFamily: 'Montserrat',
                                              color: ThemeProvider.of(context)
                                                          .brightness ==
                                                      Brightness.light
                                                  ? Color(0xff8F8F8F)
                                                  : Colors.white
                                                      .withOpacity(0.7),
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 13,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '\$7.00',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontFamily: 'Montserrat',
                                                  color:
                                                      ThemeProvider.of(context)
                                                                  .brightness ==
                                                              Brightness.light
                                                          ? head
                                                          : Colors.white,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 59.0, right: 18),
                                  child: Row(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'Delivered',
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontFamily: 'Montserrat',
                                              color: button_green,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 11,
                                          ),
                                          Container(
                                            height: 21,
                                            width: 21,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(4),
                                                ),
                                                color: button_green),
                                            child: Icon(
                                              Icons.check,
                                              color: Colors.white,
                                              size: 18,
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 4.0, left: 25, right: 16),
                              child: Divider(
                                thickness: 1,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 4.0, left: 20),
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Mexican Green Wave, Peppy\nPaneer & Farmhouse',
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          color: ThemeProvider.of(context)
                                                      .brightness ==
                                                  Brightness.light
                                              ? head
                                              : Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 10,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 12.0, bottom: 15),
                                        child: Row(
                                          children: [
                                            Text(
                                              '17 Jan 2021, 8:50 PM',
                                              style: TextStyle(
                                                fontFamily: 'Montserrat',
                                                color: ThemeProvider.of(context)
                                                            .brightness ==
                                                        Brightness.light
                                                    ? head.withOpacity(0.39)
                                                    : Colors.white
                                                        .withOpacity(0.39),
                                                fontWeight: FontWeight.w400,
                                                fontSize: 10,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            height: 42,
                                            width: (MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    99) /
                                                2,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8)),
                                                border: Border.all(
                                                    color: ThemeProvider.of(
                                                                    context)
                                                                .brightness ==
                                                            Brightness.light
                                                        ? head
                                                        : Colors.white),
                                                color: ThemeProvider.of(context)
                                                            .brightness ==
                                                        Brightness.light
                                                    ? Colors.white
                                                    : head),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Rate order',
                                                  style: TextStyle(
                                                    fontFamily: 'Montserrat',
                                                    color: ThemeProvider.of(
                                                                    context)
                                                                .brightness ==
                                                            Brightness.light
                                                        ? head
                                                        : Colors.white,
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 12,
                                          ),
                                          Container(
                                            height: 42,
                                            width: (MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    99) /
                                                2,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8)),
                                                color: button_green),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Order again',
                                                  style: TextStyle(
                                                    fontFamily: 'Montserrat',
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 11,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'You rated 4 ',
                                            style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              color: ThemeProvider.of(context)
                                                          .brightness ==
                                                      Brightness.light
                                                  ? head
                                                  : Colors.white,
                                              fontSize: 10,
                                            ),
                                          ),
                                          SvgPicture.asset(
                                            'images/svg/star_20210401_174429079.svg',
                                            height: 8,
                                            width: 8,
                                            fit: BoxFit.cover,
                                            matchTextDirection: false,
                                          ),
                                          Text(
                                            ' for Food.',
                                            style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              color: ThemeProvider.of(context)
                                                          .brightness ==
                                                      Brightness.light
                                                  ? head
                                                  : Colors.white,
                                              fontSize: 10,
                                            ),
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
                    );
                  },
                ),
              ),
              SizedBox(
                height: 159,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MySeparator extends StatelessWidget {
  final double height;
  final Color color;

  const MySeparator({this.height = 1, this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        final dashWidth = 5.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
        );
      },
    );
  }
}

class restaurentlist {
  final String image;
  final String name;

  restaurentlist({
    this.image,
    this.name,
  });

  restaurentlist.fromMap(Map map)
      : this(
          image: map['userName'],
          name: map['email'],
        );
}
