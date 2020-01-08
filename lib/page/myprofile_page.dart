import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:redrondo22/constants.dart';
import 'package:redrondo22/model/myprofile_model.dart';
import 'package:redrondo22/services/firebase_crud.dart';

class MyProfilePage extends StatefulWidget {
  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:  Stack(
        children: <Widget>[
          ClipPath(
            child: Center(
              child: Container(
                color: Color(0xFF1D1E33),
              ),
            ),
            clipper: getClipper(),
          ),
          _myUserInfoWidget(),

        ],
      ),
    );
  }

  Widget _myUserInfoWidget() {

    return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot){
        if(snapshot.data != null){
          return FutureBuilder(
            future: FirebaseCrud().readData(Constants.refUser + '/' +  snapshot.data.uid + '/property'),
            builder: (BuildContext context, AsyncSnapshot<DataSnapshot> snapshot) {
              if(snapshot.data != null){
                DataSnapshot dataSnapshot = snapshot.data;
                print(dataSnapshot.value);
                MyProfileInfo myProfileInfo = new MyProfileInfo.dynamical(dataSnapshot.value);
                return Positioned(
                  width: 400.0,
                  top: MediaQuery.of(context).size.height / 10,
                  child: Column(
                    children: <Widget>[
                      Text(myProfileInfo.displayName,style: TextStyle(fontSize:30.0,fontWeight: FontWeight.bold,color: Colors.grey),),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 150.0,
                          height: 150.0,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              image: DecorationImage(
                                  image: AssetImage('assets/jonydeep.jpg'), fit: BoxFit.cover),
                              borderRadius: BorderRadius.all(Radius.circular(75.0)),
                              boxShadow: [
                                BoxShadow(blurRadius: 7.0,color: Colors.black)
                              ]
                          ),
                        ),
                      ),
                      SizedBox(height: 90.0,),


                    ],
                  ),
                );
              }else{
                return Container();
              }
            },
          );
        }else{
          return Container();
        }
      },
    );

  }
}

class getClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    var path = new Path();
    path.lineTo((0.0), size.height / 2.2);
    path.lineTo(size.width + 400, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
