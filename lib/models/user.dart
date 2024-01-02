import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String id;
  String name;
  String profilePicture;

  UserModel(
      {required this.id, required this.name, required this.profilePicture});

  factory UserModel.fromDocument(DocumentSnapshot doc) {
    return UserModel(
      id: doc.id,
      name: doc.get('name'),
      profilePicture: doc.get('profilePicture'),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'profilePicture': profilePicture,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      id: data['id'],
      name: data['name'],
      profilePicture: data['profilePicture'],
    );
  }
}
