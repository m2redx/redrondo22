import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:redrondo22/constants.dart';
import 'package:redrondo22/model/lessonsmodel.dart';
import 'package:redrondo22/model/subjectmodel.dart';
import 'package:redrondo22/services/firebase_crud.dart';
import 'package:redrondo22/services/utils.dart';
import 'package:redrondo22/widgets/loading.dart';
import 'package:redrondo22/widgets/reusablecard.dart';

import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class home_page extends StatefulWidget {
  @override
  _home_pageState createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {
  final GlobalKey<FormState> _formkeyValue = GlobalKey<FormState>();
  List<Lessonsmodel> lessons = [];
  FirebaseUser user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initialize();
  }

  _initialize() async {
    user = await FirebaseAuth.instance.currentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              width: 100.0,
              height: 100.0,
              child: ReusableCard(
                cardChild: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Günlük Çalışma',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),

                  ],
                ),
              ),
            ),
            _lessonAddPageCardWidget(),
          ],
        ),
      ),
    );
  }

  Widget _lessonAddPageCardWidget() {
    String _solved_question_count;
    return FutureBuilder(
      future: DatabaseUtils().getDailyLessons(),
      builder: (context, AsyncSnapshot<List<Lessonsmodel>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            child: Center(child: LoadingWidget().getLoadingWidget()),
          );
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
                              String todayLessonDate =
                                  DatabaseUtils().getTodayToString();
                              print(todayLessonDate);
                              print(dailyLesson[index].id);

                              FirebaseCrud().writeData(
                                  Constants.refMyLessons +
                                      '/' +
                                      user.uid +
                                      '/' +
                                      todayLessonDate +
                                      '/' +
                                      dailyLesson[index].id,
                                  null);
                              setState(() {});
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
                                  child: Text('Konu Adı'),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: Text('Kaç Soru Çözdün'),
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
                                  child: Text(
                                    dailyLesson[index].subject,
                                    maxLines: 3,
                                  ),
                                ),
                              ),
                              Padding(

                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: 30.0,
                                  child: TextField(

                                    keyboardType: TextInputType.number,
                                    onSubmitted: (input) async {
                                      _solved_question_count = input;
                                      String todayLessonDate =
                                          DatabaseUtils().getTodayToString();
                                      DataSnapshot dataSnapshot = await FirebaseCrud().readData(Constants.refMyLessons +
                                              '/' +
                                              user.uid +
                                              '/' +
                                              todayLessonDate +
                                              '/' +
                                              dailyLesson[index].id +
                                              '/' +
                                              'solvedquesiton');
                                      int currentVal = dataSnapshot.value;
                                      if(currentVal != null){
                                        if(input != null){
                                          currentVal +=  int.parse(input);

                                        }
                                      }else{

                                        currentVal = 0;
                                        currentVal = int.parse(input);
                                      }
                                      FirebaseCrud().writeData(
                                          Constants.refMyLessons +
                                              '/' +
                                              user.uid +
                                              '/' +
                                              todayLessonDate +
                                              '/' +
                                              dailyLesson[index].id +
                                              '/' +
                                              'solvedquesiton',
                                          currentVal);
                                    },
                                    // Text(dailyLesson[index].solved_questions.toString()), Veriyi burası çekiyor
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: Text(dailyLesson[index]
                                      .target_question_count
                                      .toString()),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 9.0,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          return Container(
            child: Center(
                child: Text(
              'Mevcut Ders Bulunamadı',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )),
          );
        }
      },
    );
  }

  _lessonBoxWidget(Lessonsmodel lessonsmodel) {
    return Container(
      width: 200.0,
      color: Colors.white,
      padding: EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            AppBar(
              backgroundColor: Color(0xFF1D1E33),
              leading: Icon(
                Icons.book,
              ),
              title: Text('Lessons Box'),
              centerTitle: true,
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    setState(() {
                      // widget.onDelete();
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Text(lessonsmodel.lessonName),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Text(lessonsmodel.subject),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Text(lessonsmodel.solved_questions.toString()),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child:
                            Text(lessonsmodel.target_question_count.toString()),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 16.0,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CircularSlider extends StatelessWidget {
  double initialValue;
  double min;
  double max;

  CircularSlider(
      {@required this.initialValue, @required this.min, @required this.max});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: 100.0, height: 100.0, child: slider());
  }

  Widget slider() {
    return SleekCircularSlider(
      min: min,
      max: max,
      initialValue: initialValue,
    );
  }
}
