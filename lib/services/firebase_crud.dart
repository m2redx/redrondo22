import 'package:firebase_database/firebase_database.dart';

class FirebaseCrud{
  static FirebaseDatabase database = FirebaseDatabase();
  static DatabaseReference myRef = database.reference();


  /**
   * Path için Lessons/Matematik/0
   * Ornek : {"subjectName":"Toplama","t_count":2}
   */
  writeData(String path,dynamic data){
    myRef.child(path).set(data);
  }

  writeDataWithPush({String path,dynamic data}){
    myRef.child(path).push().set(data);
  }

  getPushKey(){
    return myRef.push().key;
  }

  Future<DataSnapshot> readData(String path) async{
    DataSnapshot snapshot = await myRef.child(path).once();
    return snapshot;
  }

}