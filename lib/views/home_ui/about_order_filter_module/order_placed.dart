
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:food_delivery/views/home_ui/order_tracking_module/user_order_tracking.dart';
import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';

class OrderPlaced extends StatefulWidget {
  @override
  _OrderPlacedState createState() => _OrderPlacedState();
}

class _OrderPlacedState extends State<OrderPlaced> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 25,left: 30,right: 30),
                child: Row(

                  children: [
                    Container(
                        width: 16,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: (){
                                Navigator.of(context).pop();
                              },
                              child: Icon(Icons.arrow_back,size: 25,color: ThemeProvider.of(context).brightness ==
                                  Brightness.light
                                  ? head:Colors.white,),
                            ),
                          ],
                        )),

                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:60.0,left: 39,right: 39,bottom: 46),
                child: Container(
                  height: 286.4,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'images/undraw_ice_cream_s2rh.png'
                      )
                    )
                  ),
                ),
              ),
              Text('Hurray, Order placed!',style: TextStyle(
                fontFamily: 'Montserrat',color:  button_red, fontWeight: FontWeight.w700,fontSize: 19,

              ),),
              Text('Mouth watering food enroute..',style: TextStyle(
                fontFamily: 'Montserrat',color: ThemeProvider.of(context).brightness ==
                  Brightness.light
                  ? head:Colors.white, fontWeight: FontWeight.w700,fontSize: 19,

              ),),
              Padding(
                padding: EdgeInsets.only(left:28.0,right: 28,top: 140,bottom: 20),
                child: Column(
                  children: [



                    InkWell(
                      onTap: (){
                        Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) => TrackOrder(),
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

                      },
                      child: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8)),
                          color: button_green,
                          boxShadow: [BoxShadow(
                              color: ThemeProvider.of(context).brightness ==
                                  Brightness.light
                                  ? button_green.withOpacity(0.3):Color(0xff222C44).withOpacity(0.07) ,

                              blurRadius: 36,
                              offset: Offset(0, 3)
                          )],),
                        height: 56,
                        width: double.infinity,

                        child:  Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Track Order',style:
                            TextStyle(
                              fontFamily: 'Montserrat',color: Colors.white, fontWeight: FontWeight.w400,fontSize: 14,

                            ),),
                          ],
                        ),
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
