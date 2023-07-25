import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Carta {
  String? title;
  String? content;
  Timestamp? date;
  Timestamp? unlockAt;

  Carta(
      {@required this.title,
      @required this.content,
      @required this.date,
      @required this.unlockAt});

  // Método para crear un objeto MyDataModel a partir de un documento de QuerySnapshot
  factory Carta.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    return Carta(
        title: snapshot.get('title')!,
        content: snapshot.get('content')!,
        date: snapshot.get('date')!,
        unlockAt: snapshot.get('unlockAt')!);
  }

  // Método para convertir una lista de QueryDocumentSnapshot a una lista de objetos MyDataModel
  static List<Carta> fromQuerySnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) => Carta.fromDocumentSnapshot(doc)).toList();
  }
}
