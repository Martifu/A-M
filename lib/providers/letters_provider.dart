import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jagvault/constants/constants.dart';
import 'package:jagvault/models/letter.dart';
import 'package:jagvault/models/song.dart';

enum LetterType { received, sent }

class LettersProvider extends ChangeNotifier {
  LetterType _letterType = LetterType.received;

  final AudioPlayer audioPlayer = AudioPlayer();

  LetterType get letterType => _letterType;

  final fonts = [
    'OpenSans',
    'Circular',
    'GrandHotel',
    'Oswald',
    'Quicksand',
    'BeautifulPeople',
    'BeautyMountains',
    'BiteChocolate',
    'BlackberryJam',
    'BunchBlossoms',
    'CinderelaRegular',
    'Countryside',
    'Halimun',
    'LemonJelly',
    'QuiteMagicalRegular',
    'Tomatoes',
    'VeganStyle',
  ];

  TextStyle titleStyle = TextStyle(
    fontSize: 24,
    color: Colors.black.withOpacity(.8),
    fontFamily: 'Circular',
  );

  String title = 'Título';
  TextAlign titleAlignment = TextAlign.start;

  TextStyle textStyle = TextStyle(
    fontSize: 24,
    color: Colors.black.withOpacity(.8),
    fontFamily: 'Circular',
  );

  String text = 'Contenido';
  TextAlign textAlignment = TextAlign.start;

  Color backgroundColor = kBackgroundColor;

  XFile? image;

  bool isEditing = false;
  bool canEdit = false;

  bool newLetter = false;
  bool imageExiste = false;

  String urlImage = '';
  String urlSong = '';

  //user firebase
  User? user = FirebaseAuth.instance.currentUser;

  bool isPlaying = true;

  Letter? letter = Letter(
    id: '',
    recipientId: '',
    senderId: '',
    creationDate: DateTime.now(),
    timesRead: 0,
    image: '',
    backgroundColor: '',
    textColor: '',
    titleColor: '',
    title: '',
    text: '',
    titleSize: 0,
    textSize: 0,
    titleFont: '',
    textFont: '',
    songUrl: '',
    titleAlignment: '',
    textAlignment: '',
    spotifyUrl: '',
    youtubeUrl: '',
    songColor: '',
    songImage: '',
  );

  void playOrResumeSong() async {
    if (isPlaying) {
      await audioPlayer.pause();
      isPlaying = false;
    } else {
      await audioPlayer.resume();
      isPlaying = true;
    }
    notifyListeners();
  }

  void setLetterEdit(Letter? letter) {
    if (letter != null) {
      isPlaying = true;
      newLetter = false;
      image = null;

      urlImage = letter.image;
      imageExiste = false;
      if (letter.image != '') {
        imageExiste = true;
      }
      urlSong = letter.songUrl;
      // convert alignment string to enum
      titleAlignment = TextAlign.values.firstWhere(
          (e) => e.toString() == 'TextAlign.${letter.titleAlignment}');
      textAlignment = TextAlign.values.firstWhere(
          (e) => e.toString() == 'TextAlign.${letter.textAlignment}');
      this.letter = letter;
      titleStyle = TextStyle(
        fontSize: letter.titleSize,
        fontFamily: letter.titleFont,
        color: Color(int.parse('0xFF${letter.titleColor}')),
      );
      title = letter.title;
      textStyle = TextStyle(
        fontSize: letter.textSize,
        fontFamily: letter.textFont,
        color: Color(int.parse('0xFF${letter.textColor}')),
      );
      text = letter.text;
      backgroundColor = Color(int.parse('0xFF${letter.backgroundColor}'));

      audioPlayer.play(UrlSource(letter.songUrl));

      audioPlayer.onPlayerStateChanged.listen((event) {
        if (event == PlayerState.completed) {
          audioPlayer.stop();

          audioPlayer.play(UrlSource(letter.songUrl));
        }
      });
    } else {
      // isEditing = false;
      // canEdit = true;
      newLetter = true;
      image = null;
      urlImage = '';
      letter?.title = '';
      letter?.text = '';
      image = null;
      letter?.songUrl = '';
      textAlignment = TextAlign.start;
      titleAlignment = TextAlign.start;
      imageExiste = false;
      urlSong = '';
      titleStyle = titleStyle.copyWith(
        fontSize: 24,
        color: Colors.black.withOpacity(.8),
        fontFamily: 'Circular',
      );
      title = 'Título';
      textStyle = textStyle.copyWith(
        fontSize: 24,
        color: Colors.black.withOpacity(.8),
        fontFamily: 'Circular',
      );
      text = 'Contenido';
      backgroundColor = kBackgroundColor;
    }

    notifyListeners();
  }

  set letterType(LetterType letterType) {
    _letterType = letterType;
    notifyListeners();
  }

  void setTextStyle(TextStyle textStyle, String text, TextAlign align) {
    this.textStyle = textStyle;
    this.text = text;
    textAlignment = align;
    notifyListeners();
  }

  void setTitleStyle(TextStyle titleStyle, String title, TextAlign align) {
    this.titleStyle = titleStyle;
    this.title = title;
    titleAlignment = align;
    notifyListeners();
  }

  void setBackgroundColor(Color backgroundColor) {
    this.backgroundColor = backgroundColor;

    notifyListeners();
  }

  void setImage(XFile image) {
    urlImage = '';
    isEditing = false;
    imageExiste = true;
    letter?.image = '';
    this.image = image;
    notifyListeners();
  }

  void removeImage() {
    image = null;
    imageExiste = false;
    notifyListeners();
  }

  void setSong(Song song) {
    urlSong = song.previewUrl!;
    letter!.spotifyUrl = "https://open.spotify.com/track/${song.id}";
    letter!.youtubeUrl = song.youtubeUrl;
    letter!.songColor = song.colorPalette;
    letter!.songImage = song.album.images.first.url;
    notifyListeners();
  }
}
