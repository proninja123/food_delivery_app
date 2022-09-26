import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:food_delivery/views/home_ui/bottom_bar_ui/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/app_colors.dart';

class Gallery extends StatefulWidget {
  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery>with SingleTickerProviderStateMixin {
  TabController _tabController;
  int _activeTabIndex = 0;
  void initState() {
    // TODO: implement initState
    _tabController = TabController(length: 3, vsync: this);
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
                padding: const EdgeInsets.only(top:19.0,left: 27,right: 27),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        onTap: (){
                          Navigator.of(context).pop();
                        },
                        child: Icon(Icons.arrow_back,color: ThemeProvider.of(context).brightness ==
                            Brightness.light
                            ? head:Colors.white,size: 28,)),

                    Text('Gallery',style:
                    TextStyle(
                      fontFamily: 'Montserrat',color: ThemeProvider.of(context).brightness ==
                        Brightness.light
                        ? head:Colors.white, fontWeight: FontWeight.w700,fontSize: 20,

                    ),),
                    Row(
                      children: [
                        Icon(Icons.camera_alt,color: ThemeProvider.of(context).brightness ==
                            Brightness.light
                            ? Colors.black:Colors.white,size: 19,),
                        SizedBox(width: 3.6,),
                        Text('Add',style:
                        TextStyle(
                          fontFamily: 'Montserrat',color: ThemeProvider.of(context).brightness ==
                            Brightness.light
                            ? Color(0xff519A9C):Colors.white, fontSize: 14,

                        ),),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:27.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TabBar(

                      indicatorSize: TabBarIndicatorSize.tab,

                      controller: _tabController,

                      indicatorPadding:  EdgeInsets.symmetric(horizontal:10),
                      labelPadding: EdgeInsets.symmetric(horizontal:10),
                      isScrollable: true,
                      unselectedLabelColor: ThemeProvider.of(context).brightness ==
                          Brightness.light
                          ?head:Colors.white,
                      indicatorWeight: 2,
                      indicatorColor: button_red,
                      labelStyle: TextStyle(fontSize: 14,fontFamily: 'Montserrat',
                        color: head,),
                      //labelStyle: TextStyle(color: Colors.red),
                      unselectedLabelStyle: TextStyle(fontSize: 14,fontFamily: 'Montserrat'
                        ,color: button_red,),
                      labelColor: button_red,
                      tabs: [
                        Tab(text: 'Food (10)',),
                        Tab(text: 'Ambience (12)',),
                        Tab(text: 'All (22)',),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                //_tabController.index==1?(list_length+2)*142:(list_length+2)*110,
                height: _tabController.index==2?950:600,
                child: GestureDetector(

                  child: TabBarView(

                      controller: _tabController,
                      children: [
                        SingleChildScrollView(
                          physics: NeverScrollableScrollPhysics(),
                          child: Padding(
                            padding:  EdgeInsets.only(left: 22,right: 22,top: 16),
                            child: Container(
                              child: GridView.builder(

                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: 10,

                                itemBuilder: (BuildContext context, int index) {
                                  return  Padding(
                                    padding:  EdgeInsets.all(5),
                                    child: InkWell(
                                      onTap: (){

                                      },
                                      child: Container(
                                        width:82,
                                        height: 72,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(12)),
                                            image: DecorationImage(image:AssetImage('images/Rectangle 28.png'),fit: BoxFit.cover)
                                        ),

                                      ),
                                    ),
                                  );
                                }, gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                              ),
                            ),
                          ),
                        ),
                        SingleChildScrollView(
                          physics: NeverScrollableScrollPhysics(),
                          child: Padding(
                            padding:  EdgeInsets.only(left: 22,right: 22,top: 16),
                            child: Container(
                              child: GridView.builder(

                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: 12,

                                itemBuilder: (BuildContext context, int index) {
                                  return  Padding(
                                    padding:  EdgeInsets.all(5),
                                    child: InkWell(
                                      onTap: (){

                                      },
                                      child: Container(
                                        width:82,
                                        height: 72,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(12)),
                                            image: DecorationImage(image:AssetImage('images/Rectangle 28.png'),fit: BoxFit.cover)
                                        ),

                                      ),
                                    ),
                                  );
                                }, gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                              ),
                            ),
                          ),
                        ),
                        SingleChildScrollView(
                          physics: NeverScrollableScrollPhysics(),
                          child: Padding(
                            padding:  EdgeInsets.only(left: 22,right: 22,top: 16),
                            child: Container(
                              child: GridView.builder(

                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: 22,

                                itemBuilder: (BuildContext context, int index) {
                                  return  Padding(
                                    padding:  EdgeInsets.all(5),
                                    child: InkWell(
                                      onTap: (){

                                      },
                                      child: Container(
                                        width:82,
                                        height: 72,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(12)),
                                            image: DecorationImage(image:AssetImage('images/Rectangle 28.png'),fit: BoxFit.cover)
                                        ),

                                      ),
                                    ),
                                  );
                                }, gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                              ),
                            ),
                          ),
                        ),

                      ]
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
