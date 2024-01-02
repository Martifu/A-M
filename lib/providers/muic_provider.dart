// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/material.dart';
// import 'package:jagvault/models/song.dart';
// import 'package:mow/data/models/song.dart';
// import 'package:mow/data/repositories/music_repository.dart';

// // import 'package:movies_app/data/repositories/movie_repository.dart';
// // import 'package:movies_app/domain/usecases/get_movies.dart';
// // import 'package:movies_app/data/models/movie.dart';

// class MusicProvider with ChangeNotifier {
//   final AudioPlayer _audioPlayer = AudioPlayer();

//   String? title = 'WoM';

//   String? songPlaying = 'No song playing';
//   bool isPlaying = false;

//   List<Song> songs = [];

//   Future<void> searchTracks(String query) async {
//     songs = await _musicRepository.searchTracks(query);
//     notifyListeners();
//   }

//   Future<void> playSong(String url) async {
//     //Reproduce la canción y si ya está reproduciendo, la pausa
//     if (songPlaying != url) {
//       isPlaying = false;
//     }
//     if (isPlaying) {
//       await _audioPlayer.pause();
//       isPlaying = false;
//     } else {
//       songPlaying = url;
//       await _audioPlayer.play(UrlSource(url));
//       isPlaying = true;
//     }
//     notifyListeners();
//   }

//   Future<void> pauseSong() async {
//     await _audioPlayer.pause();
//     notifyListeners();
//   }

//   Future<void> stopSong() async {
//     await _audioPlayer.stop();
//     notifyListeners();
//   }
// }