import 'dart:core';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:redrondo22/model/lessonsmodel.dart';
import 'package:redrondo22/model/subjectmodel.dart';

typedef Ondelete();

class LessonAddPage extends StatefulWidget {
  final ValueChanged<Lessonsmodel> onSaved;

  final Map<String, List<SubjectModel>> allLessons;

  // final state = _UserFormState();
  final Ondelete onDelete;
  Key key;
  LessonAddPage(
      {this.onDelete, this.allLessons, this.onSaved,this.key});

  @override
  _LessonAddPageState createState() => _LessonAddPageState();
}

class _LessonAddPageState extends State<LessonAddPage> {
  String target_question_count;

  var selectedLesson;
  var selectedSubjectType;
  final GlobalKey<FormState> _formkeyValue = GlobalKey<FormState>();
  List<String> _lessons;
  Map<String, List<String>> _lessonsSubjectMap = new Map();
  List<SubjectModel> _lessonsSubject;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _lessons = widget.allLessons.keys.toList();
    _lessonsSubject = new List();
    _lessonsSubject.add(new SubjectModel('', 0, ''));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.0,
      color: Colors.white,
      padding: EdgeInsets.all(8.0),
      child: Card(
        child: Form(
          key: _formkeyValue,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              AppBar(
                leading: Icon(
                  Icons.book,
                ),
                title: Text('Lessons Add Box'),
                centerTitle: true,
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        widget.onDelete();
                      });
                    },
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  child: DropdownButton(
                    items: _lessons
                        .map((value) =>
                        DropdownMenuItem(
                          child: Text(value),
                          value: value,
                        ))
                        .toList(),
                    onChanged: (lessonsTypeData) {
                      setState(() {
                        selectedLesson = lessonsTypeData;
                        _controlData();
                        if (_lessons.contains(selectedLesson)) {
                          _lessonsSubject =
                              widget.allLessons[selectedLesson].toList();
                        }
                      });
                    },
                    value: selectedLesson,
                    isExpanded: true,
                    hint: Text(
                      'ders lazım',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: DropdownButton(
                    focusColor: Colors.blue,
                    items: _lessonsSubject.map((SubjectModel value) =>
                        DropdownMenuItem(child: Text(value.subjectName),
                          value: value.subjectName,)).toList(),
                    onChanged: (selectedLessonSubjectType) {
                      setState(() {
                        selectedSubjectType = selectedLessonSubjectType;
                        _controlData();

                      });
                    },
                    value: selectedSubjectType,
                    isExpanded: true,
                    hint: Text(
                      'konu lazım lazım',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                validator: (value) =>
                value.isEmpty
                    ? 'target question cant be empty '
                    : null,
                onFieldSubmitted: (input) {
                  target_question_count = input;
                  _controlData();
                },
                decoration: InputDecoration(

                    icon: Icon(
                        FontAwesomeIcons.bullseye
                    ),
                    labelText: 'Hedef'
                ),

              ),
            ],
          ),
        ),
      ),
    );
  }

  _controlData() {
    if (selectedLesson != null && selectedSubjectType != null &&
        target_question_count != null) {
      Lessonsmodel lessonsmodel = new Lessonsmodel(selectedLesson, int.parse(target_question_count), 0, selectedSubjectType,null);
      widget.onSaved(lessonsmodel);
    }
  }
}
