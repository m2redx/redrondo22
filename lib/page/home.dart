import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:redrondo22/widgets/reusablecard.dart';

import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class home_page extends StatefulWidget {
  @override
  _home_pageState createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            width: 100.0,
            height: 250.0,
            child: ReusableCard(
              cardChild: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Günlük Çalışma',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),



                  Container(
                    width: double.infinity,
                    height: 100.0,
                    child: ListView(//listwiev.builder yapısına bak onunla yaz item alacak//
                      children: <Widget>[CircularSlider(initialValue: 50, min: 0, max: 100), CircularSlider(initialValue: 10, min: 0, max: 100)],
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 100.0,
            width: 70.0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  child: ReusableCard(
                    onPress: () {
                      setState(() {
                        print('merhba');
                      });
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CircularSlider extends StatelessWidget {
  double initialValue;
  double min;
  double max;


  CircularSlider({@required this.initialValue, @required this.min, @required this.max});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 100.0,
        height: 100.0,
        child: slider());
  }

  Widget slider(){
    return SleekCircularSlider(
      min: min,
      max: max,
      initialValue: initialValue,
    );
  }
}
