import 'package:cloud_firestore/cloud_firestore.dart';

class ToDoItem {
  String id;
  String title;
  String description;
  String titleColor;
  String descriptionColor;
  String backgroundColor;
  String image;
  bool completed;
  String creatorId;
  DateTime creationDate;
  DateTime? completionDate;

  ToDoItem({
    required this.id,
    required this.title,
    required this.description,
    required this.titleColor,
    required this.descriptionColor,
    required this.backgroundColor,
    required this.image,
    required this.completed,
    required this.creatorId,
    required this.creationDate,
    this.completionDate,
  });

  factory ToDoItem.fromDocument(DocumentSnapshot doc) {
    return ToDoItem(
      id: doc.id,
      title: doc.get('title'),
      description: doc.get('description'),
      titleColor: doc.get('title_color'),
      descriptionColor: doc.get('description_color'),
      backgroundColor: doc.get('background_color'),
      image: doc.get('image'),
      completed: doc.get('completed'),
      creatorId: doc.get('creator_id'),
      creationDate: (doc.get('creation_date') as Timestamp).toDate(),
      completionDate: doc.get('completion_date') == null
          ? null
          : (doc.get('completion_date') as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    var map = {
      'title': title,
      'description': description,
      'title_color': titleColor,
      'description_color': descriptionColor,
      'background_color': backgroundColor,
      'image': image,
      'completed': completed,
      'creator_id': creatorId,
      'creation_date': creationDate,
    };

    if (completionDate != null) {
      map['completion_date'] = completionDate!;
    }

    return map;
  }

  factory ToDoItem.fromMap(Map<String, dynamic> map) {
    return ToDoItem(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      titleColor: map['title_color'],
      descriptionColor: map['description_color'],
      backgroundColor: map['background_color'],
      image: map['image'],
      completed: map['completed'],
      creatorId: map['creator_id'],
      creationDate: map['creation_date'],
      completionDate: map['completion_date'],
    );
  }
}
