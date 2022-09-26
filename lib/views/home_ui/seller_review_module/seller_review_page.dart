import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';

import '../../../utils/app_colors.dart';



class ReviewsPage extends StatefulWidget {

  @override
  _ReviewsPageState createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Column(
        children: [

          Padding(
            padding:  EdgeInsets.only(left:23,top: 25),
            child: Row(
              children: [
                Text('4.5',style: TextStyle(
                    fontSize: 40,fontFamily: 'Montserrat',

                    color: ThemeProvider.of(context).brightness ==
                        Brightness.light
                        ? Color(0xff1D2C35):Colors.white,fontWeight: FontWeight.w700,),),
                SizedBox(width:10 ,),
                SvgPicture.asset(
                  'images/svg/star_20210401_174429079.svg',
                  height: 17.5,width: 18.5,
                  matchTextDirection: true,
                ),
                SvgPicture.asset(
                  'images/svg/star_20210401_174429079.svg',
                  height: 17.5,width: 18.5,
                  matchTextDirection: true,
                ),
                SvgPicture.asset(
                  'images/svg/star_20210401_174429079.svg',
                  height: 17.5,width: 18.5,
                  matchTextDirection: true,
                ),
                SvgPicture.asset(
                  'images/svg/star_20210401_174429079.svg',
                  height: 17.5,width: 18.5,
                  matchTextDirection: true,
                ),
                SvgPicture.asset(
                  'images/svg/star_20210401_174429079.svg',
                  height: 17.5,width: 18.5,
                  matchTextDirection: true,
                ),

              ],
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(left:25,top:0),
            child: Row(
              children: [
                Text('284 reviews on Google',style: TextStyle(
                  fontSize: 14,fontFamily: 'Montserrat',

                  color: ThemeProvider.of(context).brightness ==
                      Brightness.light
                      ? head:Colors.white,),),
              ],
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(left:23,top: 22,right:23 ),
            child: Row(
              children: [
                Container(
                  width:MediaQuery.of(context).size.width*0.3,
                  child: Text('Cleanliness',style:   TextStyle(
                    fontSize: 14,fontFamily: 'Montserrat',

                    color: ThemeProvider.of(context).brightness ==
                        Brightness.light
                        ? head:Colors.white,fontWeight: FontWeight.w400,),),
                ),
                Expanded(child: MySeparator(color: ThemeProvider.of(context).brightness ==
               Brightness.light
               ?Colors.black:Colors.white, height: 0.3,)),
                Padding(
                  padding:  EdgeInsets.only(left:12),
                  child: Text('9.0',style: TextStyle(
                    fontSize: 14,fontFamily: 'Montserrat',

                    color: ThemeProvider.of(context).brightness ==
                        Brightness.light
                        ? head:Colors.white,fontWeight: FontWeight.w700,),),
                ),
              ],
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(left:23,top: 10,right:23 ),
            child: Row(
              children: [
                Container(
                  width:MediaQuery.of(context).size.width*0.3,
                  child: Text('Comfort',style:  TextStyle(
                    fontSize: 14,fontFamily: 'Montserrat',

                    color: ThemeProvider.of(context).brightness ==
                        Brightness.light
                        ? head:Colors.white,fontWeight: FontWeight.w400,),),
                ),
                Expanded(child: MySeparator(color:ThemeProvider.of(context).brightness ==
                    Brightness.light
                    ?Colors.black:Colors.white, height: 0.3,)),
                Padding(
                  padding:  EdgeInsets.only(left:12),
                  child: Text('8.9',style:  TextStyle(
                    fontSize: 14,fontFamily: 'Montserrat',

                    color: ThemeProvider.of(context).brightness ==
                        Brightness.light
                        ? head:Colors.white,fontWeight: FontWeight.w700,),),
                ),
              ],
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(left:23,top: 10,right:23 ),
            child: Row(
              children: [
                Container(
                  width:MediaQuery.of(context).size.width*0.3,
                  child: Text('Location',style:  TextStyle(
                    fontSize: 14,fontFamily: 'Montserrat',

                    color: ThemeProvider.of(context).brightness ==
                        Brightness.light
                        ? head:Colors.white,fontWeight: FontWeight.w400,),),
                ),
                Expanded(child: MySeparator(color: ThemeProvider.of(context).brightness ==
                    Brightness.light
                    ?Colors.black:Colors.white, height: 0.3,)),
                Padding(
                  padding:  EdgeInsets.only(left:12),
                  child: Text('9.0',style:  TextStyle(
                    fontSize: 14,fontFamily: 'Montserrat',

                    color: ThemeProvider.of(context).brightness ==
                        Brightness.light
                        ? head:Colors.white,fontWeight: FontWeight.w700,),),
                ),
              ],
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(left:23,top: 10,right:23 ),
            child: Row(
              children: [
                Container(
                  width:MediaQuery.of(context).size.width*0.4,
                  child: Text('Value for money',style:  TextStyle(
                    fontSize: 14,fontFamily: 'Montserrat',

                    color: ThemeProvider.of(context).brightness ==
                        Brightness.light
                        ? head:Colors.white,fontWeight: FontWeight.w400,),),
                ),
                Expanded(child: MySeparator(color: ThemeProvider.of(context).brightness ==
                    Brightness.light
                    ?Colors.black:Colors.white, height: 0.3,)),
                Padding(
                  padding:  EdgeInsets.only(left:12),
                  child: Text('8.5',style:  TextStyle(
                    fontSize: 14,fontFamily: 'Montserrat',

                    color: ThemeProvider.of(context).brightness ==
                        Brightness.light
                        ? head:Colors.white,fontWeight: FontWeight.w700,),),
                ),
              ],
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(left:23,top: 10,right:23 ),
            child: Row(
              children: [
                Container(
                  width:MediaQuery.of(context).size.width*0.3,
                  child: Text('Staff',style:  TextStyle(
                    fontSize: 14,fontFamily: 'Montserrat',

                    color: ThemeProvider.of(context).brightness ==
                        Brightness.light
                        ? head:Colors.white,fontWeight: FontWeight.w400,),),
                ),
                Expanded(child: MySeparator(color: ThemeProvider.of(context).brightness ==
                    Brightness.light
                    ?Colors.black:Colors.white, height: 0.3,)),
                Padding(
                  padding:  EdgeInsets.only(left:12),
                  child: Text('9.5',style:  TextStyle(
                    fontSize: 14,fontFamily: 'Montserrat',

                    color: ThemeProvider.of(context).brightness ==
                        Brightness.light
                        ? head:Colors.white,fontWeight: FontWeight.w700,),),
                ),
              ],
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(left:28,right: 28,top: 35,bottom:10 ),
            child: Container(
                  height: 56,
              decoration: new BoxDecoration(
                color:  Color(0xff71B24D),
                borderRadius: new BorderRadius.all(
                  Radius.circular(8),
                ),),
              child: FlatButton(

                  onPressed: ()async{


                  },child: Center(
                child: Text('Write a review',style: TextStyle(
                  fontSize: 14,fontFamily: 'Montserrat',

                  color: Colors.white,fontWeight: FontWeight.w400,),),
              )),
            ),
          ),

          Padding(
            padding:  EdgeInsets.only(left:24,top: 45,bottom: 10),
            child: Row(
              children: [
                Text('What guests are saying',style: TextStyle(
                  fontSize: 16,fontFamily: 'Montserrat',

                  color: ThemeProvider.of(context).brightness ==
                      Brightness.light
                      ? head:Colors.white,fontWeight: FontWeight.w700,),),
              ],
            ),
          ),
          SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Container(
              child: ListView.builder(
                padding: EdgeInsets.only(top: 15),
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                      onTap: (){

                      },
                      child: Padding(
                        padding:  EdgeInsets.only(left:14,right: 14,top: 0,bottom: 20),

                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
                          color: ThemeProvider.of(context).brightness ==
                              Brightness.light
                              ? Colors.white:Color(0xff222C44),

                          child: Column(

                            children: [

                              Padding(
                                padding:  EdgeInsets.only( left: 22,right: 22,top: 22 ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width:34,
                                          height: 34,
                                          decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.blue[300]),
                                        ),
                                        SizedBox(width: 10,),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Carlos Aries',style: TextStyle(
                                              fontSize: 14,fontFamily: 'Montserrat',

                                              color: ThemeProvider.of(context).brightness ==
                                                  Brightness.light
                                                  ? head:Colors.white,fontWeight: FontWeight.w700,),),
                                            SizedBox(height: 2,),
                                            Row(
                                              children: [
                                                SvgPicture.asset(
                                                  'images/svg/star_20210401_174429079.svg',
                                                  height: 10,width: 10,
                                                  matchTextDirection: true,
                                                ),
                                                SvgPicture.asset(
                                                  'images/svg/star_20210401_174429079.svg',
                                                  height: 10,width: 10,
                                                  matchTextDirection: true,
                                                ),
                                                SvgPicture.asset(
                                                  'images/svg/star_20210401_174429079.svg',
                                                  height: 10,width: 10,
                                                  matchTextDirection: true,
                                                ),
                                                SvgPicture.asset(
                                                  'images/svg/star_20210401_174429079.svg',
                                                  height: 10,width: 10,
                                                  matchTextDirection: true,
                                                ),
                                                SvgPicture.asset(
                                                  'images/svg/star_20210401_174429079.svg',
                                                  height: 10,width: 10,
                                                  matchTextDirection: true,
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),

                                    Text('22 jan 21',style: TextStyle(
                                      fontSize: 14,fontFamily: 'Montserrat',

                                      color: ThemeProvider.of(context).brightness ==
                                          Brightness.light
                                          ? head.withOpacity(0.76):Colors.white.withOpacity(0.76),fontWeight: FontWeight.w400,),),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:  EdgeInsets.only(left: 21,right: 37,bottom: 10,top: 17 ),
                                child: Row(children: [
                                  Expanded(
                                    child: Text('Pizza Hut is all time favourite place. Ambience is good and spacious.'
                                        ' Prices are standard across. This one is just on main road.',style: TextStyle(
                                      fontSize: 14,fontFamily: 'Montserrat',

                                      color: ThemeProvider.of(context).brightness ==
                                          Brightness.light
                                          ? head.withOpacity(0.5):Colors.white.withOpacity(0.5),fontWeight: FontWeight.w400,),),
                                  ),

                                ],),
                              ),
                              Padding(
                                padding: EdgeInsets.only( top:8 ,bottom: 29,left: 22,right: 22),
                                child: Row(children: [
                                  Container(
                                    width:72,
                                    height: 72,
                                    decoration: BoxDecoration(image: DecorationImage(image:AssetImage('images/Background (2).png'),fit: BoxFit.cover)
                                    ,borderRadius: BorderRadius.all(Radius.circular(8))),
                                  ),
                                  SizedBox(width:  8,),
                                  Container(
                                    width:72,
                                    height:72,
                                    decoration: BoxDecoration(image: DecorationImage(image:AssetImage('images/Background (2).png'),fit: BoxFit.cover),borderRadius: BorderRadius.all(Radius.circular(8))),
                                  ),
                                  SizedBox(width:  8,),
                                  Container(
                                    width:72,
                                    height: 72,
                                    decoration: BoxDecoration(image: DecorationImage(image:AssetImage('images/Background (2).png'),fit: BoxFit.cover),borderRadius: BorderRadius.all(Radius.circular(8))),
                                  ),
                                ],),
                              )

                            ],
                          ),

                        ),

                      ) );
                },
              ),
            ),
          ),



        ],
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
        final dashWidth = 3.0;
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