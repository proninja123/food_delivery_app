
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';

class AddPaypal extends StatefulWidget {
  @override
  _AddPaypalState createState() => _AddPaypalState();
}

class _AddPaypalState extends State<AddPaypal> {

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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        width: 16,
                        child: InkWell(
                          onTap: (){
                            Navigator.of(context).pop();
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.arrow_back,size: 25,color:  ThemeProvider.of(context).brightness ==
                                  Brightness.light
                                  ? head:Colors.white,),
                            ],
                          ),
                        )),
                    Text('Add paypal',style: TextStyle(
                      fontFamily: 'Montserrat',color: ThemeProvider.of(context).brightness ==
                        Brightness.light
                        ? head:Colors.white, fontWeight: FontWeight.w700,fontSize: 20,

                    ),),
                    Container(
                      height: 14,width: 16,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:49.0,left: 31,bottom: 11),
                child: Row(
                  children: [
                    Container(
                        height: 31,width: 28,
                        child: Image.asset('images/iconfinder_logo_brand_brands_logos_paypal_2993670.png')),
                  ],
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 0,left: 30,bottom: 11)
                ,child: Row(
                  children: [
                    Text('Enter E-mail',style: TextStyle(
                      fontFamily: 'Montserrat',color: ThemeProvider.of(context).brightness ==
                        Brightness.light
                        ? head:Colors.white, fontWeight: FontWeight.w700,fontSize: 20,

                    ),),
                  ],
                ) ,
              ),
              Padding(padding: EdgeInsets.only(top: 0,left: 30,bottom: 38,right: 51)
                ,child: Row(
                  children: [
                    Text('Please enter the email linked to your paypal\naccount to use as payment method.',style: TextStyle(
                      fontFamily: 'Montserrat',color: ThemeProvider.of(context).brightness ==
                        Brightness.light
                        ? head:Colors.white, fontWeight: FontWeight.w400,fontSize: 12,

                    ),),
                  ],
                ) ,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 31,right: 31,bottom: 21),
                child: Container(height: 50,
                  decoration: BoxDecoration(

                      color:ThemeProvider.of(context).brightness ==
                          Brightness.light
                          ? Colors.white:Color(0xff131824),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      border: Border.all(color: button_red)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left:16.0),
                        child: TextField(

                          decoration: InputDecoration(border: InputBorder.none,
                            hintText: 'Enter your Email ID',
                            hintStyle:  TextStyle(
                              fontFamily: 'Montserrat',color: ThemeProvider.of(context).brightness ==
                                Brightness.light
                                ? head.withOpacity(0.37):Colors.white.withOpacity(0.37), fontWeight: FontWeight.w400,fontSize: 12,

                            ),
                            contentPadding: EdgeInsets.zero,
                          ),
                          style:  TextStyle(
                            fontFamily: 'Montserrat',color: ThemeProvider.of(context).brightness ==
                              Brightness.light
                              ? head:Colors.white, fontWeight: FontWeight.w400,fontSize: 12,

                          ),
                        ),
                      ),
                    ],
                  ),),
              ),
              Padding(padding: EdgeInsets.only(top: 0,left: 31,bottom: 65,right: 51)
                ,child: Row(
                  children: [
                    Text("You will be redirected to paypal's gateway to\nconfirm and save your account.",style: TextStyle(
                      fontFamily: 'Montserrat',color: ThemeProvider.of(context).brightness ==
                        Brightness.light
                        ? head.withOpacity(0.26):Colors.white.withOpacity(0.26), fontWeight: FontWeight.w400,fontSize: 12,

                    ),),
                  ],
                ) ,
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
                          color: button_red,
                          boxShadow: [BoxShadow(
                              color: ThemeProvider.of(context).brightness ==
                                  Brightness.light
                                  ? button_red.withOpacity(0.3):Color(0xff222C44).withOpacity(0.07) ,

                              blurRadius: 36,
                              offset: Offset(0, 3)
                          )],),
                        height: 56,
                        width: double.infinity,

                        child:  Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Add Paypal',style:
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
