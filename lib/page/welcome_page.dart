import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:redrondo22/page/login_page.dart';
import 'package:redrondo22/page/register_page.dart';
import 'package:redrondo22/page/view_page.dart';


class WelcomePage extends StatefulWidget {
  static final String welcomePageUrl = '/welcomepage';

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controlAvailableUser();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome Page') ,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(5),
            width: 200.0,
            height: 260.0,
            decoration: BoxDecoration(
                color: Colors.black,
                image: DecorationImage(
                    image: AssetImage('assets/uygulamatanıtım.jpg'),
                    fit: BoxFit.cover),

               ),
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Container(
              
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.black,
                  borderRadius:
                  BorderRadius.all(Radius.circular(75.0)),
                  boxShadow: [
                  BoxShadow(blurRadius: 7.0, color: Colors.black)
             ] ),
              child: RaisedButton(

                onPressed: navigateToSignIn,
                child: Text('Sign In'),
              ),
            ),
          ),


          Padding(
            padding: EdgeInsets.all(20.0),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius:
                  BorderRadius.all(Radius.circular(75.0)),
                  boxShadow: [
                    BoxShadow(blurRadius: 7.0, color: Colors.black)
                  ] ),

              child: RaisedButton(
                onPressed: navigateToSignUp,
                child: Text('Sign Up'),
              ),
            ),
          )
        ],
      ),
    );
  }
  _controlAvailableUser() async {
    FirebaseUser mUser = await FirebaseAuth.instance.currentUser();
    if (mUser == null) {
    } else {
        Navigator.pushReplacementNamed(context, MainPage.mainPageUrl);
    }
  }
  /*Future  <void> signIn() async{
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
  }*/
  void navigateToSignIn(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage(), fullscreenDialog: true));
  }
  void navigateToSignUp(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterPage(), fullscreenDialog: true));
  }
}
