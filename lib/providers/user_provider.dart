import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jagvault/models/user.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  UserModel? _userData;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get user => _user;
  UserModel? get userData => _userData;

  Future<void> loadUser() async {
    _user = _auth.currentUser; // Obtener el usuario actual
    if (_user != null) {
      try {
        DocumentSnapshot userSnapshot =
            await _firestore.collection('users').doc(_user!.uid).get();
        _userData = UserModel.fromDocument(userSnapshot);
      } catch (e) {
        // Manejo de errores, por ejemplo, si no se pueden cargar los datos
        print("Error loading user data: $e");
      }
    }
    notifyListeners(); // Notificar a los widgets que escuchan este provider
  }

  // Método para actualizar los datos del usuario
  Future<void> updateUserData(UserModel newData) async {
    if (_user != null) {
      await _firestore
          .collection('users')
          .doc(_user!.uid)
          .update(newData.toMap());
      _userData = newData; // Actualizar la información local
      notifyListeners(); // Notificar a los oyentes que los datos han cambiado
    }
  }

  // Agrega más métodos según sea necesario para tu lógica de negocio
}
