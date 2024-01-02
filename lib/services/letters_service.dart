import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:jagvault/models/letter.dart';

class LettersService extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Usuario actual (asegúrate de manejar la autenticación adecuadamente)

  //recibidas
  Stream<List<Letter>> receivedLetters(String userId) {
    return _db
        .collection('letters')
        .where('recipient_id', isEqualTo: userId)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Letter.fromDocument(doc)).toList());
  }

  //enviadas

  Stream<List<Letter>> sentLetters(String userId) {
    return _db
        .collection('letters')
        .where('sender_id', isEqualTo: userId)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Letter.fromDocument(doc)).toList());
  }

  //crear carta
  Future<void> createLetter(Letter letter) {
    return _db.collection('letters').doc().set(letter.toMap());
  }

  //upload image to firebase storage
  Future<String> uploadImage(File image) async {
    var fileName = image.path.split('/').last;
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('uploads/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(image);
    TaskSnapshot taskSnapshot = await uploadTask;
    taskSnapshot.ref.getDownloadURL().then(
          (value) => print("Done: $value"),
        );
    return taskSnapshot.ref.getDownloadURL();
  }

  //update letter and image
  Future<void> updateLetter(Letter letter) {
    return _db
        .collection('letters')
        .doc(letter.id)
        .update(letter.toMap())
        .then((value) {})
        .catchError((error) => print("Failed to update letter: $error"));
  }
}
