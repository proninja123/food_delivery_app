import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../utils/app_colors.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

import '../../seller_menu_module/seller_menu_items_page.dart';

class Favourites extends StatefulWidget {
  Favourites({this.show_backbutton});

  bool show_backbutton;

  @override
  _FavouritesState createState() =>
      _FavouritesState(show_backbutton: show_backbutton);
}

class _FavouritesState extends State<Favourites> {
  _FavouritesState({this.show_backbutton});

  bool show_backbutton;
  List<restaurentlist> rList = new List<restaurentlist>();

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timestamp) {
      // do stuff after frame is build
      setState(() {
        timeDilation = 1;
      });
    });
    super.initState();
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
                            : Color(0xff131824),
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
                            'Favourites',
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
                padding: const EdgeInsets.only(top: 45.0, left: 36),
                child: Row(
                  children: [
                    Text(
                      'Restaurants',
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
              Padding(
                padding: const EdgeInsets.only(top: 36.0),
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: rList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    RestuarentPage(),
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
                          width: double.infinity,
                          child: Column(
                            children: [
                              Container(
                                child: Stack(
                                  children: [
                                    Container(
                                      height: 186,
                                      child: Column(
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(
                                                left: 20.0,
                                                right: 20,
                                                bottom: 18,
                                                top: 10),
                                            height: 150,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    '${rList[index].image}'),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 40.0),
                                                  child: Container(
                                                    height: 32,
                                                    width: 80,
                                                    decoration: BoxDecoration(
                                                      color: Color(0xffed1d1d),
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topRight: Radius
                                                                  .circular(8),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          8)),
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.07),
                                                            spreadRadius: 16,
                                                            blurRadius: 20,
                                                            offset:
                                                                Offset(0, 7))
                                                      ],
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        '30% Off',
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontFamily:
                                                                'Montserrat',
                                                            letterSpacing: 1.15,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 30.0),
                                                  child: Container(
                                                    height: 43,
                                                    width: 19,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              bottomLeft: Radius
                                                                  .circular(12),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          12)),
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  bottom: 8.0),
                                                          child:
                                                              SvgPicture.asset(
                                                            'images/svg/Stroke 1-4 1 .svg',
                                                            height: 13,
                                                            color: Colors.red,
                                                            fit: BoxFit.cover,
                                                            matchTextDirection:
                                                                false,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                        bottom: 1,
                                        left: 0,
                                        right: 0,
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(3),
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.black
                                                            .withOpacity(0.07),
                                                        spreadRadius: 16,
                                                        blurRadius: 20,
                                                        offset: Offset(0, 7))
                                                  ],
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      height: 45,
                                                      width: 45,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: Colors.white,
                                                      ),
                                                      child: Image.asset(
                                                          'images/Background (3).png'),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                height: 29,
                                                width: 105,
                                                decoration: BoxDecoration(
                                                  color: Color(0xffed1d1d),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(23)),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: button_red
                                                            .withOpacity(0.1),
                                                        spreadRadius: 5,
                                                        blurRadius: 5,
                                                        offset: Offset(0, 5))
                                                  ],
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    '30-50 mins',
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontFamily:
                                                            'Montserrat',
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 12.0, left: 18, right: 18),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 4.0),
                                          child: Text(
                                            '${rList[index].name}',
                                            style: TextStyle(
                                                fontSize: 19,
                                                fontFamily: 'Montserrat',
                                                color: ThemeProvider.of(context)
                                                            .brightness ==
                                                        Brightness.light
                                                    ? head
                                                    : Colors.white,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 4.0),
                                          child: Text(
                                            '\$1.99 Delivery',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontFamily: 'Montserrat',
                                                color: ThemeProvider.of(context)
                                                            .brightness ==
                                                        Brightness.light
                                                    ? head
                                                    : Colors.white,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 14.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 4.0),
                                            child: Row(
                                              children: [
                                                SvgPicture.asset(
                                                  'images/svg/star_20210401_174429079.svg',
                                                  height: 16,
                                                  fit: BoxFit.cover,
                                                  matchTextDirection: false,
                                                ),
                                                SizedBox(
                                                  width: 8,
                                                ),
                                                Text(
                                                  '4.9',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontFamily: 'Montserrat',
                                                      color: ThemeProvider.of(
                                                                      context)
                                                                  .brightness ==
                                                              Brightness.light
                                                          ? head
                                                          : Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                SizedBox(
                                                  width: 18,
                                                ),
                                                Text(
                                                  'Closes in 20 minutes',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontFamily: 'Montserrat',
                                                      color: ThemeProvider.of(
                                                                      context)
                                                                  .brightness ==
                                                              Brightness.light
                                                          ? Color(0xffed1d1d)
                                                          : Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 4.0),
                                            child: Text(
                                              'Modelin(10 Mi)',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontFamily: 'Montserrat',
                                                  color:
                                                      ThemeProvider.of(context)
                                                                  .brightness ==
                                                              Brightness.light
                                                          ? head
                                                              .withOpacity(0.4)
                                                          : Colors.white
                                                              .withOpacity(0.4),
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 20),
                                        child: Divider(
                                          thickness: 1,
                                          color: ThemeProvider.of(context)
                                                      .brightness ==
                                                  Brightness.light
                                              ? head.withOpacity(0.15)
                                              : Colors.white,
                                        ))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 18.0, left: 36),
                child: Row(
                  children: [
                    Text(
                      'Favourite Cuisines',
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
                        height: 98,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 13.0, bottom: 13, left: 16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            height: 14,
                                            width: 14,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: button_green),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  height: 6,
                                                  width: 6,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: button_green),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            'Best Seller',
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontFamily: 'Montserrat',
                                              color: button_red,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 3.0, bottom: 3),
                                        child: Text(
                                          'Mexican Green Wave',
                                          style: TextStyle(
                                            fontSize: 12,
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
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 2.0),
                                        child: Text(
                                          '\$7.00',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: 'Montserrat',
                                            color: button_green,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'Pizza Hut (Outlet)',
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontFamily: 'Montserrat',
                                          color: ThemeProvider.of(context)
                                                      .brightness ==
                                                  Brightness.light
                                              ? Color(0xff8F8F8F)
                                              : Colors.white.withOpacity(0.7),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 13.0, right: 12),
                                  child: Container(
                                    height: 68,
                                    width: 92,
                                    child: Stack(
                                      children: [
                                        Column(
                                          children: [
                                            Container(
                                              height: 56,
                                              width: 92,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(8)),
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                        'images/vitalii-chernopyskyi-Oxb84ENcFfU-unsplash-2 2 .png',
                                                      ),
                                                      fit: BoxFit.cover)),
                                            ),
                                          ],
                                        ),
                                        Positioned(
                                            left: 0,
                                            right: 0,
                                            bottom: 2,
                                            child: Column(
                                              children: [
                                                Container(
                                                  height: 27,
                                                  width: 77,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  8)),
                                                      color: ThemeProvider.of(
                                                                      context)
                                                                  .brightness ==
                                                              Brightness.light
                                                          ? Colors.white
                                                          : head,
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.07),
                                                            spreadRadius: 0.25,
                                                            blurRadius: 0.25,
                                                            offset:
                                                                Offset(0, 3))
                                                      ]),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 7.0,
                                                            right: 7),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          '-',
                                                          style: TextStyle(
                                                            fontSize: 13,
                                                            fontFamily:
                                                                'Montserrat',
                                                            color: ThemeProvider.of(
                                                                            context)
                                                                        .brightness ==
                                                                    Brightness
                                                                        .light
                                                                ? head
                                                                : Colors.white,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                          ),
                                                        ),
                                                        Text(
                                                          '1',
                                                          style: TextStyle(
                                                            fontSize: 13,
                                                            fontFamily:
                                                                'Montserrat',
                                                            color: ThemeProvider.of(
                                                                            context)
                                                                        .brightness ==
                                                                    Brightness
                                                                        .light
                                                                ? head
                                                                : Colors.white,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                          ),
                                                        ),
                                                        Text(
                                                          '+',
                                                          style: TextStyle(
                                                            fontSize: 13,
                                                            fontFamily:
                                                                'Montserrat',
                                                            color: ThemeProvider.of(
                                                                            context)
                                                                        .brightness ==
                                                                    Brightness
                                                                        .light
                                                                ? head
                                                                : Colors.white,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
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
