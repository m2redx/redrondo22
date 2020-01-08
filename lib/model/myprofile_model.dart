// ignore: camel_case_types

class MyProfileInfo {
  String _displayName;
  String _uid;
  String _mail;
  int _age;


  MyProfileInfo(this._displayName, this._mail, this._age,this._uid);

  MyProfileInfo.empty();

  MyProfileInfo.dynamical(dynamic v) {
    this._displayName = v['name'];
    this._uid=v['uid'];
    this._mail = v['mail'];
    this._age = v['age'];
  }

  toJson() {
    return {
      "name": _displayName,
      "mail":_mail,
      "age":_age,
      "uid":_uid
    };
  }

  int get age => _age;

  set age(int value) {
    _age = value;
  }

  String get mail => _mail;

  set mail(String value) {
    _mail = value;
  }

  String get uid => _uid;

  set uid(String value) {
    _uid = value;
  }

  String get displayName => _displayName;

  set displayName(String value) {
    _displayName = value;
  }


}
