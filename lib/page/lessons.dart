import 'package:redrondo22/page/lessonadd_page.dart';
import 'package:redrondo22/page/multiform.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';


class lessons extends StatefulWidget {
  @override
  _lessonsState createState() => _lessonsState();
}

class _lessonsState extends State<lessons> {
  CalendarController _calendarController;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: Icon(
          Icons.add,
              color: Colors.white,
        ),

        onPressed: LessonsAdd,
      ),
      body: Column(
        children: <Widget>[
          buildCalendarWidget(),
          //Reusablacard koy
        ],
      ),
    );

  }

  SizedBox buildCalendarWidget() {
    return SizedBox( //takvimi belirli bir şeyin içine al
      child: TableCalendar(
        calendarController:_calendarController,
        rowHeight: 35.0,
      ),


    );
  }
  void LessonsAdd(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>Multiform(), fullscreenDialog: true));
  }
}
