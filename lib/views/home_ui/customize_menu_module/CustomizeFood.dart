import 'dart:convert';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../bottom_bar_ui/bottom_bar.dart';
import '../../../utils/app_colors.dart';
import '../seller_menu_module/seller_menu_items_page.dart';

class CustomizationPage extends StatefulWidget {
  @override
  _CustomizationPageState createState() => _CustomizationPageState();
}

class _CustomizationPageState extends State<CustomizationPage> {
  int quantity = 1;
  List<CustomizeMenu> fullMenu = new List<CustomizeMenu>();
  List<ListMenu> CustomMenu = new List<ListMenu>();
  String Cname;
  String Cprice;
  String Clogo;
  int Cid;
  int q = 1;

  getDatas() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      Cname = prefs.getString('Cname');
      Cprice = prefs.getString('Cprice');
      Clogo = prefs.getString('Clogo');
      Cid = prefs.getInt('Cid');
    });
  }

  Future<String> getCustomizetMenu() async {
    var url =
        'https://www.comiida.com/appapi/restaurant/getmodifier/3param: id(int)';

    var response = await http.get(Uri.parse(url));
    // print(response.body);
    fullMenu.clear();
    Map<String, dynamic> convertData = json.decode(response.body);
    for (var menu in convertData.keys) {
      List<CustomizeMenu> tempmenu = new List<CustomizeMenu>();
      for (var count in convertData[menu]["Modifiers"].keys) {
        var tempRestaurantMenu = new CustomizeMenu(
          convertData[menu]["Modifiers"][count]['ModId'],
          convertData[menu]["Modifiers"][count]['Name'],
          convertData[menu]["Modifiers"][count]['MaxVal'],
          convertData[menu]["Modifiers"][count]['Price'],
          convertData[menu]["Modifiers"][count]['Image'],
        );
        setState(() {
          tempmenu.add(tempRestaurantMenu);
        });
      }
      setState(() {
        CustomMenu.add(ListMenu("${convertData[menu]["Category"]}", tempmenu));
      });
    }

    setState(() {
      print('REFRESSSSHHHHEEEDDDD');
      //print(fullMenu[0].Name);
      print(CustomMenu[0].Category);
      print(CustomMenu[0].datas[0].Name);
      print(CustomMenu[0].datas[1].Name);
      print(CustomMenu[0].datas[2].Name);
      print(CustomMenu[1].Category);
      print(CustomMenu[1].datas[0].Name);
      print(CustomMenu[1].datas[1].Name);
      print(CustomMenu[1].datas[2].Name);
    });
  }

  int selected_index1;
  List<String> selected_index2 = new List();

  String clist;
  int cartlength = 0;
  bool loaded = false;
  List<CartList> cartData = new List();
  List<double> item_price_list = new List();
  List<int> item_quantity_list = new List();
  List<double> total_list = new List();

  getCartDatas() async {
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

    getCustomizetMenu();
    getCartDatas();
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
                height: 73,
                width: double.infinity,
                decoration: BoxDecoration(
                    color:
                        ThemeProvider.of(context).brightness == Brightness.light
                            ? Colors.white
                            : Color(0xff131824),
                    /*boxShadow: [BoxShadow(
                        color: ThemeProvider.of(context).brightness ==
                            Brightness.light
                            ?Colors.red.withOpacity(0.07):Color(0xff222C44).withOpacity(0.07),

                        blurRadius: 6,
                        offset: Offset(0, 3)
                    )],*/
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
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          RestuarentPage()));
                            },
                            child: Container(
                              width: 50,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  // Image.asset('images/location-map.png',fit: BoxFit.contain,height: 20,),
                                  Icon(
                                    Icons.close,
                                    size: 24,
                                    color: head,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Text(
                            'Customize Food',
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
                padding: const EdgeInsets.only(top: 22.0, left: 20, right: 29),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 14,
                                      width: 14,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(color: button_green),
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
                                      top: 6.0, bottom: 3),
                                  child: Text(
                                    '$Cname',
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
                                  padding: const EdgeInsets.only(
                                      bottom: 2.0, top: 4),
                                  child: Row(
                                    children: [
                                      Text(
                                        '\$$Cprice',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'Montserrat',
                                          color: ThemeProvider.of(context)
                                                      .brightness ==
                                                  Brightness.light
                                              ? Color(0xff8F8F8F)
                                              : Colors.white.withOpacity(0.7),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      /* Text('  +3\$',style:  TextStyle(fontSize: 12,fontFamily: 'Montserrat',
                                        color: button_green,fontWeight: FontWeight.w400,),),*/
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 13.0, right: 12),
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
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8)),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                  '$Clogo',
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
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8)),
                                                color: ThemeProvider.of(context)
                                                            .brightness ==
                                                        Brightness.light
                                                    ? Colors.white
                                                    : head,
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.07),
                                                      spreadRadius: 0.25,
                                                      blurRadius: 0.25,
                                                      offset: Offset(0, 3))
                                                ]),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 7.0, right: 7),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      if (quantity != 0) {
                                                        setState(() {
                                                          quantity =
                                                              quantity - 1;
                                                        });
                                                      }
                                                    },
                                                    child: Container(
                                                      width: 22,
                                                      child: Text(
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
                                                    ),
                                                  ),
                                                  Text(
                                                    '$quantity',
                                                    style: TextStyle(
                                                      fontSize: 13,
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
                                                  InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        quantity = quantity + 1;
                                                      });
                                                    },
                                                    child: Container(
                                                      width: 22,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
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
                                                                  : Colors
                                                                      .white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
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
              ),
              CustomMenu.length != 0
                  ? Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding:
                                  EdgeInsets.only(left: 24, top: 38, right: 14),
                              child: Text(
                                'Choose ${CustomMenu[0].Category}',
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
                            ),
                          ],
                        ),
                        Container(
                          height: CustomMenu[0].datas.length.toDouble() * 41,
                          child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: CustomMenu[0].datas.length,
                              itemBuilder: (BuildContext ctxt, int index) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                      left: 24, top: 0, right: 24),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        if (selected_index2
                                            .contains('$index')) {
                                          selected_index2.remove('$index');
                                        } else {
                                          selected_index2.add('$index');
                                        }
                                      });
                                    },
                                    child: Container(
                                      height: 41,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '${CustomMenu[0].datas[index].Name}',
                                            style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              color: ThemeProvider.of(context)
                                                          .brightness ==
                                                      Brightness.light
                                                  ? head
                                                  : Colors.white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                '\$${CustomMenu[0].datas[index].Price}',
                                                style: TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  color:
                                                      ThemeProvider.of(context)
                                                                  .brightness ==
                                                              Brightness.light
                                                          ? head
                                                          : Colors.white,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 26,
                                              ),
                                              Container(
                                                height: 14,
                                                width: 14,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: ThemeProvider.of(
                                                                      context)
                                                                  .brightness ==
                                                              Brightness.light
                                                          ? head
                                                          : Colors.white,
                                                    ),
                                                    color: selected_index2
                                                            .contains('$index')
                                                        ? (ThemeProvider.of(
                                                                        context)
                                                                    .brightness ==
                                                                Brightness.light
                                                            ? head
                                                            : Colors.white)
                                                        : Colors.transparent),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    selected_index2
                                                            .contains('$index')
                                                        ? Icon(
                                                            Icons.check,
                                                            color: ThemeProvider.of(
                                                                            context)
                                                                        .brightness ==
                                                                    Brightness
                                                                        .light
                                                                ? Colors.white
                                                                : head,
                                                            size: 12,
                                                          )
                                                        : Container(),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding:
                                  EdgeInsets.only(left: 24, top: 30, right: 24),
                              child: Text(
                                'Choose ${CustomMenu[1].Category}',
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
                            ),
                          ],
                        ),
                        Container(
                          height: CustomMenu[1].datas.length.toDouble() * 41,
                          child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: CustomMenu[1].datas.length,
                              itemBuilder: (BuildContext ctxt, int index) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                      left: 24, top: 0, right: 24),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        selected_index1 = index;
                                      });
                                    },
                                    child: Container(
                                      height: 41,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '${CustomMenu[1].datas[index].Name}',
                                            style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              color: ThemeProvider.of(context)
                                                          .brightness ==
                                                      Brightness.light
                                                  ? head
                                                  : Colors.white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                '\$${CustomMenu[1].datas[index].Price}',
                                                style: TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  color:
                                                      ThemeProvider.of(context)
                                                                  .brightness ==
                                                              Brightness.light
                                                          ? head
                                                          : Colors.white,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 26,
                                              ),
                                              Container(
                                                height: 14,
                                                width: 14,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      color: ThemeProvider.of(
                                                                      context)
                                                                  .brightness ==
                                                              Brightness.light
                                                          ? head
                                                          : Colors.white,
                                                    ),
                                                    color: selected_index1 !=
                                                            index
                                                        ? Colors.transparent
                                                        : (ThemeProvider.of(
                                                                        context)
                                                                    .brightness ==
                                                                Brightness.light
                                                            ? head
                                                            : Colors.white)),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    selected_index1 != index
                                                        ? Container()
                                                        : Icon(
                                                            Icons.check,
                                                            color: ThemeProvider.of(
                                                                            context)
                                                                        .brightness ==
                                                                    Brightness
                                                                        .light
                                                                ? Colors.white
                                                                : head,
                                                            size: 12,
                                                          ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ],
                    )
                  : Container(
                      height: 300,
                      child: Center(child: CircularProgressIndicator())),
              Padding(
                padding: EdgeInsets.only(top: 24, left: 25, right: 25),
                child: MySeparator(
                  height: 0.5,
                  color: head,
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 28, right: 28, top: 44, bottom: 30),
                child: Container(
                  height: 56,
                  decoration: new BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: ThemeProvider.of(context).brightness ==
                                  Brightness.light
                              ? button_green.withOpacity(0.3)
                              : button_green.withOpacity(0.3),
                          spreadRadius: 8,
                          blurRadius: 20,
                          offset: Offset(3, 3))
                    ],
                    color: button_green,
                    borderRadius: new BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  child: FlatButton(
                    onPressed: () async {
                      var cl;
                      List<CartList> pref_list = new List();

                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      setState(() {
                        cl = prefs.getString('clist');
                        if (cl != null && cl != "") {
                          setState(() {
                            pref_list = CartList.decode(cl);
                          });
                          if (cl.contains('$Cname')) {
                            print('Already added');
                            for (var i = 0; i < pref_list.length; i++) {
                              if (pref_list[i].name == Cname) {
                                setState(() {
                                  pref_list[i] = CartList(
                                      id: Cid,
                                      name: '$Cname',
                                      price: '$Cprice',
                                      img: '$Clogo',
                                      quantity: quantity);
                                });
                              }
                            }
                          } else {
                            pref_list.add(
                              CartList(
                                  id: Cid,
                                  name: '$Cname',
                                  price: '$Cprice',
                                  img: '$Clogo',
                                  quantity: quantity),
                            );
                            print(pref_list);
                          }
                        } else {
                          pref_list.add(
                            CartList(
                                id: Cid,
                                name: '$Cname',
                                price: '$Cprice',
                                img: '$Clogo',
                                quantity: quantity),
                          );
                          // print(pref_list);
                        }
                      });
                      final String encodedData = CartList.encode(pref_list);
                      /* add_cart.add(CartList(id: 1,name:'${fullMenu[index].Name}',price:
                                                                              '${fullMenu[index].Price}',img: '${fullMenu[index].Image}'));
                                                                              print("MMMMMMMMMMMMMMMMMM$add_cart");*/
                      await prefs.setString('clist', '$encodedData');
                      await prefs.setBool('show_cart', true);
                      setState(() {
                        BottomBar.show_track = true;
                      });
                      await getCartDatas();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  RestuarentPage()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Apply",
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
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
          ),
        ),
      ),
    );
  }

  bool s = false;
  bool m = false;
  bool l = false;
  bool e = false;
  bool ms = false;
  bool cs = false;
  bool ss = false;
  bool sp = false;
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

class ListMenu {
  String Category;
  List<CustomizeMenu> datas = new List<CustomizeMenu>();

  ListMenu(this.Category, this.datas);
}

class CustomizeMenu {
  int ModId;
  String Name;
  int MaxVal;
  String Price;
  String Image;

  CustomizeMenu(this.ModId, this.Name, this.MaxVal, this.Price, this.Image);
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
