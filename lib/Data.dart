
import 'dart:core';

class Data {
  String id;
  String name;
  String surname;
  String nick;
  String img;
  int count;

  Data(this.id, this.name, this.surname, this.nick, this.img, this.count);

  factory Data.fromJson(String key,Map<dynamic, dynamic>json){

    return Data(
      key,
      json["name"] as String,
      json["surname"] as String,
      json["nick"] as String,
      json["img"] as String,
      json["count"] as int,


    );


  }
}