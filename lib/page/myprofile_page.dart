import 'package:flutter/material.dart';

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
          Positioned(
            width: 400.0,
            top: MediaQuery.of(context).size.height / 10,
            child: Column(
              children: <Widget>[
                Text('Mert Murat Kırmızı',style: TextStyle(fontSize:30.0,fontWeight: FontWeight.bold,color: Colors.grey),),
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
          )
        ],
      ),
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
