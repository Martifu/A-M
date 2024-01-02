import 'package:cloud_firestore/cloud_firestore.dart';

class Letter {
  String id;
  String recipientId;
  String senderId;
  DateTime creationDate;
  int timesRead;
  String image;
  String backgroundColor;
  String textColor;
  double titleSize;
  double textSize;
  String titleColor;
  String title;
  String text;
  String titleFont;
  String textFont;
  String songUrl;
  //titleAlignment
  String? titleAlignment;
  //textAlignment
  String? textAlignment;

  String? spotifyUrl;
  String? youtubeUrl;
  String? songImage;
  String? songColor;

// B1t3Aicm6tXN9B9pRjekYTK3Atn1, VhBRNk4nIEgwk6l7oSoR81aqnPh2
  Letter(
      {required this.id,
      required this.recipientId,
      required this.senderId,
      required this.creationDate,
      required this.timesRead,
      required this.image,
      required this.backgroundColor,
      required this.textColor,
      required this.titleColor,
      required this.title,
      required this.text,
      required this.titleSize,
      required this.textSize,
      required this.titleFont,
      required this.textFont,
      required this.songUrl,
      required this.titleAlignment,
      required this.textAlignment,
      required this.spotifyUrl,
      required this.youtubeUrl,
      this.songImage,
      this.songColor});

  factory Letter.fromDocument(DocumentSnapshot doc) {
    return Letter(
      id: doc.id,
      recipientId: doc.get('recipient_id'),
      senderId: doc.get('sender_id'),
      creationDate: (doc.get('creation_date') as Timestamp).toDate(),
      timesRead: doc.get('times_read'),
      image: doc.get('image'),
      backgroundColor: doc.get('background_color'),
      textColor: doc.get('text_color'),
      titleColor: doc.get('title_color'),
      title: doc.get('title'),
      text: doc.get('text'),
      titleSize: doc.get('title_size'),
      textSize: doc.get('text_size'),
      titleFont: doc.get('title_font'),
      textFont: doc.get('text_font'),
      songUrl: doc.get('song_url'),
      titleAlignment: doc.get('title_alignment'),
      textAlignment: doc.get('text_alignment'),
      spotifyUrl: doc.get('spotify_url'),
      youtubeUrl: doc.get('youtube_url'),
      songImage: doc.get('song_image'),
      songColor: doc.get('song_color'),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'recipient_id': recipientId,
      'sender_id': senderId,
      'creation_date': creationDate,
      'times_read': timesRead,
      'image': image,
      'background_color': backgroundColor,
      'text_color': textColor,
      'title_color': titleColor,
      'title': title,
      'text': text,
      'title_size': titleSize,
      'text_size': textSize,
      'title_font': titleFont,
      'text_font': textFont,
      'song_url': songUrl,
      'title_alignment': titleAlignment,
      'text_alignment': textAlignment,
      'spotify_url': spotifyUrl,
      'youtube_url': youtubeUrl,
      'song_image': songImage,
      'song_color': songColor ?? '',
    };
  }

  factory Letter.fromSnapshot(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Letter(
      id: doc.id, // Aquí se asigna el id del documento
      recipientId: data['recipient_id'],
      senderId: data['sender_id'],
      creationDate: (data['creation_date'] as Timestamp).toDate(),
      timesRead: data['times_read'],
      image: data['image'],
      backgroundColor: data['background_color'],
      textColor: data['text_color'],
      titleColor: data['title_color'],
      title: data['title'],
      text: data['text'],
      titleSize: data['title_size'],
      textSize: data['text_size'],
      titleFont: data['title_font'],
      textFont: data['text_font'],
      songUrl: data['song_url'],
      titleAlignment: data['title_alignment'],
      textAlignment: data['text_alignment'],
      spotifyUrl: data['spotify_url'],
      youtubeUrl: data['youtube_url'],
      songImage: data['song_image'],
      songColor: data['song_color'],
    );
  }
}
