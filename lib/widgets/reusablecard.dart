import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {

  ReusableCard({this.color,@required this.cardChild,this.onPress});

  final Color color;
  final Widget cardChild;
  final Function onPress;
  @override

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onPress ,
      child: Container(
        child:Center(child:this.cardChild),
        margin: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color:Color(0xFF1D1E33),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}