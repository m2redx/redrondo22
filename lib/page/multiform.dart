import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:redrondo22/constants.dart';
import 'package:redrondo22/model/lessonsmodel.dart';
import 'package:redrondo22/model/myprofile_model.dart';
import 'package:redrondo22/model/subjectmodel.dart';
import 'package:redrondo22/page/lessonadd_page.dart';
import 'package:redrondo22/services/firebase_crud.dart';

class Multiform extends StatefulWidget {
  @override
  _MultiformState createState() => _MultiformState();
}

class _MultiformState extends State<Multiform> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<Lessonsmodel> lessons = [];

  bool isVisibleSaveButton = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Lessons Add Box'),
      ),
      body: lessons.length <= 0
          ? Center(
              child: Text('ders eklemek için tıklayın'),
            )
          : _lessonAddPageCardWidget(),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Visibility(
            visible: isVisibleSaveButton,
            child: FloatingActionButton(
              child: Icon(Icons.save),
              onPressed: onSaved,
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: onAddLesson,
          ),
        ],
      ),
    );
  }

  void onSaved() async {
    ///
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    DateTime now = DateTime.now();
    for(Lessonsmodel lessonsmodel in lessons){
      FirebaseCrud().writeDataWithPush(path:Constants.refMyLessons + '/' + user.uid + '/' + (now.day.toString() + '-' + now.month.toString() + '-' + now.year.toString()),data: lessonsmodel.toJson());
    }
    Navigator.pop(context);
  }
  void onDelete(int index) {
    setState(() {
      lessons.removeAt(index);
    });
  }

  void onAddLesson() {
    setState(() {
      lessons.add(Lessonsmodel('Murat', 5, 0, 'Sayılar'));
      if (lessons.length > 0)
        isVisibleSaveButton = true;
      else {
        isVisibleSaveButton = false;
      }
    });
  }

  Widget _lessonAddPageCardWidget() {
    return Stack(
      children: <Widget>[
        FutureBuilder(
          future: FirebaseCrud().readData(Constants.refLessons),
          builder: (context,AsyncSnapshot<DataSnapshot> snapshot){
            if(snapshot.data != null){
              Map<String,List<SubjectModel>> allLessons = _getAllLessonWithSubjects(snapshot.data.value);
              return ListView.builder(
                itemCount: lessons.length,
                itemBuilder: (_, i){
                  return LessonAddPage(

                    lesson_name: lessons[i],
                    onDelete: () => onDelete(i),
                    allLessons: allLessons,
                    onSaved: (Lessonsmodel onSaved){
                      print('Eklendi' + i.toString());
                      lessons[i] = onSaved;
                    },
                  );
                }
              );
            }else{
              return Container();
            }
          },

        ),
      ],
    );
  }

  Map<String,List<SubjectModel>> _getAllLessonWithSubjects(data) {
    //print(data['Matematik']);
    Map<String,List<SubjectModel>> _lessonsMap = new Map(); //DersAdi,Konu Listesi
    Map<dynamic,dynamic> map = data;
    map.forEach((key,value){
      String lessonName = key;
      List<SubjectModel> lessonsNameList = new List();
      List<dynamic> list = value;
      Map<dynamic,dynamic> mapLessons = list.asMap();
      mapLessons.forEach((key,value){
        int subjectUid = key;
        String subjectName = value['subjectName'];
        SubjectModel subjectModel = new SubjectModel(lessonName, subjectUid, subjectName);
        lessonsNameList.add(subjectModel);
      });
      _lessonsMap[lessonName] = lessonsNameList;
    });
    return _lessonsMap;
  }

}
