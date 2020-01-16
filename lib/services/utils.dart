import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:redrondo22/constants.dart';
import 'package:redrondo22/model/lessonsmodel.dart';
import 'package:redrondo22/model/subjectmodel.dart';
import 'package:redrondo22/services/firebase_crud.dart';

class DatabaseUtils{

  Map<String,List<SubjectModel>> getAllLessonWithSubjects(data) {
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

  String getTodayToString(){
    DateTime now = DateTime.now();
    String todayToString = (now.day.toString() + '-' + now.month.toString() + '-' + now.year.toString());
    return todayToString;
  }

 Future<List<Lessonsmodel>> getDailyLessons() async {
   List<Lessonsmodel> lessonModelList = new List();
   FirebaseUser user = await FirebaseAuth.instance.currentUser();
   String todayLessonDate = getTodayToString();
    DataSnapshot snapshot = await FirebaseCrud().readData(Constants.refMyLessons + '/' + user.uid + '/' + todayLessonDate);
    Map<dynamic,dynamic> mapData = snapshot.value;
    if(mapData != null){
      mapData.forEach((key,value){
        print(key); // PushKey
        print(value); //
        Lessonsmodel lessonsmodel = new Lessonsmodel.dynamicval(value);
        lessonModelList.add(lessonsmodel);
      });
      return lessonModelList;
    }
    return null;
  }
  Future<List<Lessonsmodel>> getDailyLessonsWithParam(String dayPath) async {
    List<Lessonsmodel> lessonModelList = new List();
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    String todayLessonDate = dayPath;
    DataSnapshot snapshot = await FirebaseCrud().readData(Constants.refMyLessons + '/' + user.uid + '/' + todayLessonDate);
    Map<dynamic,dynamic> mapData = snapshot.value;
    if(mapData != null){
      mapData.forEach((key,value){
        print(key); // PushKey
        print(value); //
        Lessonsmodel lessonsmodel = new Lessonsmodel.dynamicval(value);
        lessonModelList.add(lessonsmodel);
      });
      return lessonModelList;
    }
    return null;
  }

}
