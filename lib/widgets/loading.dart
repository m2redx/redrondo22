import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';

class LoadingWidget{
  Widget getLoadingWidget(){
    return LoadingBouncingGrid.circle();
  }
}