
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:food_delivery/views/home_ui/profile_module/profile_about_application/faq.dart';
import 'package:food_delivery/views/home_ui/profile_module/profile_about_application/privacy_policy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../utils/app_colors.dart';


class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {

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

          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Container(
                  height: 85,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: ThemeProvider.of(context).brightness ==
                          Brightness.light
                          ?Colors.white:Color(0xff222C44),
                      boxShadow: [BoxShadow(
                          color: ThemeProvider.of(context).brightness ==
                              Brightness.light
                              ?Colors.red.withOpacity(0.07):Color(0xff222C44).withOpacity(0.07),

                          blurRadius: 6,
                          offset: Offset(0, 3)
                      )],
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20) )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding:  EdgeInsets.only(left:24,right: 24,
                            top: 28),

                        child: new Row
                          (
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children:
                          [
                            InkWell(
                              onTap: (){
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                width: 50,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    // Image.asset('images/location-map.png',fit: BoxFit.contain,height: 20,),
                                    Icon(Icons.arrow_back,size: 24, color: ThemeProvider.of(context).brightness ==
                                        Brightness.light
                                        ? head:Colors.white,),

                                  ],
                                ),
                              ),
                            ),


                            Text('About Comiida',style: TextStyle(
                              fontFamily: 'Montserrat',color: ThemeProvider.of(context).brightness ==
                                Brightness.light
                                ? head:Colors.white, fontWeight: FontWeight.w700,fontSize: 20,

                            ),),

                            Container(
                              width:50,

                            ),

                          ],
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(top:18),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                          ],
                        ),
                      ),


                    ],),

                ),
                Padding(
                  padding: const EdgeInsets.only(left:25.5,right: 35,top: 41),
                  child: InkWell(
                    onTap: (){
                      Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) => PrivacyPolicy(),
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
                    child:   Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Privacy Policy',style:
                        TextStyle(
                          fontFamily: 'Montserrat',color:ThemeProvider.of(context).brightness ==
                            Brightness.light
                            ? head:Colors.white, fontWeight: FontWeight.w700,fontSize: 14,

                        ),),

                        Icon(Icons.arrow_forward_ios,color:ThemeProvider.of(context).brightness ==
                            Brightness.light
                            ? head.withOpacity(0.5):Colors.white.withOpacity(0.5),size: 15,),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Divider(color: ThemeProvider.of(context).brightness ==
                    Brightness.light
                    ?head.withOpacity(0.15):Colors.white.withOpacity(0.35),),
                SizedBox(height: 10,),
                InkWell(
                  onTap: (){
                    Navigator.of(context).push(PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) => FAQS(),
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
                  child: Padding(
                    padding: const EdgeInsets.only(left:25.5,right: 35,top: 0),
                    child:   Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("FAQ's",style:
                        TextStyle(
                          fontFamily: 'Montserrat',color:ThemeProvider.of(context).brightness ==
                            Brightness.light
                            ? head:Colors.white, fontWeight: FontWeight.w700,fontSize: 14,

                        ),),

                        Icon(Icons.arrow_forward_ios,color:ThemeProvider.of(context).brightness ==
                            Brightness.light
                            ? head.withOpacity(0.5):Colors.white.withOpacity(0.5),size: 15,),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Divider(color: ThemeProvider.of(context).brightness ==
                    Brightness.light
                    ?head.withOpacity(0.15):Colors.white.withOpacity(0.35),),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.only(left:25.5,right: 35,top: 0),
                  child:   Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Terms of Services",style:
                      TextStyle(
                        fontFamily: 'Montserrat',color:ThemeProvider.of(context).brightness ==
                          Brightness.light
                          ? head:Colors.white, fontWeight: FontWeight.w700,fontSize: 14,

                      ),),

                      Icon(Icons.arrow_forward_ios,color:ThemeProvider.of(context).brightness ==
                          Brightness.light
                          ? head.withOpacity(0.5):Colors.white.withOpacity(0.5),size: 15,),
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Divider(color:  ThemeProvider.of(context).brightness ==
                    Brightness.light
                    ?head.withOpacity(0.15):Colors.white.withOpacity(0.35),),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.only(left:25.5,right: 35,top: 0),
                  child:   Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Licenses",style:
                      TextStyle(
                        fontFamily: 'Montserrat',color:ThemeProvider.of(context).brightness ==
                          Brightness.light
                          ? head:Colors.white, fontWeight: FontWeight.w700,fontSize: 14,

                      ),),

                      Icon(Icons.arrow_forward_ios,color:ThemeProvider.of(context).brightness ==
                          Brightness.light
                          ? head.withOpacity(0.5):Colors.white.withOpacity(0.5),size: 15,),
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Divider(color:  ThemeProvider.of(context).brightness ==
                    Brightness.light
                    ?head.withOpacity(0.15):Colors.white.withOpacity(0.35),),
              ],
            ),
          ),
        ),
      ),
    );
  }

}