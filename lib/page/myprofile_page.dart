import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Center(
            child: Container(
              color: Colors.blueGrey,
            ),
          ),
          _myUserInfoWidget(),
        ],
      ),
    );
  }

  Widget _myUserInfoWidget() {
    return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
        if (snapshot.data != null) {
          return FutureBuilder(
            future: FirebaseCrud().readData(
                Constants.refUser + '/' + snapshot.data.uid + '/property'),
            builder:
                (BuildContext context, AsyncSnapshot<DataSnapshot> snapshot) {
              if (snapshot.data != null) {
                DataSnapshot dataSnapshot = snapshot.data;
                print(dataSnapshot.value);
                MyProfileInfo myProfileInfo =
                    new MyProfileInfo.dynamical(dataSnapshot.value);
                return Positioned(
                  width: 400.0,
                  top: MediaQuery.of(context).size.height / 18,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 150.0,
                          height: 150.0,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              image: DecorationImage(
                                  image: AssetImage('assets/playstore.png'),
                                  fit: BoxFit.cover),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(75.0)),
                              boxShadow: [
                                BoxShadow(blurRadius: 7.0, color: Colors.black)
                              ]),
                        ),
                      ),
                      SizedBox(
                        height: 50.0,
                      ),
                      Card(
                        color: Color(0xFFF5F5DC),
                          margin: EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 25.0,
                          ),
                          child: ListTile(
                            leading: Icon(Icons.person),
                            title: Text(
                        myProfileInfo.displayName,
                        style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                      ),
                          )),
                      Card(
                          color: Color(0xFFF5F5DC),
                          margin: EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 25.0,
                          ),
                          child: ListTile(
                            leading: Icon(Icons.mail),
                            title: Text(
                              myProfileInfo.mail,
                              style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          )),
                      Card(
                          color: Color(0xFFF5F5DC),
                          margin: EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 25.0,
                          ),
                          child: ListTile(
                            leading: Icon(FontAwesomeIcons.baby),
                            title: Text(
                              myProfileInfo.age.toString(),
                              style: TextStyle(
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          )),
                    ],
                  ),
                );
              } else {
                return Container();
              }
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}

@override
bool shouldReclip(CustomClipper<Path> oldClipper) {
  return true;
}
