import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';


class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  int selectedindex =0 ;
  List sort_item=['Sort','Cuisines','More'];
  List sort_list=[
    'Popularity',
    'Rating: High To Low',
    'Delivery Time',
    'Cost: Low To High',
    'Cost: High To Low '
  ];
  List cuisines_list=[
    'Afghan',
    'American',
    'Andhra',
    'Asian',
    'Awadhi',
    'BBQ',
    'Bakery',
    'Bar Food'
  ];
  List sort_more=[
    'Under 30 Mins',
    'Pure Veg',
    'Previously Ordered',
    'Hygiene Rated',
    'Hyperpure Inside',
    'Safe & Hygienic',
    'Great Offers'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeProvider.of(context).brightness ==
          Brightness.light
          ?Colors.white:Color(0xff131824),

      body: Padding(
        padding:  EdgeInsets.only(top:38),
        child: Column(
          children: <Widget>[
            Container(
              height: 86,
              decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomRight: Radius.circular(32),bottomLeft: Radius.circular(32)),
                color:ThemeProvider.of(context).brightness ==
                    Brightness.light
                    ?  Colors.white:Color(0xff222C44),
                boxShadow: [BoxShadow(
                    color: ThemeProvider.of(context).brightness ==
                        Brightness.light
                        ? button_red.withOpacity(0.05):Color(0xff222C44).withOpacity(0.07) ,

                    blurRadius: 10,
                    offset: Offset(0, 4)
                )],),
              child: Padding(
                padding: const EdgeInsets.only(top:23.0,left: 25,right: 25),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        onTap: (){
                          Navigator.of(context).pop();
                        },
                        child
                            : Icon(Icons.arrow_back,size: 25,color: ThemeProvider.of(context).brightness ==
                            Brightness.light
                            ?head:Colors.white)),
                    Text('Filter',style:  TextStyle(
                      fontFamily: 'Montserrat',color:ThemeProvider.of(context).brightness ==
                        Brightness.light
                        ?head:Colors.white, fontWeight: FontWeight.w700,fontSize: 20,

                    ),),
                    Container(width: 20,)
                  ],
                ),
              ),
            ),
            SizedBox(height: 16,),
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left:00.0),
                    child: Container(
                      color: ThemeProvider.of(context).brightness ==
                          Brightness.light
                          ?Color(0xffF8F9FB):Color(0xff222C44),
                      height: double.infinity,width: 150,
                      child: ListView.builder(
                          itemCount: sort_item.length,
                          itemBuilder: (BuildContext context,int index){
                            return ListTile(
                                tileColor:ThemeProvider.of(context).brightness ==
                                    Brightness.light
                                    ? (selectedindex==index?Colors.white:Color(0xffF8F9FB)):
                                (selectedindex==index?Color(0xff131824):Color(0xff222C44)),
                                onTap: (){
                                  setState(() {
                                    selectedindex=index;
                                  });
                                },
                                title:Padding(
                                  padding: const EdgeInsets.only(left:18.0),
                                  child: Text("${sort_item[index]}",style: TextStyle(
                                    fontFamily: 'Montserrat',color: index==selectedindex?Colors.red:ThemeProvider.of(context).brightness ==
                                      Brightness.light
                                      ?head:Colors.white , fontWeight:
                            FontWeight.w600,fontSize: 16,

                                  ),
                            ),
                                ));
                          }
                      ),
                    ),
                  ),
                  Selected_Sort()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  bool cs=false;
  int sort_index=-1;
  List <String> selected_cuisine=new List();
  List <String> selected_more=new List();
  Widget Selected_Sort(){

    if(selectedindex==0){
      return  Expanded(

        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right:24.0),
              child: ListView.builder(
                  itemCount: sort_list.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context,int index){
                    return Padding(
                      padding: const EdgeInsets.only(bottom:46.0,left: 24),
                      child: InkWell(
                        onTap: (){
                          setState(() {
                            sort_index=index;
                          });
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            /*Radio(value: Text('${sort_list[index]}'), groupValue: 1,
                              onChanged: (val){},
                              focusColor: Colors.red,
                            ),*/
                            Container(
                              height: 14,width: 14,
                              decoration: BoxDecoration(shape: BoxShape.circle,
                                  border: Border.all(color:ThemeProvider.of(context).brightness ==
                                      Brightness.light
                                      ? head:Colors.white,),
                                  color: sort_index!=index?Colors.transparent:(ThemeProvider.of(context).brightness ==
                                      Brightness.light
                                      ? head:Colors.white)
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  sort_index!=index?Container():
                                  Icon(Icons.check,color: ThemeProvider.of(context).brightness ==
                                      Brightness.light
                                      ?Colors.white:head,size: 12,),
                                ],
                              ),
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                              child: Text('${sort_list[index]}',style:
                              TextStyle(
                                fontFamily: 'Montserrat',color: ThemeProvider.of(context).brightness ==
                                  Brightness.light
                                  ?head:Colors.white , fontWeight:
                              FontWeight.w400,fontSize: 16,

                              ),),
                            )
                          ],
                        ),
                      ),
                    );
                  }
              ),
            ),
            //SizedBox(height: 47,),
            Container(
              height: 56,width: 170,
              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8)),
                color: button_green,
                boxShadow: [BoxShadow(
                    color: ThemeProvider.of(context).brightness ==
                        Brightness.light
                        ? button_green.withOpacity(0.3):Color(0xff222C44).withOpacity(0.07) ,

                    blurRadius: 36,
                    offset: Offset(0, 3)
                )],),
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Apply',style:
                  TextStyle(
                    fontFamily: 'Montserrat',color: Colors.white, fontWeight: FontWeight.w400,fontSize: 14,

                  ),),
                ],
              ),
            )
          ],
        ),
      );
    }
    else if(selectedindex==1){
      return  Expanded(
        
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right:24.0),
              child: ListView.builder(
                  itemCount: cuisines_list.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context,int index){
                    return Padding(
                      padding: const EdgeInsets.only(bottom:35.0,left: 24),

                      child: InkWell(
                        onTap: (){
                         setState(() {
                           if(selected_cuisine.contains('${cuisines_list[index]}')){
                             selected_cuisine.remove('${cuisines_list[index]}');
                           }else{
                             selected_cuisine.add('${cuisines_list[index]}');
                           }
                         });
                        },
                        child: Row(
                          children: [

                            Container(
                              height: 14,width: 14,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(2.5)),
                                  border: Border.all(color:ThemeProvider.of(context).brightness ==
                                      Brightness.light
                                      ? head:Colors.white,),
                                  color: !selected_cuisine.contains('${cuisines_list[index]}')?Colors.transparent:(ThemeProvider.of(context).brightness ==
                                      Brightness.light
                                      ? head:Colors.white)
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  !selected_cuisine.contains('${cuisines_list[index]}')?Container():
                                  Icon(Icons.check,color: ThemeProvider.of(context).brightness ==
                                      Brightness.light
                                      ?Colors.white:head,size: 12,),
                                ],
                              ),
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                              child: Text('${cuisines_list[index]}',style: TextStyle(
                                fontFamily: 'Montserrat',color: ThemeProvider.of(context).brightness ==
                                  Brightness.light
                                  ?head:Colors.white , fontWeight:
                              FontWeight.w300,fontSize: 16,

                              ),),
                            )
                          ],
                        ),
                      ),
                    );
                  }
              ),
            ),
           
            Container(
              height: 56,width: 170,
              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8)),
                color: button_green,
                boxShadow: [BoxShadow(
                    color: ThemeProvider.of(context).brightness ==
                        Brightness.light
                        ? button_green.withOpacity(0.3):Color(0xff222C44).withOpacity(0.07) ,

                    blurRadius: 36,
                    offset: Offset(0, 3)
                )],),
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Apply',style:
                  TextStyle(
                    fontFamily: 'Montserrat',color: Colors.white, fontWeight: FontWeight.w400,fontSize: 14,

                  ),),
                ],
              ),
            )
          ],
        ),
      );
    }else{
      return  Expanded(

        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right:24.0),
              child: ListView.builder(
                  itemCount: sort_more.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context,int index){
                    return Padding(
                       padding: const EdgeInsets.only(bottom:35.0,left: 24),
                      child: InkWell(
                        onTap: (){
                          setState(() {
                            if(selected_more.contains('${sort_more[index]}')){
                              selected_more.remove('${sort_more[index]}');
                            }else{
                              selected_more.add('${sort_more[index]}');
                            }
                          });
                        },
                        child: Row(
                          children: [
                            Container(
                              height: 14,width: 14,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(2.5)),
                                  border: Border.all(color:ThemeProvider.of(context).brightness ==
                                      Brightness.light
                                      ? head:Colors.white,),
                                  color: !selected_more.contains('${sort_more[index]}')?Colors.transparent:(ThemeProvider.of(context).brightness ==
                                      Brightness.light
                                      ? head:Colors.white)
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  !selected_more.contains('${sort_more[index]}')?Container():
                                  Icon(Icons.check,color: ThemeProvider.of(context).brightness ==
                                      Brightness.light
                                      ?Colors.white:head,size: 12,),
                                ],
                              ),
                            ),
                            SizedBox(width: 10,),
                            Expanded(child: Text('${sort_more[index]}',style: TextStyle(
                              fontFamily: 'Montserrat',color: ThemeProvider.of(context).brightness ==
                                Brightness.light
                                ?head:Colors.white
                              , fontWeight:
                            FontWeight.w300,fontSize: 16,

                            ),))
                          ],
                        ),
                      ),
                    );
                  }
              ),
            ),

            Container(
              height: 56,width: 170,
              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8)),
                color: button_green,
                boxShadow: [BoxShadow(
                    color: ThemeProvider.of(context).brightness ==
                        Brightness.light
                        ? button_green.withOpacity(0.3):Color(0xff222C44).withOpacity(0.07) ,

                    blurRadius: 36,
                    offset: Offset(0, 3)
                )],),
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Apply',style:
                  TextStyle(
                    fontFamily: 'Montserrat',color: Colors.white, fontWeight: FontWeight.w400,fontSize: 14,

                  ),),
                ],
              ),
            )
          ],
        ),
      );
    }

  }
}