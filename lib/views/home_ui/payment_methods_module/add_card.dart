
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';

class AddCard extends StatefulWidget {
  @override
  _AddCardState createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> with SingleTickerProviderStateMixin{
  TabController _tabController;
  int _activeTabIndex = 0;
  void initState() {
    // TODO: implement initState
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_setActiveTabIndex);

  }
  void _setActiveTabIndex() {

    setState(() {
      _activeTabIndex = _tabController.index;


    });

  }
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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: (){
                                Navigator.of(context).pop();
                              },
                              child: Icon(Icons.arrow_back,size: 25,color:ThemeProvider.of(context).brightness ==
                                  Brightness.light
                                  ? head:Colors.white,),
                            ),
                          ],
                        )),
                    Text('Add a card',style: TextStyle(
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

                padding: const EdgeInsets.only(left: 31,right: 31,top: 30),
                child: Container(
                  height: 167,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    boxShadow:  [BoxShadow(
                        color:ThemeProvider.of(context).brightness ==
                            Brightness.light
                            ? Color(0xff0000000F):Color(0xff222C44).withOpacity(0.07) ,

                        blurRadius: 20,
                        offset: Offset(0, 11)
                    )],
                    border: Border.all(color: button_red),
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    color: ThemeProvider.of(context).brightness ==
                        Brightness.light
                        ?Colors.white:Color(0xff222C44)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 17,bottom: 18,left: 30,right: 38),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            height: 18,width: 59,
                            child: Image.asset('images/iconfinder_social_visa_406088.png',
                            color: ThemeProvider.of(context).brightness ==
                                Brightness.light
                                ? Colors.black:Colors.white,)),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('4423 1234 1234 2356',style:
                            TextStyle(
                              letterSpacing: 4.47,
                              fontFamily: 'Montserrat',color: ThemeProvider.of(context).brightness ==
                                Brightness.light
                                ? head:Colors.white, fontWeight: FontWeight.w400,fontSize: 14,

                            ),),
                            SizedBox(height: 16,),
                            Row(
                              children: [
                                Text('Carlos Aries',style:
                                TextStyle(
                                  fontFamily: 'Montserrat',color: ThemeProvider.of(context).brightness ==
                                    Brightness.light
                                    ? head:Colors.white, fontWeight: FontWeight.w600,fontSize: 14,

                                ),),
                                SizedBox(width: 35,),
                                Text('10/24',style:
                                TextStyle(
                                  fontFamily: 'Montserrat',color: ThemeProvider.of(context).brightness ==
                                    Brightness.light
                                    ? head:Colors.white, fontWeight: FontWeight.w600,fontSize: 14,

                                ),),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 57,left: 30)
              ,child: Row(
                children: [
                  Text('Card Details',style: TextStyle(
                        fontFamily: 'Montserrat',color: ThemeProvider.of(context).brightness ==
                          Brightness.light
                          ? head:Colors.white, fontWeight: FontWeight.w700,fontSize: 20,

                      ),),
                ],
              ) ,
              ),
              Padding(
                padding:  EdgeInsets.only(top:15.0,left: 28),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TabBar(

                      indicatorSize: TabBarIndicatorSize.tab,

                      controller: _tabController,


                      isScrollable: true,
                      unselectedLabelColor: ThemeProvider.of(context).brightness ==
                          Brightness.light
                          ?head:Colors.white,
                      indicatorWeight: 1,
                      indicator:BubbleTabIndicator(
                          indicatorHeight: 25,

                          indicatorColor: Color(0xffFFA1A1),tabBarIndicatorSize: TabBarIndicatorSize.tab,indicatorRadius: 12) ,
                      indicatorColor: Colors.transparent,
                      labelStyle: TextStyle(fontSize: 14,fontFamily: 'Montserrat',
                          color: head,fontWeight: FontWeight.w600,),
                      //labelStyle: TextStyle(color: Colors.red),
                      unselectedLabelStyle: TextStyle(fontSize: 14,fontFamily: 'Montserrat'
                          ,color: button_red,fontWeight: FontWeight.w600,),
                      labelColor: button_red,
                      tabs: [
                        Tab(text: 'Credit Card',),
                        Tab(text: 'Debit Card',),
                        ],
                    ),
                  ],
                ),

              ),
              Container(
                //_tabController.index==1?(list_length+2)*142:(list_length+2)*110,
                height: 220,
                child: GestureDetector(

                  child: TabBarView(

                      controller: _tabController,
                      children: [
                       Padding(
                         padding: const EdgeInsets.only(left: 31,right: 31,top: 28),
                         child: Container(
                         child: Column(
                           children: [
                             Container(height: 50,
                               decoration: BoxDecoration(

                                   color:ThemeProvider.of(context).brightness ==
                                       Brightness.light
                                       ? Colors.white:Color(0xff131824),
                                   borderRadius: BorderRadius.all(
                                     Radius.circular(12),
                                   ),
                                   border: Border.all(color: head.withOpacity(0.38))
                               ),
                               child: Column(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                   Padding(
                                     padding: const EdgeInsets.only(left:16.0),
                                     child: TextField(

                                       decoration: InputDecoration(border: InputBorder.none,
                                         hintText: 'Carlos',
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
                             SizedBox(height: 19,),
                             Container(height: 50,
                               decoration: BoxDecoration(

                                   color:ThemeProvider.of(context).brightness ==
                                       Brightness.light
                                       ? Colors.white:Color(0xff131824),
                                   borderRadius: BorderRadius.all(
                                     Radius.circular(12),
                                   ),
                                   border: Border.all(color:  head.withOpacity(0.38))
                               ),
                               child: Column(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                   Padding(
                                     padding: const EdgeInsets.only(left:16.0),
                                     child: TextField(

                                       onTap: (){

                                       },
                                       decoration: InputDecoration(border: InputBorder.none,
                                         hintText: '4423 1234 1234 2356',
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
                             SizedBox(height: 18,),
                             Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 Container(height: 50,width: 162,
                                   decoration: BoxDecoration(

                                        color:ThemeProvider.of(context).brightness ==
                                       Brightness.light
                                       ? Colors.white:Color(0xff131824),
                                       borderRadius: BorderRadius.all(
                                         Radius.circular(12),
                                       ),
                                       border: Border.all(color: head.withOpacity(0.38))
                                   ),
                                   child:  Column(
                                     mainAxisAlignment: MainAxisAlignment.center,
                                     children: [
                                       Padding(
                                         padding: const EdgeInsets.only(left:16.0),
                                         child: TextField(

                                           keyboardType: TextInputType.number,
                                           decoration: InputDecoration(border: InputBorder.none,
                                             hintText: 'CVV',
                                             hintStyle:  TextStyle(
                                               fontFamily: 'Montserrat',color: ThemeProvider.of(context).brightness ==
                                                 Brightness.light
                                                 ? head.withOpacity(0.38):Colors.white.withOpacity(0.37), fontWeight: FontWeight.w400,fontSize: 12,

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
                                 SizedBox(height: 13,),
                                 Container(height: 50,width: 162,
                                   decoration: BoxDecoration(

                                       color:ThemeProvider.of(context).brightness ==
                                           Brightness.light
                                           ? Colors.white:Color(0xff131824),
                                       borderRadius: BorderRadius.all(
                                         Radius.circular(12),
                                       ),
                                       border: Border.all(color:  head.withOpacity(0.38))
                                   ),
                                   child:  Column(
                                     mainAxisAlignment: MainAxisAlignment.center,
                                     children: [
                                       Padding(
                                         padding: const EdgeInsets.only(left:16.0),
                                         child: TextField(

                                           keyboardType: TextInputType.number,
                                           decoration: InputDecoration(border: InputBorder.none,
                                             hintText: 'MM/YY',
                                             hintStyle:  TextStyle(
                                               fontFamily: 'Montserrat',color: ThemeProvider.of(context).brightness ==
                                                 Brightness.light
                                                 ? head.withOpacity(0.38):Colors.white.withOpacity(0.37), fontWeight: FontWeight.w400,fontSize: 12,

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
                               ],
                             )
                           ],
                         ),

                         ),
                       ),
                        Padding(
                          padding: const EdgeInsets.only(left: 31,right: 31,top: 28),
                          child: Container(
                            child: Column(
                              children: [
                                Container(height: 50,
                                  decoration: BoxDecoration(

                                      color:ThemeProvider.of(context).brightness ==
                                          Brightness.light
                                          ? Colors.white:Color(0xff131824),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(12),
                                      ),
                                      border: Border.all(color: head.withOpacity(0.38))
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left:16.0),
                                        child: TextField(

                                          decoration: InputDecoration(border: InputBorder.none,
                                            hintText: 'Carlos',
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
                                SizedBox(height: 19,),
                                Container(height: 50,
                                  decoration: BoxDecoration(

                                      color:ThemeProvider.of(context).brightness ==
                                          Brightness.light
                                          ? Colors.white:Color(0xff131824),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(12),
                                      ),
                                      border: Border.all(color:  head.withOpacity(0.38))
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left:16.0),
                                        child: TextField(

                                          onTap: (){

                                          },
                                          decoration: InputDecoration(border: InputBorder.none,
                                            hintText: '4423 1234 1234 2356',
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
                                SizedBox(height: 18,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(height: 50,width: 162,
                                      decoration: BoxDecoration(

                                          color:ThemeProvider.of(context).brightness ==
                                              Brightness.light
                                              ? Colors.white:Color(0xff131824),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(12),
                                          ),
                                          border: Border.all(color: head.withOpacity(0.38))
                                      ),
                                      child:  Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left:16.0),
                                            child: TextField(

                                              keyboardType: TextInputType.number,
                                              decoration: InputDecoration(border: InputBorder.none,
                                                hintText: 'CVV',
                                                hintStyle:  TextStyle(
                                                  fontFamily: 'Montserrat',color: ThemeProvider.of(context).brightness ==
                                                    Brightness.light
                                                    ? head.withOpacity(0.38):Colors.white.withOpacity(0.37), fontWeight: FontWeight.w400,fontSize: 12,

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
                                    SizedBox(height: 13,),
                                    Container(height: 50,width: 162,
                                      decoration: BoxDecoration(

                                          color:ThemeProvider.of(context).brightness ==
                                              Brightness.light
                                              ? Colors.white:Color(0xff131824),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(12),
                                          ),
                                          border: Border.all(color:  head.withOpacity(0.38))
                                      ),
                                      child:  Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left:16.0),
                                            child: TextField(

                                              keyboardType: TextInputType.number,
                                              decoration: InputDecoration(border: InputBorder.none,
                                                hintText: 'MM/YY',
                                                hintStyle:  TextStyle(
                                                  fontFamily: 'Montserrat',color: ThemeProvider.of(context).brightness ==
                                                    Brightness.light
                                                    ? head.withOpacity(0.38):Colors.white.withOpacity(0.37), fontWeight: FontWeight.w400,fontSize: 12,

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
                                  ],
                                )
                              ],
                            ),

                          ),
                        ),

                      ]
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left:28.0,right: 28,top: 60,bottom: 20),
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
                            Text('Add Card',style:
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


class BubbleTabIndicator extends Decoration {
  final double indicatorHeight;
  final Color indicatorColor;
  final double indicatorRadius;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry insets;
  final TabBarIndicatorSize tabBarIndicatorSize;

  const BubbleTabIndicator({
    this.indicatorHeight: 20.0,
    this.indicatorColor: Colors.greenAccent,
    this.indicatorRadius: 100.0,
    this.tabBarIndicatorSize = TabBarIndicatorSize.label,
    this.padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
    this.insets: const EdgeInsets.symmetric(horizontal: 5.0),
  });

  @override
  Decoration lerpFrom(Decoration a, double t) {
    if (a is BubbleTabIndicator) {
      return new BubbleTabIndicator(
        padding: EdgeInsetsGeometry.lerp(a.padding, padding, t),
        insets: EdgeInsetsGeometry.lerp(a.insets, insets, t),
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  Decoration lerpTo(Decoration b, double t) {
    if (b is BubbleTabIndicator) {
      return new BubbleTabIndicator(
        padding: EdgeInsetsGeometry.lerp(padding, b.padding, t),
        insets: EdgeInsetsGeometry.lerp(insets, b.insets, t),
      );
    }
    return super.lerpTo(b, t);
  }

  @override
  _BubblePainter createBoxPainter([VoidCallback onChanged]) {
    return new _BubblePainter(this, onChanged);
  }
}

class _BubblePainter extends BoxPainter {
  _BubblePainter(this.decoration, VoidCallback onChanged) : super(onChanged);

  final BubbleTabIndicator decoration;

  double get indicatorHeight => decoration.indicatorHeight;
  Color get indicatorColor => decoration.indicatorColor;
  double get indicatorRadius => decoration.indicatorRadius;
  EdgeInsetsGeometry get padding => decoration.padding;
  EdgeInsetsGeometry get insets => decoration.insets;
  TabBarIndicatorSize get tabBarIndicatorSize => decoration.tabBarIndicatorSize;

  Rect _indicatorRectFor(Rect rect, TextDirection textDirection) {
    Rect indicator = padding.resolve(textDirection).inflateRect(rect);

    if (tabBarIndicatorSize == TabBarIndicatorSize.tab) {
      indicator = insets.resolve(textDirection).deflateRect(rect);
    }

    return new Rect.fromLTWH(
      indicator.left,
      indicator.top,
      indicator.width,
      indicator.height,
    );
  }

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration.size != null);
    final Rect rect = Offset(
        offset.dx, (configuration.size.height / 2) - indicatorHeight / 2) &
    Size(configuration.size.width, indicatorHeight);
    final TextDirection textDirection = configuration.textDirection;
    final Rect indicator = _indicatorRectFor(rect, textDirection);
    final Paint paint = Paint();
    paint.color = indicatorColor;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth=1;
    canvas.drawRRect(
        RRect.fromRectAndRadius(indicator, Radius.circular(indicatorRadius)),
        paint);
  }
}
