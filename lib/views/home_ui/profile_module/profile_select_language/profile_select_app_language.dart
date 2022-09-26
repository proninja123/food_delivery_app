
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../utils/app_colors.dart';


class Language extends StatefulWidget {
  @override
  _LanguageState createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  int selectedindex =0 ;
  List<restaurentlist>rList=new List<restaurentlist>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    rList.add(restaurentlist(image: 'images/Bitmap.png',name: "English"));
    rList.add(restaurentlist(image: 'images/Bitmap Copy.png',name: "Spanish"));
    rList.add(restaurentlist(image: 'images/ger.png',name: "German"));
    rList.add(restaurentlist(image: 'images/b24.png',name: "Swedish"));
    rList.add(restaurentlist(image: 'images/b23.png',name: "Italian"));
  }
  List sort_item=['Sort','Cuisines','More'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeProvider.of(context).brightness ==
          Brightness.light
          ?Colors.white:Color(0xff131824),
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


                                Text('Select Language',style: TextStyle(
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
                      padding: const EdgeInsets.only(top:71.0),
                      child: Container(
                        color:  ThemeProvider.of(context).brightness ==
                            Brightness.light
                            ?Colors.white:Color(0xff131824),

                        height:360,
                        child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: rList.length,
                            itemBuilder: (BuildContext context,int index){
                              return Padding(
                                padding: const EdgeInsets.only(left:19.0,right: 24,bottom: 10),
                                child: InkWell(
                                  onTap: (){
                                    setState(() {
                                      selectedindex=index;
                                    });
                                  },
                                  child: Container(
                                    decoration:  selectedindex==index?BoxDecoration(color:  ThemeProvider.of(context).brightness ==
                                        Brightness.light
                                        ?Colors.white:Color(0xff222C44),borderRadius: BorderRadius.all(
                                        Radius.circular(16)
                                    ),/*color: ThemeProvider.of(context).brightness ==
                                        Brightness.light
                                        ?Colors.white:Color(0xff222C44),*/
                                        boxShadow: [BoxShadow(
                                            color: ThemeProvider.of(context).brightness ==
                                                Brightness.light
                                                ?Colors.red.withOpacity(0.07):Color(0xff222C44).withOpacity(0.07),
                                            spreadRadius:8,
                                            blurRadius: 8,
                                            offset: Offset(1, 2)
                                        )]):BoxDecoration(color:  ThemeProvider.of(context).brightness ==
                                        Brightness.light
                                        ?Colors.white:Color(0xff131824)),
                                    /*color: ThemeProvider.of(context).brightness ==
                            Brightness.light
                            ?Color(0xffF8F9FB):Color(0xff222C44),*/

                                    height: 61,
                                    child:
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(width: 13,),
                                            Image.asset( "${rList[index].image}",
                                              height: 22,width: 22,),
                                            SizedBox(width: 18,),
                                            Text("${rList[index].name}",style: TextStyle(
                                              fontFamily: 'Montserrat',color: ThemeProvider.of(context).brightness ==
                                                Brightness.light
                                                ?head:Colors.white , fontWeight:
                                            FontWeight.w400,fontSize: 14,

                                            ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(right:19.0),
                                          child: Container(
                                            height: 15,width: 15,
                                            decoration: BoxDecoration(
                                              border: Border.all(color: ThemeProvider.of(context).brightness ==
                                                  Brightness.light
                                                  ?head:Colors.white,),
                                              borderRadius: BorderRadius.all(Radius.circular(2)),
                                              color: !(selectedindex==index)?Colors.transparent:(ThemeProvider.of(context).brightness ==
                                                  Brightness.light
                                                  ? head:Colors.white)
                                            ),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                !(selectedindex==index)?Container():
                                                Icon(Icons.check,color: ThemeProvider.of(context).brightness ==
                                                    Brightness.light
                                                    ?Colors.white:head,size: 12,),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }
                        ),
                      ),
                    ),
                  ],
                ),

                Column(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Padding(
                      padding: EdgeInsets.only(left:28.0,right: 28,top: 0),
                      child: InkWell(
                        onTap: (){
                          Navigator.of(context).pop();
                          /* Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SelectLocation()),
                      );*/
                        },
                        child: Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8)),
                            color: button_green,
                            boxShadow: [BoxShadow(
                                color: ThemeProvider.of(context).brightness ==
                                    Brightness.light
                                    ?button_green.withOpacity(0.5):button_green.withOpacity(0.07),
                                 spreadRadius: 10,
                                blurRadius: 20,
                                offset: Offset(3, 3)
                            )],),
                          height: 56,
                          width: double.infinity,

                          child:  Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Apply language',style:
                              TextStyle(
                                fontFamily: 'Montserrat',color: Colors.white, fontWeight: FontWeight.w400,fontSize: 14,

                              ),),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 50,),
                  ],
                ),




              ],
            ),
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