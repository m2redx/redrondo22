import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:redrondo22/constants.dart';
import 'package:redrondo22/model/myprofile_model.dart';
import 'package:redrondo22/page/login_page.dart';
import 'package:redrondo22/page/myprofile_page.dart';
import 'package:redrondo22/page/view_page.dart';
import 'package:redrondo22/page/welcome_page.dart';
import 'package:redrondo22/services/firebase_crud.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String _email, _password, _displayname,age;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up Page'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                validator: (input) {
                  if (input.isEmpty) {
                    return 'please type an email';
                  }
                },
                keyboardType: TextInputType.emailAddress,
                onSaved: (input) => _email = input,
                decoration: InputDecoration(
                    icon: Icon(

                    Icons.mail
                    ),
                    labelText: 'Email'
                ),
              ),
              TextFormField(
                validator: (input) {
                  if (input.length > 7) {
                    return '6 karakterden fazla girmeyiniz';
                  }
                },
                onSaved: (input) => _password = input,
                decoration: InputDecoration(
                    icon: Icon(
                    Icons.vpn_key
                    ),
                    labelText: 'password'
                ),
                obscureText: true,

              ),
              TextFormField(
                validator: (input) {
                  if (input.length > 25) {
                    return 'düzgün isim girin';
                  }
                },
                onSaved: (input) => _displayname = input,
                decoration: InputDecoration(

                    icon: Icon(
                      FontAwesomeIcons.userCircle

                    ),
                    labelText: 'Full Name'
                ),


              ),
              TextFormField(
                validator: (input) {
                  if (input.length > 2) {
                    return 'düzgün yaş girin';
                  }
                },
                onSaved: (input) => age = input,
                decoration: InputDecoration(
                    icon: Icon(
                        FontAwesomeIcons.baby

                    ),

                    labelText: 'Age'
                ),

              ),

              RaisedButton(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                color: Colors.grey,
                onPressed: signUp,
                child: Text('SIGN UP'),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future <void> signUp() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();

      AuthResult result = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email.trim(), password: _password.trim());
      FirebaseUser user= result.user;
      user.sendEmailVerification();
      MyProfileInfo myProfileInfo = new MyProfileInfo(_displayname, user.email,int.parse(age), user.uid);
      _writeUserData(myProfileInfo);
      Navigator.of(context).pop();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => WelcomePage()));
    }
  }

  void _writeUserData(MyProfileInfo user) {
    FirebaseCrud().writeData(Constants.refUser + '/' + user.uid + '/' + 'property',user.toJson());

  }


}
