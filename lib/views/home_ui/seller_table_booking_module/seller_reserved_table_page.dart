import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';

import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

import '../../../utils/app_colors.dart';


class ReserveTable extends StatefulWidget {
  @override
  _ReserveTableState createState() => _ReserveTableState();
}

class _ReserveTableState extends State<ReserveTable> {
  @override
  void initState() {
    // TODO: implement initState
    _calendarController = CalendarController();
    setInitialDropDate();
    super.initState();
  }
  CalendarController _calendarController;
  int guest_num=1;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          Padding(
            padding:  EdgeInsets.only(left:24,top: 35),
            child: Row(
              children: [
                Text('Book your seat now!',style: TextStyle(
                  fontFamily: 'Montserrat',color: ThemeProvider.of(context).brightness ==
                    Brightness.light
                    ? head:Colors.white, fontWeight: FontWeight.w700,fontSize: 18,

                ),),
              ],
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(left:23,top: 30),
            child: Row(
              children: [
                Text('Date',style: TextStyle(
                  fontFamily: 'Montserrat',color: ThemeProvider.of(context).brightness ==
                    Brightness.light
                    ? head:Colors.white, fontWeight: FontWeight.w700,fontSize: 12,

                ),),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.only(left:23,right: 23,top: 12),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    for(int i=0; i < 6; i++)
                      dateWidget(i),
                  ],
                ),
                SizedBox(width: 12,),
                Container(
                  height: 52,width: 52,

                  decoration: BoxDecoration(
                      color: head.withOpacity(0.3),borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: InkWell(
                    onTap: (){

                      _showTableCalenderPopup(context);
                      //_showDatePopup(context);
                    },
                    child: Icon(Icons.date_range,size: 40,color: head,),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(left:24,top: 28),
            child: Row(
              children: [
                Text('Time Slot',style: TextStyle(
                  fontFamily: 'Montserrat',color: ThemeProvider.of(context).brightness ==
                    Brightness.light
                    ? head:Colors.white, fontWeight: FontWeight.w700,fontSize: 12,

                ),),
              ],
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(left:24,right: 24,top: 12),
            child: Column(

              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      //width: ScreenUtil().setWidth(250),
                      child: Wrap(
                        children: List.generate(
                          period_list.length,
                              (index) {
                            return Padding(
                              padding: const EdgeInsets.only(right:8.0),
                              child: FilterChip(
                                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 1),
                                backgroundColor:selected_period==index?head: ThemeProvider.of(context).brightness ==
                                    Brightness.light
                                    ?Colors.white:Color(0xff131824),
                                selectedColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(color:  ThemeProvider.of(context).brightness ==
                                        Brightness.light
                                        ?Color(0xffF0F1F5):selected_period==index?Color(0xff131824):Color(0xffF0F1F5)),
                                    borderRadius: BorderRadius.all(Radius.circular(4))
                                ),
                                label: Text('${period_list[index]}',style:TextStyle(
                                  fontFamily: 'Montserrat',color: selected_period==index? Colors.white:ThemeProvider.of(context).brightness ==
                                    Brightness.light
                                    ?head:Colors.white, fontWeight: FontWeight.w600,fontSize: 12,

                                ),),
                                onSelected: (val) {
                                  setState(() {
                                    selected_period=index;
                                  });
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                  ],),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      //width: ScreenUtil().setWidth(250),
                      child: Wrap(
                        children: List.generate(
                          time_list.length,
                              (index) {
                            return Padding(
                              padding: const EdgeInsets.only(right:8.0),
                              child: FilterChip(
                                padding: EdgeInsets.symmetric(horizontal: 17,vertical: 1),
                                backgroundColor:selected_time==index?head:ThemeProvider.of(context).brightness ==
                                    Brightness.light
                                    ? Colors.white:Color(0xff131824),
                                selectedColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(color: ThemeProvider.of(context).brightness ==
                                        Brightness.light
                                        ?Color(0xffF0F1F5):selected_time==index?Color(0xff131824):Color(0xffF0F1F5)),
                                    borderRadius: BorderRadius.all(Radius.circular(4))
                                ),
                                label: Text('${time_list[index]}',style: TextStyle(
                                  fontFamily: 'Montserrat',color: selected_time==index? Colors.white:ThemeProvider.of(context).brightness ==
                                    Brightness.light
                                    ?head:Colors.white, fontWeight: FontWeight.w600,fontSize: 12,

                                ),),
                                onSelected: (val) {
                                  setState(() {
                                    selected_time=index;
                                  });
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                  ],),

              ],
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(top: 41,left: 24,right: 30),
            child: Row(

              //crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,


                      children: [

                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Text('Guests',style: TextStyle(
                            fontFamily: 'Montserrat',color: ThemeProvider.of(context).brightness ==
                              Brightness.light
                              ? head:Colors.white, fontWeight: FontWeight.w700,fontSize: 12,

                          ),),
                        ),

                      ],
                    ),

                  ],),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(

                      children: [
                        InkWell(
                            onTap: (){
                              if(guest_num!=0){
                                setState(() {
                                  guest_num=guest_num-1;
                                });
                              }
                            },

                            child: Container(
                            width: 32,
                            height: 32,

                            decoration: BoxDecoration(color: ThemeProvider.of(context).brightness ==
                                Brightness.light
                                ?Color(0xffF8F9FA):head,borderRadius:BorderRadius.all( Radius.circular(8))),
                            child: Center(child: Text('-',style:TextStyle(
                              fontFamily: 'Montserrat',color:  ThemeProvider.of(context).brightness ==
                                Brightness.light
                                ?Colors.black:Colors.white,fontSize: 14,

                            ),)))),
                        SizedBox(width: 12,),
                        Text('$guest_num',style:  TextStyle(
                          fontFamily: 'Montserrat',color:  ThemeProvider.of(context).brightness ==
                            Brightness.light
                            ?Colors.black:Colors.white,fontSize: 14,

                        ),),
                        SizedBox(width: 12,),
                        InkWell(

                            onTap: (){
                              setState(() {
                                guest_num=guest_num+1;
                              });
                            },
                            child: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(color: ThemeProvider.of(context).brightness ==
                                Brightness.light
                                ?Color(0xffF8F9FA):head,borderRadius:BorderRadius.all( Radius.circular(8))),

                            child: Center(child: Text('+',style: TextStyle(
                              fontFamily: 'Montserrat',color:  ThemeProvider.of(context).brightness ==
                                Brightness.light
                                ?Colors.black:Colors.white,fontSize: 14,

                            ),)))),
                      ],
                    ),

                  ],
                )


              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16,top: 22,right: 20),
            child: Container(
              decoration:  BoxDecoration(
                color: ThemeProvider.of(context).brightness ==
                    Brightness.light
                    ?Colors.white:Color(0xff222C44),
                borderRadius: BorderRadius.all( Radius.circular(24)),
                boxShadow: [BoxShadow(
                    color:ThemeProvider.of(context).brightness ==
                        Brightness.light
                        ? Colors.black.withOpacity(0.05):Color(0xff222C44).withOpacity(0.07) ,
                    spreadRadius:8,
                    blurRadius: 8,
                    offset: Offset(3, 3)
                )],
              ),

              child: Column(
                children: [
                  Padding(
                    padding:  EdgeInsets.only(left:27,top: 15),
                    child: Row(
                      children: [
                        Text('Contact Info',style: TextStyle(
                          fontFamily: 'Montserrat',color: ThemeProvider.of(context).brightness ==
                            Brightness.light
                            ? head:Colors.white, fontWeight: FontWeight.w700,fontSize: 16,

                        ),),
                      ],
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left: 27,right: 52,top: 24,bottom: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: (MediaQuery.of(context).size.width-127)/2,
                          child: TextField(

                            decoration: InputDecoration(
                              border: UnderlineInputBorder(borderSide: BorderSide(color: ThemeProvider.of(context).brightness ==
                                  Brightness.light
                                  ?Colors.grey:Colors.white)),

                              hintText: 'Enter Name',
                              hintStyle:  TextStyle(
                                fontFamily: 'Montserrat',color: ThemeProvider.of(context).brightness ==
                                  Brightness.light
                                  ? head.withOpacity(0.45):Colors.white.withOpacity(0.45), fontSize: 12,

                              ),

                              contentPadding: EdgeInsets.all(0),
                            ),
                            style:  TextStyle(
                              fontFamily: 'Montserrat',color: ThemeProvider.of(context).brightness ==
                                Brightness.light
                                ? head:Colors.white, fontSize: 12,

                            ),
                          ),
                        ),
                        Container(
                          width: (MediaQuery.of(context).size.width-127)/2,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(

                              border: UnderlineInputBorder(borderSide: BorderSide(color: ThemeProvider.of(context).brightness ==
                                  Brightness.light
                                  ?Colors.grey:Colors.white)),

                              hintText: 'Enter Mobile',
                              hintStyle:  TextStyle(
                                fontFamily: 'Montserrat',color: ThemeProvider.of(context).brightness ==
                                  Brightness.light
                                  ? head.withOpacity(0.45):Colors.white.withOpacity(0.45), fontSize: 12,

                              ),

                              contentPadding: EdgeInsets.all(0),
                            ),
                            style:  TextStyle(
                              fontFamily: 'Montserrat',color: ThemeProvider.of(context).brightness ==
                                Brightness.light
                                ? head:Colors.white, fontSize: 12,

                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding:  EdgeInsets.only(left: 27,right: 55,top: 10,bottom: 0),
                    child: TextField(
                     keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(borderSide: BorderSide(color: ThemeProvider.of(context).brightness ==
                            Brightness.light
                            ?Colors.grey:Colors.white)),

                        hintText: 'Enter Email (optional)',
                        hintStyle:  TextStyle(
                          fontFamily: 'Montserrat',color: ThemeProvider.of(context).brightness ==
                            Brightness.light
                            ? head.withOpacity(0.45):Colors.white.withOpacity(0.45), fontSize: 12,

                        ),

                        contentPadding: EdgeInsets.all(0),
                      ),
                      style:  TextStyle(
                        fontFamily: 'Montserrat',color: ThemeProvider.of(context).brightness ==
                          Brightness.light
                          ? head:Colors.white, fontSize: 12,

                      ),
                    ),
                  ),

                  Padding(
                    padding:  EdgeInsets.only(left: 27,right: 28,top: 10,bottom: 24),
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(borderSide: BorderSide(color: ThemeProvider.of(context).brightness ==
                            Brightness.light
                            ?Colors.grey:Colors.white)),

                        hintText: 'Additional Notes',
                        hintStyle:  TextStyle(
                          fontFamily: 'Montserrat',color: ThemeProvider.of(context).brightness ==
                            Brightness.light
                            ? head.withOpacity(0.45):Colors.white.withOpacity(0.45), fontSize: 12,

                        ),

                        contentPadding: EdgeInsets.all(0),
                      ),
                      style:  TextStyle(
                        fontFamily: 'Montserrat',color: ThemeProvider.of(context).brightness ==
                          Brightness.light
                          ? head:Colors.white, fontSize: 12,

                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),

          Padding(
            padding:  EdgeInsets.only(left:28,right: 28,top: 47,bottom:10 ),
            child: Container(
              height: 56,
              decoration: new BoxDecoration(
                color:  button_green,
                borderRadius: new BorderRadius.all(
                  Radius.circular(8),
                ),
              boxShadow: [BoxShadow(
                color: button_green.withOpacity(0.1),
                spreadRadius: 10,
                blurRadius: 10,
                offset: Offset(2.0, 2),
              ),]),
              child: FlatButton(

                  onPressed: ()async{


                  },child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Text('Reserve Table',style: TextStyle(
                      fontFamily: 'Montserrat',color: Colors.white, fontWeight: FontWeight.w400,fontSize: 14,

                    ),),
                  ],
                ),
              )),
            ),
          ),
        ],
      ),
    );
  }
  List time_list=['1:00 PM','2:00 PM','3:00 PM'];
  List period_list=['Breakfast','Lunch','Dinner'];
  int selected_time=0;
  int selected_period=0;
  int selectedDate=DateTime.now().day;
  InkWell dateWidget(int i)
  {
    DateTime tempDate = selected_date.add(Duration(days: i));
    return InkWell(

      onTap: (){
        setState(() {

          selectedDate=tempDate.day;

        });
      },
      child: Container(

        height: selectedDate==tempDate.day?64:57,
        width: selectedDate==tempDate.day?45:45,
        decoration: BoxDecoration(
          borderRadius: selectedDate==tempDate.day?BorderRadius.all(Radius.circular(10)):BorderRadius.all(Radius.circular(0)),
          color: (selectedDate == tempDate.day) ?head : ThemeProvider.of(context).brightness ==
              Brightness.light
              ?Colors.white:Color(0xff222C44),
          boxShadow: [BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(20.0, 0),
          ),],

        ),
        child: Container(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(dayValue(tempDate.weekday), style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Montserrat',
                  fontSize: 10,
                  color:  selectedDate==tempDate.day?Colors.white:ThemeProvider.of(context).brightness ==
                      Brightness.light
                      ?head:Colors.white
              ),),
              Text(tempDate.day.toString(), style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Montserrat',
                  color: selectedDate==tempDate.day? Colors.white:ThemeProvider.of(context).brightness ==
                      Brightness.light
                      ?Colors.black:Colors.white,

              ),)
            ],
          ),
        ),
      ),
    );

  }
  String dayValue(int weekDayVal)
  {
    List<String> dayString = ['', "Mon", "Tue", "Wed", "Thu", "Fri", "Sat", 'Sun'];
    return dayString[weekDayVal];
  }
  Widget _showDate(DateTime date) {
    return Container(
        padding: EdgeInsets.all(2), child: Text(arr[date.weekday - 1]));
  }
  var arr = new List(7);

  DateTime _date = new DateTime.now();
  TimeOfDay _time = new TimeOfDay.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: new DateTime(2016),
        lastDate: new DateTime(2019));

    if (picked != null && picked != _date) {
      print("Date selected ${_date.toString()}");
      setState(() {
        _date = picked;
      });
    }
  }
  Future<void> _showDatePopup(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(

        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != selected_date)
      setState(() {
        selected_date = pickedDate;
        selectedDate=selected_date.day;
      });
  }/*StatefulBuilder(
  builder: (context, setState) {*/
  Future<void> _showTableCalenderPopup(BuildContext context) async {
    final DateTime pickedDate =  await showDialog(
        context: context,

        builder: (context) {
          return StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  backgroundColor:ThemeProvider.of(context).brightness ==
                      Brightness.light
                      ? Colors.white:Color(0xff131824),
                  title: Text('Choose date',style: TextStyle(color: ThemeProvider.of(context).brightness ==
                      Brightness.light
                      ?Colors.black:Colors.white),),
                  content:Container(
                    height: 310,width: MediaQuery.of(context).size.width,
                    child: Column(

                      children: [
                        Row(

                          children: [
                            Container(height: 30,width: 70,
                              decoration: BoxDecoration(border: Border.all(color:ThemeProvider.of(context).brightness ==
                                  Brightness.light
                                  ? Colors.black:Colors.white,width: 0.25),
                                  borderRadius: BorderRadius.all(Radius.circular(6))
                              ),
                              child: Center(
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: month_index == null ? null : months[month_index],
                                    icon: Padding(
                                      padding: const EdgeInsets.only(left:8.0),
                                      child: Icon(Icons.keyboard_arrow_down_sharp),
                                    ),
                                    items: months.map((String value) {
                                      return new DropdownMenuItem<String>(
                                        value: value,
                                        child: new Text(value),
                                      );
                                    }).toList(),
                                    hint: Text('May'),
                                    onChanged: (String val) {
                                      setState(() {
                                        selected_month_index=val;
                                        month_index = months.indexOf(val);
                                        print(month_index.toString());
                                        SetDroDownDate();
                                      });
                                    },

                                  ),
                                ),
                              ),)  ,
                            SizedBox(width: 10,),
                            Container(height: 30,width: 70,
                              decoration: BoxDecoration(border: Border.all(color: ThemeProvider.of(context).brightness ==
                                  Brightness.light
                                  ? Colors.black:Colors.white,width: 0.25),borderRadius: BorderRadius.all(Radius.circular(6))),
                              child: Center(
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: selected_year,
                                    icon: Padding(
                                      padding: const EdgeInsets.only(left:8.0),
                                      child: Icon(Icons.keyboard_arrow_down_sharp),
                                    ),
                                    items: <String>['2021', '2022', '2023', '2024','2025','2026','2027','2028','2029','2030'].map((String value) {
                                      return new DropdownMenuItem<String>(
                                        value:value ,
                                        child: new Text(value),
                                      );
                                    }).toList(),
                                    hint: Text('2021'),
                                    onChanged: (String val) {
                                      setState((){
                                        selected_year=val;
                                        SetDroDownDate();
                                      });
                                    },
                                  ),
                                ),
                              ),)  ,

                          ],),
                        TableCalendar(

                          calendarController: _calendarController,
                          initialCalendarFormat: CalendarFormat.month,
                          formatAnimation: FormatAnimation.slide,
                          startingDayOfWeek: StartingDayOfWeek.sunday,
                          availableGestures: AvailableGestures.all,
                          initialSelectedDay: DateTime(int.parse(selected_year),month_index+1,day),
                          availableCalendarFormats: const {
                            CalendarFormat.month: '',
                          },
                          onDaySelected: (DateTime day, List events, List holidays) {
                            print('CALLBACK: _onDaySelected');

                            setState(() {
                              Navigator.of(context).pop();
                              selected_date = day;

                            });
                          },
                          calendarStyle: CalendarStyle(
                            outsideDaysVisible: false,
                            weekendStyle: TextStyle().copyWith(color: ThemeProvider.of(context).brightness ==
                                Brightness.light
                                ? Colors.black:Colors.white),
                            holidayStyle: TextStyle().copyWith(color:ThemeProvider.of(context).brightness ==
                                Brightness.light
                                ? Colors.black:Colors.white),

                          ),
                          daysOfWeekStyle: DaysOfWeekStyle(
                            weekendStyle: TextStyle().copyWith(color: ThemeProvider.of(context).brightness ==
                                Brightness.light
                                ? head:Colors.white),
                            weekdayStyle: TextStyle().copyWith(color:ThemeProvider.of(context).brightness ==
                                Brightness.light
                                ? head:Colors.white),
                          ),
                          headerStyle: HeaderStyle(
                              centerHeaderTitle: false,
                              leftChevronVisible: false,
                              rightChevronVisible: false,
                              formatButtonVisible: false,
                              titleTextStyle: TextStyle(color: Colors.white)
                          ),
                          builders: CalendarBuilders(
                            selectedDayBuilder: (context, date, _) {
                              return  Container(

                                decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.black,),


                                child: Center(
                                  child: Text(
                                    '${date.day}',
                                    style: TextStyle().copyWith(fontSize: 16.0,color: Colors.white),
                                  ),
                                ),
                              );
                            },
                            todayDayBuilder: (context, date, _) {
                              return Padding(
                                padding: EdgeInsets.only(top: 8.0, left: 6.0),
                                child: Text(
                                  '${date.day}',
                                  style: TextStyle().copyWith(fontSize: 16.0,color: ThemeProvider.of(context).brightness ==
                                      Brightness.light
                                      ? head:Colors.white),
                                ),
                              );
                            },),),
                      ],
                    ),
                  ),

                );
              }

          );
        }).whenComplete(() {
      setState(() {

        selectedDate=selected_date.day;
        day=selected_date.day;
        print(selectedDate.toString());
      });
      //setInitialDropDate();
    });
    if (pickedDate != null && pickedDate != selected_date)
      setState(() {
        selected_date = pickedDate;
        selectedDate=selected_date.day;
      });
  }
  DateTime selected_date=DateTime.now();
  var selected_year;
  var selected_month_index;
  DateTime table_day;
  var months = <String>[
    'Jan', 'Feb', 'Mar', 'Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'
  ];
  int month_index=0;
  int day;
  SetDroDownDate(){
    DateTime selected=DateTime(int.parse(selected_year),month_index+1,day);
    _calendarController.setSelectedDay(selected,animate: true);
  }
  setInitialDropDate(){
    DateTime today=DateTime.now();
    DateFormat dayformatter = DateFormat('dd');
    DateFormat monthformatter = DateFormat('MM');
    DateFormat yearformatter = DateFormat('yyyy');
    setState(() {
      selected_year=yearformatter.format(today);
      month_index = int.parse(monthformatter. format(today))-1;
      day=int.parse(dayformatter. format(today));
    });
    print(selected_year);
    print(month_index.toString());
    print(day.toString());
  }


}