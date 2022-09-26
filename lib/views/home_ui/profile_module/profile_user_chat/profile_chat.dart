
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../utils/app_colors.dart';


class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children: <Widget>[
          Column(
            children: [
              SizedBox(height: 24,),
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


                          Text('Chat with Comiida',style: TextStyle(
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
              SizedBox(height: 19,),
              Expanded(

                child: ListView.builder(

                  itemCount: messages.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.only(top: 10,bottom: 10),
                  physics: AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index){
                    return
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 24.0),
                        child: new Row(

                          children: messages[index].messageType == "receiver"?getReceivedMessageLayout(index):getSentMessageLayout(index),

                        ),
                      );
                    /*Container(
                      padding: EdgeInsets.only(left: 14,right: 14,top: 10,bottom: 10),
                      child: Align(
                        alignment: (messages[index].messageType == "receiver"?Alignment.topLeft:Alignment.topRight),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: (messages[index].messageType  == "receiver"?Colors.grey.shade200:Colors.blue[200]),
                          ),
                          padding: EdgeInsets.all(16),
                          child: Expanded(
                              child:Row(
                                mainAxisAlignment: (messages[index].messageType  == "receiver"?MainAxisAlignment.start:MainAxisAlignment.end),
                                children: [
                                  Text(messages[index].messageContent, style: TextStyle(fontSize: 15,),),
                                ],
                              )),
                        ),
                      ),
                    );*/
                  },
                ),
              ),
            ],
          ),

          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding:  EdgeInsets.only(left: 23,bottom: 10,top: 10,right: 34),
              child: Container(
                padding: EdgeInsets.only(left: 12,right: 12),
                height: 49,
                width: double.infinity,

                decoration: BoxDecoration(
                    color: ThemeProvider.of(context).brightness ==
                        Brightness.light
                        ?Color(0xffF8F9FA):Color(0xff131824),
                  borderRadius: BorderRadius.all(Radius.circular(8),
                  ),border: Border.all(color: ThemeProvider.of(context).brightness ==
                    Brightness.light
                    ?Color(0xff535B720F).withOpacity(0.1):Colors.white.withOpacity(0.5))
                )
                ,
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color:ThemeProvider.of(context).brightness ==
                              Brightness.light
                              ? Color(0xffF8F9FA):Color(0xff131824),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child:  Icon(Icons.emoji_emotions_outlined, color: head, size: 28, ),
                      ),
                    ),
                    SizedBox(width: 15,),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "Write message...",
                            hintStyle: TextStyle(
                              fontFamily: 'Montserrat',color: ThemeProvider.of(context).brightness ==
                                Brightness.light
                                ?head:Colors.white, fontWeight: FontWeight.w700,fontSize: 12,

                            ),

                            border: InputBorder.none
                        ),
                        style: TextStyle(
                          fontFamily: 'Montserrat',color: ThemeProvider.of(context).brightness ==
                            Brightness.light
                            ?head:Colors.white, fontWeight: FontWeight.w700,fontSize: 12,

                        ),
                      ),
                    ),
                    SizedBox(width: 15,),
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color:ThemeProvider.of(context).brightness ==
                            Brightness.light
                            ? Color(0xffF8F9FA):Color(0xff131824),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child:  Icon(Icons.send, color: button_green, size: 28, ),
                    ),
                    SizedBox(width: 15,),
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color:ThemeProvider.of(context).brightness ==
                            Brightness.light
                            ? Color(0xffF8F9FA):Color(0xff131824),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child:  Icon(Icons.keyboard_voice_sharp, color: head, size: 28, ),
                    ),
                  ],

                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  List<Widget> getSentMessageLayout(int i) {
    return <Widget>[
      new Expanded(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[

            new Container(

              width: 197,

              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                color:ThemeProvider.of(context).brightness ==
                    Brightness.light
                    ? Color(0xffF7F5FD):Color(0xff222C44),
              ),
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left:16.0,right: 7,top: 13,bottom: 13),
                    child: Text(messages[i].messageContent,
                    style: TextStyle(
                      fontFamily: 'Montserrat',color:ThemeProvider.of(context).brightness ==
                        Brightness.light
                        ? head:Colors.white, fontWeight: FontWeight.w700,fontSize: 12,

                    ),),
                  ),
                ],
              ),
            ),
            Container(
              width: 194,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 7,),
                  Text('10.21 AM',style: TextStyle(
                    fontFamily: 'Montserrat',color: Color(0xffBABABA), fontSize: 10,

                  ),),
                ],
              ),
            ),

          ],
        ),
      ),
      new Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left:8.0,right: 30),
            child: new Container(
                height: 37,width: 37,decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('images/person.png',),fit: BoxFit.cover,
              )
            ),),
          ),
        ],
      ),
    ];
  }

  List<Widget> getReceivedMessageLayout(int i) {
     return <Widget>[
      new Column(
       crossAxisAlignment: CrossAxisAlignment.start,

        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left:31.0,right: 8),
            child: new Container(

              height: 37,width: 37,decoration: BoxDecoration(
                shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: Image.asset('images/Group 3.png',height: 17,width: 24,),),
          ),
         ],
       ),
       new Expanded(
         child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: <Widget>[

            new Container(
              width: 203,

              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                color: ThemeProvider.of(context).brightness ==
                    Brightness.light
                    ?Color(0xffFFECEC):head,
              ),
              child:  Padding(
                padding: const EdgeInsets.only(left:16.0,right: 13,top: 11,bottom: 10),
                child: new Text(messages[i].messageContent,style: TextStyle(
                  fontFamily: 'Montserrat',color:ThemeProvider.of(context).brightness ==
                    Brightness.light
                    ? head:Colors.white, fontWeight: FontWeight.w700,fontSize: 12,

                ),),
              ),
            ),
            SizedBox(height: 7,),
            Text('10.21 AM',style: TextStyle(
              fontFamily: 'Montserrat',color: Color(0xffBABABA), fontSize: 10,

            ),),
           ],
         ),
       ),
     ];
   }
  List<ChatMessage> messages = [
    ChatMessage(messageContent: "Hey Jonathan, How may I assist you today?", messageType: "receiver"),
    ChatMessage(messageContent: "Chat with an agent", messageType: "sender"),
    ChatMessage(messageContent: "Sure! We're connecting you to an agent. Wait time : 3mins", messageType: "receiver"),

    ChatMessage(messageContent: "You're now talking to our agent, Michael. How may I help you?", messageType: "receiver"),


  ];
}
class ChatMessage{
  String messageContent;
  String messageType;
  ChatMessage({@required this.messageContent, @required this.messageType});
}