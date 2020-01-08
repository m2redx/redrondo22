class SubjectModel {
  String _lessonName;
  int _uid;
  String _subjectName;

  SubjectModel(this._lessonName, this._uid, this._subjectName);

  String get subjectName => _subjectName;

  set subjectName(String value) {
    _subjectName = value;
  }

  int get uid => _uid;

  set uid(int value) {
    _uid = value;
  }

  String get lessonName => _lessonName;

  set lessonName(String value) {
    _lessonName = value;
  }


}