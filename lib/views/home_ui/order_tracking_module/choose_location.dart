import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:food_delivery/views/home_ui/bottom_bar_ui/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/app_colors.dart';

class ChooseLocation extends StatefulWidget {
  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height-30,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Container(
                      height: 80,
                      decoration: BoxDecoration(
                          boxShadow: [BoxShadow(
                              color: ThemeProvider.of(context).brightness ==
                                  Brightness.light
                                  ? Colors.red.withOpacity(0.07):Color(0xff222C44).withOpacity(0.07) ,
                              spreadRadius:20,
                              blurRadius: 20,
                              offset: Offset(0, 5)
                          )],
                          color: ThemeProvider.of(context).brightness ==
                              Brightness.light
                              ? Colors.white:Color(0xff222C44),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                          )
                      ),
                      child: Padding(
                        padding:  const EdgeInsets.only(left:25.0 ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                                onTap: (){
                                  Navigator.of(context).pop();
                                },
                                child: Icon(Icons.arrow_back,color: ThemeProvider.of(context).brightness ==
                                    Brightness.light
                                    ? head:Colors.white,size: 28,)),
                            SizedBox(width: 43,),
                            Text('Select your location',style:
                            TextStyle(
                              fontFamily: 'Montserrat',color: ThemeProvider.of(context).brightness ==
                                Brightness.light
                                ? head:Colors.white, fontWeight: FontWeight.w700,fontSize: 20,

                            ),),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:45.0,left: 36,right: 36),
                      child: Column(
                        children: [
                          Row(

                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top:2.0,left: 8),
                                child: Container(
                                  height: 13,width: 13,
                                  decoration: BoxDecoration(shape: BoxShape.circle,
                                      border: Border.all(color: ThemeProvider.of(context).brightness ==
                                          Brightness.light
                                          ? Color(0xff8A94A3):Colors.white)),
                                ),
                              ),
                              SizedBox(width: 8,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Current Location',style:
                                  TextStyle(
                                    fontFamily: 'Montserrat',color: ThemeProvider.of(context).brightness ==
                                      Brightness.light
                                      ? head:Colors.white, fontWeight: FontWeight.w700,fontSize: 14,

                                  ),),
                                  Text('Using GPS',style:
                                  TextStyle(
                                    fontFamily: 'Montserrat',color: ThemeProvider.of(context).brightness ==
                                      Brightness.light
                                      ? head:Colors.white, fontWeight: FontWeight.w500,fontSize: 12,

                                  ),),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 35,),
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                                boxShadow: [BoxShadow(
                                    color:  ThemeProvider.of(context).brightness ==
                                        Brightness.light
                                        ? Colors.red.withOpacity(0.07):Color(0xff222C44).withOpacity(0.07),
                                    spreadRadius:16,
                                    blurRadius: 16,
                                    offset: Offset(0, 5)
                                )],
                                color:ThemeProvider.of(context).brightness ==
                                    Brightness.light
                                    ? Colors.white:Color(0xff222C44),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(12),topLeft: Radius.circular(12),
                                )
                            ),
                            child: Row(
                              children: [
                                Text('     SAVED LOCATIONS',style:
                                TextStyle(
                                  fontFamily: 'Montserrat',color: ThemeProvider.of(context).brightness ==
                                    Brightness.light
                                    ? head:Colors.white, fontWeight: FontWeight.w700,fontSize: 12,

                                ),),
                              ],
                            ),
                          ),

                          Container(
                            height: 55,
                            color: ThemeProvider.of(context).brightness ==
                                Brightness.light
                                ? button_red.withOpacity(0.01):head,
                            child: Padding(
                              padding: const EdgeInsets.only(left:8.0),
                              child: Row  (
                                // mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top:12.0),
                                    child:Icon(Icons.location_on_outlined,color:ThemeProvider.of(context).brightness ==
                                        Brightness.light
                                        ? Color(0xff8A94A3):Colors.white,size: 20,),
                                  ),
                                  SizedBox(width: 8,),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Home',style:
                                      TextStyle(
                                        fontFamily: 'Montserrat',color: ThemeProvider.of(context).brightness ==
                                          Brightness.light
                                          ? head:Colors.white, fontWeight: FontWeight.w700,fontSize: 14,

                                      ),),
                                      Text('77th Street. 90 W 22nd St, SD',style:
                                      TextStyle(
                                        fontFamily: 'Montserrat',color: ThemeProvider.of(context).brightness ==
                                          Brightness.light
                                          ? head:Colors.white, fontWeight: FontWeight.w500,fontSize: 12,

                                      ),),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),

                          Container(
                            height: 70,
                            decoration: BoxDecoration(
                                boxShadow: [BoxShadow(
                                    color:  ThemeProvider.of(context).brightness ==
                                        Brightness.light
                                        ? Colors.red.withOpacity(0.07):Color(0xff222C44).withOpacity(0.07),
                                    spreadRadius:12,
                                    blurRadius: 12,
                                    offset: Offset(0, 5)
                                )],
                                color: ThemeProvider.of(context).brightness ==
                                    Brightness.light
                                    ? Colors.white:Color(0xff222C44),
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(12),bottomLeft: Radius.circular(12),
                                )
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top:14.0,bottom: 19,left: 8),
                              child: Row(

                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top:2.0),
                                    child:Icon(Icons.location_on_outlined,color: ThemeProvider.of(context).brightness ==
                                        Brightness.light
                                        ? Color(0xff8A94A3):Colors.white,size: 20,),
                                  ),
                                  SizedBox(width: 8,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Home',style:
                                      TextStyle(
                                        fontFamily: 'Montserrat',color: ThemeProvider.of(context).brightness ==
                                          Brightness.light
                                          ? head:Colors.white, fontWeight: FontWeight.w700,fontSize: 14,

                                      ),),
                                      Text('77th Street. 90 W 22nd St, SD',style:
                                      TextStyle(
                                        fontFamily: 'Montserrat',color: ThemeProvider.of(context).brightness ==
                                          Brightness.light
                                          ? head:Colors.white, fontWeight: FontWeight.w500,fontSize: 12,

                                      ),),
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
                      padding: const EdgeInsets.only(top:31.0,left: 36),
                      child: Row(
                        children: [
                          Text('RECENT SEARCHES',style:
                          TextStyle(
                            fontFamily: 'Montserrat',color: ThemeProvider.of(context).brightness ==
                              Brightness.light
                              ? head:Colors.white, fontWeight: FontWeight.w700,fontSize: 12,

                          ),),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:22.0,bottom: 0,left: 33),
                      child: Row(

                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top:2.0),
                            child:Icon(Icons.location_on_outlined,color: ThemeProvider.of(context).brightness ==
                                Brightness.light
                                ? Color(0xff8A94A3):Colors.white,size: 20,),
                          ),
                          SizedBox(width: 14,),
                          Text('6382 General Street',style:
                          TextStyle(
                            fontFamily: 'Montserrat',color: ThemeProvider.of(context).brightness ==
                              Brightness.light
                              ? head:Colors.white, fontWeight: FontWeight.w600,fontSize: 12,

                          ),),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:21.0,bottom: 0,left: 33),
                      child: Row(

                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top:2.0),
                            child:Icon(Icons.location_on_outlined,color: ThemeProvider.of(context).brightness ==
                                Brightness.light
                                ? Color(0xff8A94A3):Colors.white,size: 20,),
                          ),
                          SizedBox(width: 14,),
                          Text('140031',style:
                          TextStyle(
                            fontFamily: 'Montserrat',color: ThemeProvider.of(context).brightness ==
                              Brightness.light
                              ? head:Colors.white, fontWeight: FontWeight.w600,fontSize: 12,

                          ),),
                        ],
                      ),
                    ),
                  ],
                ),



                Padding(
                  padding: EdgeInsets.only(left:28.0,right: 28,top: 0,bottom: 20),
                  child: Column(
                    children: [



                      InkWell(
                        onTap: (){
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8)),
                            color: button_green,
                          boxShadow: [BoxShadow(
                              color: ThemeProvider.of(context).brightness ==
                                  Brightness.light
                                  ? button_green.withOpacity(0.3):Color(0xff222C44).withOpacity(0.07) ,
                              spreadRadius:10,
                              blurRadius: 36,
                              offset: Offset(0, 3)
                          )],),
                          height: 56,
                          width: double.infinity,

                          child:  Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Select',style:
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
      ),
    );
  }
}
