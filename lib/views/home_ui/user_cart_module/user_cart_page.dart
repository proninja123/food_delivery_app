import 'dart:convert';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:food_delivery/utils/baseClass.dart';
import 'package:food_delivery/view_models/shared_pref_view_model.dart';
import 'package:food_delivery/views/authentification/onboarding_page.dart';
import 'package:food_delivery/views/home_ui/payment_methods_module/add_card.dart';
import 'package:food_delivery/views/home_ui/payment_methods_module/add_paypal.dart';
import 'package:food_delivery/views/home_ui/order_tracking_module/choose_location.dart';
import 'package:food_delivery/views/home_ui/seller_menu_module/seller_menu_items_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../bottom_bar_ui/bottom_bar.dart';
import '../../../utils/app_colors.dart';
import '../about_order_filter_module/order_placed.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> with BaseClass {
  String clist;
  int cartlength = 0;
  bool loaded = false;
  List<CartList> cartData = new List();
  List<double> item_price_list = new List();
  List<int> item_quantity_list = new List();
  List<double> total_list = new List();

  getDatas() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      clist = prefs.getString('clist');
      print(clist);

      if (clist != null) {
        setState(() {
          cartData = CartList.decode(clist);
          cartlength = cartData.length;
          for (var i = 0; i < cartData.length; i++) {
            item_price_list.add(double.parse(cartData[i].price));
            item_quantity_list.add(cartData[i].quantity);
          }
          print(item_quantity_list);
          print(item_price_list);
          for (var i = 0; i < item_price_list.length; i++) {
            total_list.add(item_price_list[i] * item_quantity_list[i]);
          }
          item_total = total_list.reduce((a, b) => a + b);
          print(item_total);
          Total = delivery_fee + item_total;
          prefs.setDouble('item_total', Total);
          prefs.setInt('item_count', cartlength);
        });
      }
    });
    setState(() {
      loaded = true;
    });
  }

  double item_total;
  double Total;
  double delivery_fee = 5.0;

  @override
  void initState() {
    // TODO: implement initState
    getDatas();
    //Calculations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: loaded == false
          ? Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Center(child: CircularProgressIndicator()))
          : SafeArea(
              child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 108.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 16.0, left: 24, right: 23),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          //Navigator.of(context).pop();

                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          RestuarentPage()));
                                        },
                                        child: Icon(
                                          Icons.arrow_back,
                                          color: ThemeProvider.of(context)
                                                      .brightness ==
                                                  Brightness.light
                                              ? head
                                              : Colors.white,
                                          size: 28,
                                        )),
                                    SizedBox(
                                      width: 17,
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          'Cart',
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
                                        Text(
                                          '$cartlength Items',
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
                                InkWell(
                                  onTap: () async {
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    prefs.remove('clist');
                                    await prefs.setBool('show_cart', false);
                                    setState(() {
                                      BottomBar.show_track = false;
                                    });
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                super.widget));
                                  },
                                  child: Text(
                                    'Clear',
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        color: Color(0xffCCCCCC),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          cartlength == 0
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      left: 28.0, top: 18),
                                  child: Row(
                                    children: [
                                      Text(
                                        'No Items Added',
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
                                    ],
                                  ),
                                )
                              : Column(
                                  children: [
                                    /* Padding(
                              padding: const EdgeInsets.only(left:28.0,top: 18),
                              child: Row(
                                children: [
                                  Text('Pizza Hut',style:
                                  TextStyle(
                                      fontFamily: 'Montserrat',color: ThemeProvider.of(context).brightness ==
                                      Brightness.light
                                      ?head: Colors.white, fontSize: 16,fontWeight: FontWeight.w700

                                  ),),
                                ],
                              ),
                            ),
*/
                                    Container(
                                      child: ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        scrollDirection: Axis.vertical,
                                        padding: EdgeInsets.all(0),
                                        shrinkWrap: true,
                                        itemCount: cartlength,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                top: 22.0, left: 24, right: 24),
                                            child: Container(
                                              height: 98,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(24)),
                                                  color:
                                                      ThemeProvider.of(context)
                                                                  .brightness ==
                                                              Brightness.light
                                                          ? Colors.white
                                                          : Color(0xff222C44),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: ThemeProvider.of(
                                                                        context)
                                                                    .brightness ==
                                                                Brightness.light
                                                            ? Colors.red
                                                                .withOpacity(
                                                                    0.07)
                                                            : Color(0xff131824)
                                                                .withOpacity(
                                                                    0.07),
                                                        spreadRadius: 8,
                                                        blurRadius: 8,
                                                        offset: Offset(1, 2))
                                                  ]),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 13.0,
                                                                bottom: 13,
                                                                left: 16),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Container(
                                                                  height: 14,
                                                                  width: 14,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    border: Border.all(
                                                                        color:
                                                                            button_green),
                                                                  ),
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Container(
                                                                        height:
                                                                            6,
                                                                        width:
                                                                            6,
                                                                        decoration: BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
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
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        10,
                                                                    fontFamily:
                                                                        'Montserrat',
                                                                    color:
                                                                        button_red,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 3.0,
                                                                      bottom:
                                                                          3),
                                                              child: Text(
                                                                '${cartData[index].name}',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 12,
                                                                  fontFamily:
                                                                      'Montserrat',
                                                                  color: ThemeProvider.of(context)
                                                                              .brightness ==
                                                                          Brightness
                                                                              .light
                                                                      ? head
                                                                      : Colors
                                                                          .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      bottom:
                                                                          2.0),
                                                              child: Text(
                                                                '\$${cartData[index].price}',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 12,
                                                                  fontFamily:
                                                                      'Montserrat',
                                                                  color:
                                                                      button_green,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ),
                                                              ),
                                                            ),
                                                            Text(
                                                              '+1.00 Customization',
                                                              style: TextStyle(
                                                                fontSize: 11,
                                                                fontFamily:
                                                                    'Montserrat',
                                                                color: ThemeProvider.of(context)
                                                                            .brightness ==
                                                                        Brightness
                                                                            .light
                                                                    ? Color(
                                                                        0xff8F8F8F)
                                                                    : Colors
                                                                        .white
                                                                        .withOpacity(
                                                                            0.7),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 13.0,
                                                                right: 12),
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
                                                                        borderRadius: BorderRadius.all(Radius.circular(8)),
                                                                        image: DecorationImage(
                                                                            image: NetworkImage(
                                                                              '${cartData[index].img}',
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
                                                                      InkWell(
                                                                        onTap:
                                                                            () {
                                                                          /* Navigator.of(context).push(PageRouteBuilder(
                                                                  pageBuilder: (context, animation, secondaryAnimation) => CustomizationPage(),
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
                                                                ));
*/
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              27,
                                                                          width:
                                                                              77,
                                                                          decoration: BoxDecoration(
                                                                              borderRadius: BorderRadius.all(Radius.circular(8)),
                                                                              color: ThemeProvider.of(context).brightness == Brightness.light ? Colors.white : head,
                                                                              boxShadow: [
                                                                                BoxShadow(color: Colors.black.withOpacity(0.07), spreadRadius: 0.25, blurRadius: 0.25, offset: Offset(0, 3))
                                                                              ]),
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(left: 7.0, right: 7),
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              children: [
                                                                                Text(
                                                                                  '-',
                                                                                  style: TextStyle(
                                                                                    fontSize: 13,
                                                                                    fontFamily: 'Montserrat',
                                                                                    color: ThemeProvider.of(context).brightness == Brightness.light ? head : Colors.white,
                                                                                    fontWeight: FontWeight.w700,
                                                                                  ),
                                                                                ),
                                                                                Text(
                                                                                  '${cartData[index].quantity}',
                                                                                  style: TextStyle(
                                                                                    fontSize: 13,
                                                                                    fontFamily: 'Montserrat',
                                                                                    color: ThemeProvider.of(context).brightness == Brightness.light ? head : Colors.white,
                                                                                    fontWeight: FontWeight.w700,
                                                                                  ),
                                                                                ),
                                                                                Text(
                                                                                  '+',
                                                                                  style: TextStyle(
                                                                                    fontSize: 13,
                                                                                    fontFamily: 'Montserrat',
                                                                                    color: ThemeProvider.of(context).brightness == Brightness.light ? head : Colors.white,
                                                                                    fontWeight: FontWeight.w700,
                                                                                  ),
                                                                                )
                                                                              ],
                                                                            ),
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
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 39.0, left: 28, right: 28),
                                      child: Container(
                                        height: 39,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: ThemeProvider.of(context)
                                                            .brightness ==
                                                        Brightness.light
                                                    ? Color(0xffDFDFDF)
                                                    : Color(0xff222C44)),
                                            color: ThemeProvider.of(context)
                                                        .brightness ==
                                                    Brightness.light
                                                ? Colors.white
                                                : Color(0xff222C44)),
                                        child: Row(
                                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 11.0),
                                              child: Container(
                                                  height: 39,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      190,
                                                  child: TextField(
                                                    decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      hintText:
                                                          "Enter Promo Code",
                                                      hintStyle: TextStyle(
                                                          fontFamily:
                                                              'Montserrat',
                                                          color: ThemeProvider.of(
                                                                          context)
                                                                      .brightness ==
                                                                  Brightness
                                                                      .light
                                                              ? head
                                                                  .withOpacity(
                                                                      0.7)
                                                              : Colors
                                                                  .white
                                                                  .withOpacity(
                                                                      0.7),
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          height: 1.6),
                                                    ),
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'Montserrat',
                                                        color: ThemeProvider.of(
                                                                        context)
                                                                    .brightness ==
                                                                Brightness.light
                                                            ? head
                                                            : Colors.white,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        height: 1.6),
                                                  )),
                                            ),
                                            Container(
                                              height: 39,
                                              width: 120,
                                              color: button_red,
                                              child: Center(
                                                child: Text(
                                                  'Apply',
                                                  style: TextStyle(
                                                      fontFamily: 'Montserrat',
                                                      color: Colors.white,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 28.0,
                                          right: 28,
                                          bottom: 22,
                                          top: 39),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(16)),
                                            color: ThemeProvider.of(context)
                                                        .brightness ==
                                                    Brightness.light
                                                ? Colors.white
                                                : Color(0xff222C44),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: ThemeProvider.of(
                                                                  context)
                                                              .brightness ==
                                                          Brightness.light
                                                      ? Colors.red
                                                          .withOpacity(0.05)
                                                      : Color(0xff131824)
                                                          .withOpacity(0.07),
                                                  spreadRadius: 16,
                                                  blurRadius: 16,
                                                  offset: Offset(1, 2))
                                            ]),
                                        height: 170,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            left: 19,
                                            right: 33,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Items Total:',
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
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  Text(
                                                    "\$$item_total",
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
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 8.5,
                                              ),
                                              Divider(
                                                height: 1.5,
                                                color: Color(0xffE9E9E9),
                                              ),
                                              SizedBox(
                                                height: 9.5,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Delivery Fee:',
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
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  Text(
                                                    "\$$delivery_fee",
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
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 8.5,
                                              ),
                                              Divider(
                                                height: 1.5,
                                                color: Color(0xffE9E9E9),
                                              ),
                                              SizedBox(
                                                height: 9.5,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Discount:',
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
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  Text(
                                                    "\$0.00",
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
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 8.5,
                                              ),
                                              Divider(
                                                height: 1.5,
                                                color: Color(0xffE9E9E9),
                                              ),
                                              SizedBox(
                                                height: 9.5,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Total:',
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontFamily: 'Montserrat',
                                                      color: ThemeProvider.of(
                                                                      context)
                                                                  .brightness ==
                                                              Brightness.light
                                                          ? head
                                                          : Colors.white,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                  Text(
                                                    "\$$Total",
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontFamily: 'Montserrat',
                                                      color: ThemeProvider.of(
                                                                      context)
                                                                  .brightness ==
                                                              Brightness.light
                                                          ? head
                                                          : Colors.white,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 8.5,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0.0,
                    bottom: 0,
                    left: 0,
                    child: cartlength == 0
                        ? Container(
                            color: ThemeProvider.of(context).brightness ==
                                    Brightness.light
                                ? Color(0xffF8F9FA)
                                : Color(0xff222C44),
                            child: InkWell(
                              onTap: () {},
                              child: Container(
                                height: 56,
                                margin: EdgeInsets.only(
                                    left: 28, right: 18, top: 21, bottom: 18),
                                //padding: EdgeInsets.symmetric(horizontal: 18, vertical: 15),
                                decoration: new BoxDecoration(
                                  color: Color(0xff8F8F8F),

                                  /*boxShadow: [BoxShadow(
                              color: ThemeProvider.of(context).brightness ==
                                  Brightness.light
                                  ?Color(0xffF8F9FA):Color(0xff222C44),
                              spreadRadius:20,
                              blurRadius: 10,
                              offset: Offset(5, 5)
                          )],*/
                                  borderRadius: new BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 14.0, left: 15, bottom: 16),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '$cartlength Item  |  .....',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 18.0, right: 16, bottom: 20),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'NOT AVAILABLE',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Container(
                            color: ThemeProvider.of(context).brightness ==
                                    Brightness.light
                                ? Color(0xffF8F9FA)
                                : Color(0xff222C44),
                            child: InkWell(
                              onTap: () {
                                showMaterialModalBottomSheet(
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (context) {
                                    return StatefulBuilder(builder:
                                        (BuildContext context,
                                            StateSetter setState) {
                                      return payment();
                                    });
                                  },
                                );
                              },
                              child: Container(
                                height: 56,
                                margin: EdgeInsets.only(
                                    left: 28, right: 18, top: 21, bottom: 18),
                                //padding: EdgeInsets.symmetric(horizontal: 18, vertical: 15),
                                decoration: new BoxDecoration(
                                  color:
                                      _checkLogin() ? button_green : button_red,
                                  /*boxShadow: [BoxShadow(
                              color: ThemeProvider.of(context).brightness ==
                                  Brightness.light
                                  ?Color(0xffF8F9FA):Color(0xff222C44),
                              spreadRadius:20,
                              blurRadius: 10,
                              offset: Offset(5, 5)
                          )],*/
                                  borderRadius: new BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                child: _checkLogin()
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 14.0,
                                                left: 15,
                                                bottom: 16),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  '$cartlength Item  |  \$$Total',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white,
                                                      fontFamily: 'Montserrat',
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 18.0,
                                                right: 16,
                                                bottom: 20),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'CHECKOUT',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                      fontFamily: 'Montserrat',
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      )
                                    : GestureDetector(
                                        onTap: () {
                                          pushReplaceAndClearStack(
                                              context: context,
                                              destination: /*OnBoarding*/ OnBoardingPage());
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8)),
                                            color: button_red,
                                          ),
                                          height: 56,
                                          width: 300,
                                          child: Center(
                                            child: Text(
                                              'LOGIN TO CONTINUE',
                                              style: TextStyle(
                                                fontFamily: 'Montserrat',
                                                color: Colors.white,
                                                decoration: TextDecoration.none,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                              ),
                            ),
                          ),
                  )
                ],
              ),
            )),
    );
  }

  bool _checkLogin() {
    final prefProvider =
        Provider.of<SharedPrefProvider>(context, listen: false);
    if (prefProvider.userDataModel.isLoggedIn != null) {
      if (prefProvider.userDataModel.isLoggedIn) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Container payment() {
    return Container(
      height: MediaQuery.of(context).size.height * 3 / 4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(14),
          topRight: Radius.circular(14),
        ),
        color: ThemeProvider.of(context).brightness == Brightness.light
            ? Colors.white
            : Color(0xff222C44),
        boxShadow: [
          BoxShadow(
              color: ThemeProvider.of(context).brightness == Brightness.light
                  ? Color(0xff00000021)
                  : Color(0xff222C44).withOpacity(0.07),
              spreadRadius: 20,
              blurRadius: 20,
              offset: Offset(0, 5))
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 48, left: 25),
              child: Row(
                children: [
                  Text(
                    'Select Payment Option',
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
              padding: const EdgeInsets.only(top: 45, left: 24),
              child: Row(
                children: [
                  Text(
                    'Saved Payment Options',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: ThemeProvider.of(context).brightness ==
                              Brightness.light
                          ? head
                          : Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 15),
              child: Container(
                height: 49,
                decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffF0F1F5)),
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: Padding(
                  padding: const EdgeInsets.only(right: 18.0, left: 11),
                  child: InkWell(
                    onTap: () {
                      if (cred == false) {
                        setState(() {
                          cred = true;
                        });
                      } else {
                        setState(() {
                          cred = false;
                        });
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            height: 28,
                            width: 28,
                            child: Image.asset('images/Logo Payment.png')),
                        Text(
                          'Credit Card.********4124',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: ThemeProvider.of(context).brightness ==
                                    Brightness.light
                                ? head.withOpacity(0.3)
                                : Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                        Container(
                          height: 14,
                          width: 14,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: ThemeProvider.of(context).brightness ==
                                        Brightness.light
                                    ? head
                                    : Colors.white,
                              ),
                              color: cred == false
                                  ? Colors.transparent
                                  : (ThemeProvider.of(context).brightness ==
                                          Brightness.light
                                      ? head
                                      : Colors.white)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              cred == false
                                  ? Container()
                                  : Icon(
                                      Icons.check,
                                      color: ThemeProvider.of(context)
                                                  .brightness ==
                                              Brightness.light
                                          ? Colors.white
                                          : head,
                                      size: 12,
                                    ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 16),
              child: Container(
                height: 49,
                decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffF0F1F5)),
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: Padding(
                  padding: const EdgeInsets.only(right: 18.0, left: 11),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          height: 11,
                          width: 36,
                          child: Image.asset(
                            'images/iconfinder_social_visa_406088.png',
                            color: ThemeProvider.of(context).brightness ==
                                    Brightness.light
                                ? Colors.black
                                : Colors.white,
                          )),
                      Text(
                        'Debit Card.********4124',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: ThemeProvider.of(context).brightness ==
                                  Brightness.light
                              ? head.withOpacity(0.3)
                              : Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                      Container(
                        height: 14,
                        width: 14,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: ThemeProvider.of(context).brightness ==
                                        Brightness.light
                                    ? head
                                    : Colors.white)),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 27, left: 24),
              child: Row(
                children: [
                  Text(
                    'Other Payment Options',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: ThemeProvider.of(context).brightness ==
                              Brightness.light
                          ? head
                          : Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 21),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: 84,
                        width: (MediaQuery.of(context).size.width - 67) / 2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                          color: ThemeProvider.of(context).brightness ==
                                  Brightness.light
                              ? button_red.withOpacity(0.025)
                              : head,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 16, top: 16, right: 21),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '+',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: ThemeProvider.of(context).brightness ==
                                          Brightness.light
                                      ? head
                                      : Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 21,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                      height: 34,
                                      width: 45,
                                      child: Image.asset('images/2697.png')),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Text(
                                    'PSE Payment',
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
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 19,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    AddCard(),
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
                          height: 84,
                          width: (MediaQuery.of(context).size.width - 67) / 2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                            color: ThemeProvider.of(context).brightness ==
                                    Brightness.light
                                ? Color(0xff0552CC).withOpacity(0.05)
                                : head,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 16, top: 16, right: 21),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '+',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color:
                                        ThemeProvider.of(context).brightness ==
                                                Brightness.light
                                            ? head
                                            : Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 21,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                            height: 11,
                                            width: 36,
                                            child: Image.asset(
                                              'images/iconfinder_social_visa_406088.png',
                                              color: ThemeProvider.of(context)
                                                          .brightness ==
                                                      Brightness.light
                                                  ? Colors.black
                                                  : Colors.white,
                                            )),
                                        SizedBox(
                                          width: 7,
                                        ),
                                        Container(
                                            height: 32,
                                            width: 32,
                                            child: Image.asset(
                                                'images/Logo Payment.png')),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Text(
                                      'Add a Card',
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
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    AddPaypal(),
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
                          height: 84,
                          width: (MediaQuery.of(context).size.width - 67) / 2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                            color: ThemeProvider.of(context).brightness ==
                                    Brightness.light
                                ? Color(0xffAFDDF2).withOpacity(0.2)
                                : head,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 16, top: 16, right: 21),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '+',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color:
                                        ThemeProvider.of(context).brightness ==
                                                Brightness.light
                                            ? head
                                            : Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 21,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                        height: 25,
                                        width: 23,
                                        child: Image.asset(
                                            'images/iconfinder_logo_brand_brands_logos_paypal_2993670.png')),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    Text(
                                      'Paypal',
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
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 19,
                      ),
                      Container(
                        height: 84,
                        width: (MediaQuery.of(context).size.width - 67) / 2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                          color: ThemeProvider.of(context).brightness ==
                                  Brightness.light
                              ? Color(0xffA3D777).withOpacity(0.2)
                              : head,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 16, top: 16, right: 21),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '+',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: ThemeProvider.of(context).brightness ==
                                          Brightness.light
                                      ? head
                                      : Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 21,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                      height: 18,
                                      width: 32,
                                      child: Image.asset(
                                          'images/iconfinder_Money_3387302.png')),
                                  SizedBox(
                                    height: 23,
                                  ),
                                  Text(
                                    'Cash on Delivery',
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
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 41, left: 33),
              child: Row(
                children: [
                  Text(
                    'Deliver to Home',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: ThemeProvider.of(context).brightness ==
                              Brightness.light
                          ? head
                          : Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 35, right: 35),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                        width: 16,
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
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            ChooseLocation(),
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
                    child: Text(
                      'Change',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: button_red,
                        fontWeight: FontWeight.w400,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      OrderPlaced(),
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
              child: Container(
                height: 56,
                width: double.infinity,
                margin:
                    EdgeInsets.only(left: 28, right: 28, top: 27, bottom: 40),
                //padding: EdgeInsets.symmetric(horizontal: 18, vertical: 15),
                decoration: new BoxDecoration(
                  color: button_green,
                  boxShadow: [
                    BoxShadow(
                        color: ThemeProvider.of(context).brightness ==
                                Brightness.light
                            ? button_green.withOpacity(0.5)
                            : Color(0xff222C44),
                        spreadRadius: 0,
                        blurRadius: 36,
                        offset: Offset(0, 3))
                  ],
                  borderRadius: new BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Proceed to pay',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool cred = false;
  bool debit = false;
}

class CartList {
  final int id, quantity;
  final String name, price, img;
  bool favorite;

  CartList({
    this.id,
    this.quantity,
    this.price,
    this.name,
    this.img,
    this.favorite,
  });

  factory CartList.fromJson(Map<String, dynamic> jsonData) {
    return CartList(
      id: jsonData['id'],
      quantity: jsonData['quantity'],
      price: jsonData['price'],
      name: jsonData['name'],
      img: jsonData['img'],
      favorite: false,
    );
  }

  static Map<String, dynamic> toMap(CartList music) => {
        'id': music.id,
        'quantity': music.quantity,
        'price': music.price,
        'name': music.name,
        'img': music.img,
        'favorite': music.favorite,
      };

  static String encode(List<CartList> musics) => json.encode(
        musics
            .map<Map<String, dynamic>>((music) => CartList.toMap(music))
            .toList(),
      );

  static List<CartList> decode(String musics) =>
      (json.decode(musics) as List<dynamic>)
          .map<CartList>((item) => CartList.fromJson(item))
          .toList();
}
