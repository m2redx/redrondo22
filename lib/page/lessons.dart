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
}
