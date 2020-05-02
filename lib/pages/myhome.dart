import 'package:flutter/material.dart';
import 'package:journal/data/data.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
//import 'package:flutter_calendar/flutter_calendar.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import '../data/data.dart';
import '../data/data.dart';
//import 'package:intl/intl.dart';
class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

//List<DateTime> absentDates = [
//  DateTime(2020, 3, 2),
//  DateTime(2020, 3, 7),
//  DateTime(2020, 3, 8),
//  DateTime(2020, 3, 12),
//  DateTime(2020, 4, 13),
//  DateTime(2020, 4, 14),
//  DateTime(2020, 4, 16),
//  DateTime(2020, 4, 17),
//  DateTime(2020, 4, 18),
//  DateTime(2020, 4, 30),
//];


class _MyHomeState extends State<MyHome> {
  @override
  void initState() {
    super.initState();
    //initList();

  }

  DateTime _currentDate2 = DateTime.now();
  static var now = new DateTime.now();
  var m = now.month;

  static Widget _absentIcon(String day) => Container(
    decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.all(
            Radius.circular(1000)),
        border: Border.all(color: Colors.blue, width: 2.0, )),
    child: Container(height:2,width:2,alignment:Alignment.bottomCenter,child:Icon(
      Icons.fiber_manual_record,
      color: Colors.orangeAccent,
      size: 13,
    ),
    ),

    /* child: Center(
      child: Text(
        day,
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    ), */
  );

  EventList<Event> _markedDateMap = new EventList<Event>(
    events: {},
  );

  CalendarCarousel _calendarCarouselNoHeader;
  int len = data.dailyFeeds.length;
  double cHeight;



  @override
  Widget build(BuildContext context) {
    int c=0;
    print("length $len");
    cHeight = MediaQuery.of(context).size.height;
    for (int i = 0; i < len; i++) {
      DateTime dateIter = stringtodate(data.dailyFeeds[i].date);
      if(dateIter.month==m)
        c=c+1;
      _markedDateMap.add(
        dateIter,
        new Event(
          date: dateIter,
          title: 'Event 5',
          dot: Container(
            margin: EdgeInsets.symmetric(horizontal: 1.0),
            color: Colors.red,
            height: 10.0,
            width: 10.0,
          ),
          icon: _absentIcon(
            dateIter.day.toString(),
          ),
        ),
      );
    }


    _calendarCarouselNoHeader = CalendarCarousel<Event>(
      height: cHeight * 0.54,
      weekendTextStyle: TextStyle(
        color: Color(0xffFF7582),
      ),
      todayButtonColor: Colors.blue,
      markedDatesMap: _markedDateMap,
      //markedDateWidget: Positioned(child: Container(color: Colors.blue, height: 4.0, width: 4.0), bottom: 4.0, left: 18.0),
      markedDateShowIcon: true,
      markedDateIconMaxShown: 1,
      /*markedDateCustomTextStyle: TextStyle(
        fontSize: 18,
        color: Colors.blue,
      ),
      */
      markedDateMoreShowTotal:
      null, // null for not showing hidden events indicator
      markedDateIconBuilder: (event) {
        return event.icon;
      },
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(EvaIcons.menu2Outline,
            color: Color(0xffFF7582),),
          iconSize: 35,
          onPressed: () {},
        ),

        title: Text("My Home",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.normal),),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _calendarCarouselNoHeader,
            //markerRepresent(Colors.red, "Absent"),
            //markerRepresent(Colors.green, "Present"),
            eventCount("Total Events" , len),
            eventCount("Total Events this month" , c),
          ],
        ),
      ),

    );
  }

  Widget markerRepresent(Color color, String data) {
    return new ListTile(
      leading: new CircleAvatar(
        backgroundColor: color,
        radius: cHeight * 0.022,
      ),
      title: new Text(
        data,
      ),
    );
  }

  Widget eventCount(String s, var data) {
    return new ListTile(
      leading: new Icon(
        Icons.event_note,
        color:Color(0xffFF7582) ,
      ),
      title: new Text(
        s,
      ),
      subtitle: new Text(data.toString(),),
    );
  }
  
//  initList() async{
//    int len = data.dailyFeeds.length;
//    for (DailyFeeds days in data.dailyFeeds){
//      String date = days.date;
//      print("This is date $date");
//      //String m = "";
//      int day = int.parse(date.substring(4,6));
//      print("This is day $day");
//      int year = int.parse(date.substring(7,11));
//
//      if(!(absentDates.contains(DateTime(2020, 4, day)))){
//        absentDates.add(DateTime(year, 4, day));
//      }
//    }
//
//  }

  DateTime stringtodate(stringDate){
    List<String> monthNumber = ["Jan", "Feb", "Mar", "Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"];
    int month = monthNumber.indexOf(stringDate.substring(0,3)) + 1;             //
    int day = int.parse(stringDate.substring(4,6));
    int year = int.parse(stringDate.substring(7,stringDate.length));
    print(" Day : $day , Month : $month , Year : $year");
    return DateTime(year,month,day);
  }
}