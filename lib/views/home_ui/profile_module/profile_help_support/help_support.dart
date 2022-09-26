
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:expandable/expandable.dart';
import '../../../../utils/app_colors.dart';


class HelpSupport extends StatefulWidget {
  @override
  _HelpSupportState createState() => _HelpSupportState();
}

class _HelpSupportState extends State<HelpSupport> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }
  @override
  Widget build(BuildContext context) {
    Dialog Succes_dialogue = Dialog(
      backgroundColor: ThemeProvider.of(context).brightness ==
          Brightness.light
          ?Colors.white:Color(0xff222C44),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)), //this right here
      child: Container(

        height: 432.0,
        width: MediaQuery.of(context).size.width-43,

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding:  EdgeInsets.all(0.0),
              child:Container(height: 183,width: 183,
              child: Image.asset('images/Component 5 – 2.png',height: 183,width: 183),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Text('Thanks!', style: TextStyle(
                    fontFamily: 'Montserrat',color:  button_red, fontWeight: FontWeight.w700,fontSize: 16,

                  ),),
                  Text('for Contacting Us', style: TextStyle(
                    fontFamily: 'Montserrat',color:  ThemeProvider.of(context).brightness ==
                      Brightness.light
                      ?head:Colors.white, fontWeight: FontWeight.w700,fontSize: 16,

                  ),),
                  SizedBox(height: 20,),
                  Text('We will get back to you soon!', style: TextStyle(
                    fontFamily: 'Montserrat',color: ThemeProvider.of(context).brightness ==
                      Brightness.light
                      ? head.withOpacity(0.5):Colors.white.withOpacity(0.5), fontWeight: FontWeight.w700,fontSize: 14,

                  ),),
                ],
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 30.0)),
            Padding(
              padding: EdgeInsets.only(left:28.0,right: 28,top: 0,bottom: 0),
              child: Column(
                children: [



                  InkWell(
                    onTap: (){
Navigator.of(context).pop();
                    },
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: button_green,
                        boxShadow:  [BoxShadow(
                            color: button_green.withOpacity(0.4) ,
                            spreadRadius:5,
                            blurRadius: 36,
                            offset: Offset(3, 3)
                        )],),
                      height: 56,
                      width: double.infinity,

                      child:  Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Back to home',style:
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
    );
    return Scaffold(

      body: SafeArea(
        child: SingleChildScrollView(

          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
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


                                Text('Help support',style: TextStyle(
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
                      padding: const EdgeInsets.only(top:64.0,left: 22,right: 22),
                      child: Container(height: 48,width: double.infinity,
                        decoration: BoxDecoration(
                          boxShadow: [BoxShadow(
                              color: ThemeProvider.of(context).brightness ==
                                  Brightness.light
                                  ? Colors.red.withOpacity(0.07):Color(0xff222C44).withOpacity(0.07) ,
                              spreadRadius:10,
                              blurRadius: 10,
                              offset: Offset(3, 3)
                          )],
                          color: ThemeProvider.of(context).brightness ==
                              Brightness.light
                              ? Colors.white:Color(0xff222C44),
                          borderRadius: BorderRadius.all(
                            Radius.circular(14),
                          ),

                        ),
                        child: DropdownButton(

                          onTap: (){
                            /* focusNode1.unfocus();
                                  focusNode2.unfocus();
                                  focusNode3.unfocus();*/

                            print('hhhhhhhhhhhhhhhhhhhh');

                          },
                          underline: Container(color: Colors.transparent),
                          icon: Row(
                            children: [
                              SizedBox(width: (MediaQuery.of(context).size.width/2)-44,),
                              Icon(Icons.keyboard_arrow_down_sharp,color: button_red,),
                            ],
                          ),
                          elevation: 0,
                          autofocus: true,
                          hint:Padding(
                            padding: const EdgeInsets.only(left:16.0),
                            child: Text('Select the type of help',style: TextStyle(fontSize: 12,fontFamily: 'Montserrat',
                                color: ThemeProvider.of(context).brightness ==
                                    Brightness.light
                                    ? head:Colors.white,fontWeight: FontWeight.w600),),
                          ),

                          style: TextStyle(fontSize: 12,fontFamily: 'Montserrat',
                              color: ThemeProvider.of(context).brightness ==
                                  Brightness.light
                                  ? head:Colors.white,fontWeight: FontWeight.w500),
                          value: _selectedLocation,
                          onChanged: (newValue) {
                            setState(() {
                              _selectedLocation = newValue;
                            });

                          },
                          items: _locations.map((location) {
                            return DropdownMenuItem(

                              child: Padding(
                                padding: const EdgeInsets.only(left:16.0),
                                child: new Text(location),
                              ),
                              value: location,
                            );
                          }).toList(),
                        ),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:22.0,right: 22,top: 33),
                      child: Column(
                        children: [
                          Container(
                            height: 168,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(color: Color(0xffF0F1F5)),
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                            ),
                            child:  Padding(
                      padding: const EdgeInsets.only(left:16.0),
                      child: TextField(


                        decoration: InputDecoration(border: InputBorder.none,
                          hintText: 'Message',
                          hintStyle:   TextStyle(fontSize: 12,fontFamily: 'Montserrat',
                              color: ThemeProvider.of(context).brightness ==
                                  Brightness.light
                                  ? head:Colors.white,fontWeight: FontWeight.w600),
                          contentPadding: EdgeInsets.zero,
                        ),
                        style:  TextStyle(fontSize: 12,fontFamily: 'Montserrat',
                            color: ThemeProvider.of(context).brightness ==
                                Brightness.light
                                ? head:Colors.white,fontWeight: FontWeight.w600),
                      ),
                    ),
                          ),
                          SizedBox(height: 24,),
                          Row(
                            children: [
                              Text('Attach Images',style: TextStyle(
                                fontFamily: 'Montserrat',color: button_red, fontWeight: FontWeight.w700,fontSize: 12,

                              ),),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left:28.0,right: 28,top: 50,bottom: 40),
                  child: Column(
                    children: [



                      InkWell(
                        onTap: (){
                          showDialog(context: context, builder: (BuildContext context) => Succes_dialogue);
                        },
                        child: Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8)),
                            color: button_green,
                          boxShadow:  [BoxShadow(
                              color: button_green.withOpacity(0.4) ,
                              spreadRadius:4,
                              blurRadius: 36,
                              offset: Offset(3, 3)
                          )],),
                          height: 56,
                          width: double.infinity,

                          child:  Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Get help',style:
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
  String _selectedLocation;


  List<String> _locations = ['Isue 1', 'Issue 2','Issue 3'];

}