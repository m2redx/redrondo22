import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:redrondo22/page/home.dart';
import 'package:redrondo22/page/view_page.dart';


class LoginPage extends StatefulWidget {
  static final String loginPageUrl = '/loginpage';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email , _password;
  final GlobalKey<FormState> _formKey  = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: Text('Sign İn Page'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              validator: (value) => value.isEmpty ? 'email cant be empty ':null,
              onSaved: (input) => _email = input,
              decoration: InputDecoration(
                  labelText: 'Email'
              ),

            ),
            TextFormField(
              validator: (value) =>value.isEmpty ? 'passsword canr be empty':null,
              onSaved: (input) => _password = input,
              decoration: InputDecoration(
                  labelText: 'password'
              ),
              obscureText: true,

            ),
            RaisedButton(
              onPressed: signIn,
              child: Text('SIGN IN'),
            )
          ],
        ),
      ),
    );
  }
  Future  <void> signIn() async{
    final formState = _formKey.currentState;
    if(formState.validate()){
      formState.save();
      try{
        Navigator.push(context, MaterialPageRoute(builder: (context)=>MainPage()));
        AuthResult user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
      }catch(e){
        print(e.message);
      }


    }
  }
}


