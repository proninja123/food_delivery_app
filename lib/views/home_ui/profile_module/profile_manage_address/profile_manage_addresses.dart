
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:expandable/expandable.dart';
import '../../../../utils/app_colors.dart';


class ManageAddress extends StatefulWidget {
  @override
  _ManageAddressState createState() => _ManageAddressState();
}

class _ManageAddressState extends State<ManageAddress> {
  final itemsList = List<String>.generate(2, (n) => "List item ${n}");

  ListView generateItemsList() {
    return ListView.builder(
      itemCount: itemsList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(top:37.0,),
          child: Dismissible(
            key: Key(itemsList[index]),
            child: Container(height: 82,width: double.infinity,
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
                  Radius.circular(25),
                ),

              ),
              child: Padding(
                padding: const EdgeInsets.only(left:50.0),
                child: Row(
                  children: [
                    Icon(Icons.home_outlined,color: ThemeProvider.of(context).brightness ==
                        Brightness.light
                        ? head.withOpacity(0.6):Colors.white,size: 30,),
                    SizedBox(width: 18,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Home',style: TextStyle(
                          fontFamily: 'Montserrat',color: ThemeProvider.of(context).brightness ==
                            Brightness.light
                            ? head:Colors.white, fontWeight: FontWeight.w700,fontSize: 14,

                        ),),
                        Text('77th Street. 90 W 22nd St, SD',style: TextStyle(
                          fontFamily: 'Montserrat',color: ThemeProvider.of(context).brightness ==
                            Brightness.light
                            ? head:Colors.white, fontWeight: FontWeight.w500,fontSize: 12,

                        ),),
                      ],
                    )
                  ],
                ),
              ),
            ),
            background: Container(
                height: 82,
                child: slideRightBackground()),

            secondaryBackground: slideLeftBackground(),
            confirmDismiss: (direction) async {}

          ),
        );
      },
    );
  }

  Widget slideRightBackground() {
    return Container(
      height: 82,
      color: Color(0xff5FD388).withOpacity(0.13),
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 20,
            ),

            Text(
              " Edit",
              style: TextStyle(
                fontFamily: 'Montserrat',color: Color(0xff1FB046), fontSize: 14,fontWeight: FontWeight.w700

              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
        alignment: Alignment.centerLeft,
      ),
    );
  }

  Widget slideLeftBackground() {
    return Container(
      color: button_red.withOpacity(0.05),
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[

            Text(
              " Delete",
              style: TextStyle(
                  fontFamily: 'Montserrat',color:button_red, fontSize: 14,fontWeight: FontWeight.w700

              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        alignment: Alignment.centerRight,
      ),
    );
  }
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


                          Text('Manage addresses',style: TextStyle(
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



                  ],),

              ),
              Padding(
                padding:  EdgeInsets.only(top:51,left: 30),
                child: Row(

                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Saved Addresses',style: TextStyle(
                          fontFamily: 'Montserrat',color: ThemeProvider.of(context).brightness ==
                            Brightness.light
                            ? head:Colors.white, fontWeight: FontWeight.w700,fontSize: 20,

                        ),),
                        Text('Swipe Left to Edit/Right to delete',style: TextStyle(
                          fontFamily: 'Montserrat',color: ThemeProvider.of(context).brightness ==
                            Brightness.light
                            ? head:Colors.white, fontSize: 12,

                        ),),
                      ],
                    ),
                  ],
                ),
              ),
              Container(height: 260,child: generateItemsList()),
              Padding(
                padding: EdgeInsets.only(left:28.0,right: 28,top: 180,bottom: 20),
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
                            Text('Add another address',style:
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