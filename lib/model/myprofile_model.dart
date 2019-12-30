// ignore: camel_case_types

class MyProfileInfo {
  String _displayName;
  String _uid;
  String _mail;
  int _age;


  MyProfileInfo(this._displayName, this._mail, this._age,this._uid);

  MyProfileInfo.empty();

  MyProfileInfo.dynamical(dynamic v) {
    this._displayName = v['displayName'];
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

  String get name => _displayName;
  set name(String value){
    _displayName=value;
  }

  String get uid => _uid;
  set uid(String value){
    _uid=value;
  }


  String get Mail => _mail;
  set surname(String value){
    _mail=value;
  }


  int get age => _age;
  set age(int value){
    _age=value;
  }


}
