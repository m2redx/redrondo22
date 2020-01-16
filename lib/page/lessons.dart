import 'package:firebase_auth/firebase_auth.dart';
import 'package:redrondo22/constants.dart';
import 'package:redrondo22/model/lessonsmodel.dart';
import 'package:redrondo22/page/lessonadd_page.dart';
import 'package:redrondo22/page/multiform.dart';
import 'package:redrondo22/services/firebase_crud.dart';
import 'package:redrondo22/services/utils.dart';
import 'package:redrondo22/widgets/loading.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class lessons extends StatefulWidget {
  @override
  _lessonsState createState() => _lessonsState();
}

class _lessonsState extends State<lessons> {
  CalendarController _calendarController;
  FirebaseUser user;
  String dayPath;
  @override
  void initState() {
    dayPath = DatabaseUtils().getTodayToString();
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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            buildCalendarWidget(),
            _lessonAddPageCardWidget(),
            //Reusablacard koy
          ],
        ),
      ),
    );

  }
  Widget _lessonAddPageCardWidget() {
    return FutureBuilder(
      future: DatabaseUtils().getDailyLessonsWithParam(dayPath),
      builder: (context, AsyncSnapshot<List<Lessonsmodel>> snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return Container(child: Center(child: LoadingWidget().getLoadingWidget()),);
        }
        if (snapshot.data != null) {
          List<Lessonsmodel> dailyLesson = snapshot.data;
          return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: dailyLesson.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 200.0,
                  color: Colors.white,
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      AppBar(
                        backgroundColor: Color(0xFF1D1E33),
                        leading: Icon(
                          Icons.book,
                        ),
                        title: Text('Ders'),
                        centerTitle: true,
                        actions: <Widget>[
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              print(index.toString());
                              String todayLessonDate = DatabaseUtils().getTodayToString();
                              print(todayLessonDate);
                              print(dailyLesson[index].id);

                              FirebaseCrud().writeData(Constants.refMyLessons + '/' + user.uid + '/' + todayLessonDate + '/' + dailyLesson[index].id,null);
                              setState(() {

                              });
                            },
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: Text('Dersin Adı'),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: Text('Konu ADı'),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: Text('Çözülen Soru Sayısı'),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: Text('Hedef'),
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: Text(dailyLesson[index].lessonName),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: Text(dailyLesson[index].subject,maxLines: 3,),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: Text(dailyLesson[index].solved_questions.toString()),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: Text(dailyLesson[index].target_question_count.toString()),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 8.0,)
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          return Container(child: Center(child: Text('Mevcut Ders Bulunamadı',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),);
        }
      },
    );
  }

  SizedBox buildCalendarWidget() {
    return SizedBox( //takvimi belirli bir şeyin içine al
      child: TableCalendar(
        calendarStyle:  CalendarStyle(
          todayColor: Colors.blueAccent,
              selectedColor: Theme.of(context).primaryColor,
            todayStyle: TextStyle(
              fontWeight: FontWeight.bold,
                  color: Colors.white
            )
        ),
        headerStyle: HeaderStyle(
          centerHeaderTitle: true,
          formatButtonDecoration: BoxDecoration(
            color: Colors.black38,
            borderRadius: BorderRadius.circular(20.0)
          ),
          formatButtonTextStyle: TextStyle(
            color: Colors.white
          ),
          formatButtonShowsNext: false,
        ),
           startingDayOfWeek: StartingDayOfWeek.monday,
        onDaySelected: (date,events){
          String dateSelected = date.day.toString() + '-' + date.month.toString() + '-' + date.year.toString();
          getSelectedLesson(dateSelected);
          print(dateSelected);
        },
        builders: CalendarBuilders(
          todayDayBuilder: (context,date,events)=>
              Container(
                alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10.0)
              ),
              child: Text(date.day.toString())),
          selectedDayBuilder: (context,date,events)=>
              Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.yellowAccent,
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: Text(date.day.toString())),
        ),

        calendarController:_calendarController,
        rowHeight: 35.0,
      ),


    );
  }
  void LessonsAdd(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>Multiform(), fullscreenDialog: true));
  }

  void getSelectedLesson(String day) {
    dayPath = day;
    setState(() {

    });
  }
}
