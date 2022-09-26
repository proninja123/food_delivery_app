
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:expandable/expandable.dart';
import '../../../../utils/app_colors.dart';


class FAQS extends StatefulWidget {
  @override
  _FAQSState createState() => _FAQSState();
}

class _FAQSState extends State<FAQS> {

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


                          Text('FAQs',style: TextStyle(
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
                padding: const EdgeInsets.only(top:42.0,left: 30.5,right: 29.5),
                child: ExpandablePanel(
                  header: Text('What is Comiida customer\ncare number?',style: TextStyle(
                    fontFamily: 'Montserrat',color: ThemeProvider.of(context).brightness ==
                      Brightness.light
                      ? head:Colors.white, fontWeight: FontWeight.w700,fontSize: 14,

                  ),),
                  collapsed: Text('', softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis,),
                  expanded: Text('\nIf you choose to use our Service, then you agree to the collection and use of information in '
                      'relation to this policy. The Personal Information that we collect is used for providing and improving the Service.'
                      ' We will not use or share your information with anyone except as described in this Privacy Policy.', softWrap: true,style:
                  TextStyle(
                      fontFamily: 'Montserrat',color: ThemeProvider.of(context).brightness ==
                      Brightness.light
                      ? head:Colors.white, fontSize: 12,height: 1.8

                  ),),
                ),
              ),
              Divider(color: head.withOpacity(0.1),),
              Padding(
                padding: const EdgeInsets.only(top:35.0,left: 30.5,right: 29.5),
                child: ExpandablePanel(
                  header: Text('I entered the wrong CVV, why did my\ntrasaction still go through?',style: TextStyle(
                    fontFamily: 'Montserrat',color: ThemeProvider.of(context).brightness ==
                      Brightness.light
                      ? head:Colors.white, fontWeight: FontWeight.w700,fontSize: 14,

                  ),),
                  collapsed: Text('', softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis,),
                  expanded: Text('\nIf you choose to use our Service, then you agree to the collection and use of information in '
                      'relation to this policy. The Personal Information that we collect is used for providing and improving the Service.'
                      ' We will not use or share your information with anyone except as described in this Privacy Policy.', softWrap: true,style:
                  TextStyle(
                    fontFamily: 'Montserrat',color: ThemeProvider.of(context).brightness ==
                      Brightness.light
                      ? head:Colors.white, fontSize: 12,height: 1.8

                  ),),

                ),
              ),
              Divider(color: head.withOpacity(0.1),),
              Padding(
                padding: const EdgeInsets.only(top:35.0,left: 30.5,right: 29.5),
                child: ExpandablePanel(
                  header: Text('I want to provide feedback',style: TextStyle(
                    fontFamily: 'Montserrat',color: ThemeProvider.of(context).brightness ==
                      Brightness.light
                      ? head:Colors.white, fontWeight: FontWeight.w700,fontSize: 14,

                  ),),
                  collapsed: Text('', softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis,),
                  expanded: Text('\nIf you choose to use our Service, then you agree to the collection and use of information in '
                      'relation to this policy. The Personal Information that we collect is used for providing and improving the Service.'
                      ' We will not use or share your information with anyone except as described in this Privacy Policy.', softWrap: true,style:
                  TextStyle(
                      fontFamily: 'Montserrat',color: ThemeProvider.of(context).brightness ==
                      Brightness.light
                      ? head:Colors.white, fontSize: 12,height: 1.8

                  ),),
                ),
              ),
            Divider(color: head.withOpacity(0.1),),

              Padding(
                padding: const EdgeInsets.only(top:35.0,left: 30.5,right: 29.5),
                child: ExpandablePanel(
                  header: Text('How can I edit my order',style: TextStyle(
                    fontFamily: 'Montserrat',color: ThemeProvider.of(context).brightness ==
                      Brightness.light
                      ? head:Colors.white, fontWeight: FontWeight.w700,fontSize: 14,

                  ),),
                  collapsed: Text('', softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis,),
                  expanded: Text('\nIf you choose to use our Service, then you agree to the collection and use of information in '
                      'relation to this policy. The Personal Information that we collect is used for providing and improving the Service.'
                      ' We will not use or share your information with anyone except as described in this Privacy Policy.', softWrap: true,style:
                  TextStyle(
                      fontFamily: 'Montserrat',color: ThemeProvider.of(context).brightness ==
                      Brightness.light
                      ? head:Colors.white, fontSize: 12,height: 1.8

                  ),),
                ),
              )


            ],
          ),
        ),
      ),
    );
  }

}