import 'package:cloud_firestore/cloud_firestore.dart';

class Memory {
  String id;
  String creatorId;
  DateTime creationDate;
  List<String> images;
  List<String> videos;
  String title;
  String text;
  String backgroundColor;
  String titleColor;
  String textColor;
  DateTime memoryDate;

  Memory({
    required this.id,
    required this.creatorId,
    required this.creationDate,
    required this.images,
    required this.videos,
    required this.title,
    required this.text,
    required this.backgroundColor,
    required this.titleColor,
    required this.textColor,
    required this.memoryDate,
  });

  factory Memory.fromDocument(DocumentSnapshot doc) {
    return Memory(
      id: doc.id,
      creatorId: doc.get('creator_id'),
      creationDate: (doc.get('creation_date') as Timestamp).toDate(),
      images: List<String>.from(doc.get('images')),
      videos: List<String>.from(doc.get('videos')),
      title: doc.get('title'),
      text: doc.get('text'),
      backgroundColor: doc.get('background_color'),
      titleColor: doc.get('title_color'),
      textColor: doc.get('text_color'),
      memoryDate: (doc.get('memory_date') as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'creator_id': creatorId,
      'creation_date': creationDate,
      'images': images,
      'videos': videos,
      'title': title,
      'text': text,
      'background_color': backgroundColor,
      'title_color': titleColor,
      'text_color': textColor,
      'memory_date': memoryDate,
    };
  }

  factory Memory.fromMap(Map<String, dynamic> map) {
    return Memory(
      id: map['id'],
      creatorId: map['creator_id'],
      creationDate: map['creation_date'],
      images: map['images'],
      videos: map['videos'],
      title: map['title'],
      text: map['text'],
      backgroundColor: map['background_color'],
      titleColor: map['title_color'],
      textColor: map['text_color'],
      memoryDate: map['memory_date'],
    );
  }
}
