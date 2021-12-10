import 'package:flutter/material.dart';

class UserDataModel {
   String name;
   String email;
   String phone;
   String password;
   String uid;
   String type;
   String dis_mas;
   String image;
   String section;

  UserDataModel(
      {@required this.phone,
      @required this.email,
      @required this.name,
      @required this.password,
      @required this.uid,
       this.type,
       this.dis_mas,
       @required this.section,
      @required this.image});

  UserDataModel.fromJson(Map<String, dynamic> element) {
    name = element['name'];
    email = element['email'];
    phone = element['phone'];
    password = element['password'];
    uid = element['uid'];
    type = element['type'];
    dis_mas = element['dis_mas'];
    image = element['image'];
    section = element['section'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
      'uid': uid,
      'dis_mas': dis_mas,
      'type': type,
      'image': image,
      'section': section,
    };
  }
}
