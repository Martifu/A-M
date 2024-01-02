import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:jagvault/models/song.dart';
import 'package:jagvault/services/music_service.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
// import 'package:movies_app/data/repositories/movie_repository.dart';
// import 'package:movies_app/domain/usecases/get_movies.dart';
// import 'package:movies_app/data/models/movie.dart';

class SongsProvider with ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();

  final MusicApiProvider _musicRepository = MusicApiProvider();

  String? title = 'WoM';

  String? songPlaying = 'No song playing';
  bool isPlaying = false;

  List<Song> songs = [];

  Future<void> searchTracks(String query) async {
    songs = await _musicRepository.searchTracks(query);
    notifyListeners();
  }

  Future<void> playPreviewSong(String url) async {
    //Reproduce la canción y si ya está reproduciendo, la pausa
    if (songPlaying != url) {
      isPlaying = false;
    }
    if (isPlaying) {
      await _audioPlayer.pause();
      isPlaying = false;
    } else {
      songPlaying = url;

      await _audioPlayer.play(UrlSource(url));
      _audioPlayer.onPlayerStateChanged.listen((event) {
        if (event == PlayerState.completed) {
          _audioPlayer.stop();

          _audioPlayer.play(UrlSource(url));
        }
      });
      isPlaying = true;
    }
    notifyListeners();
  }

  Future<void> pauseSong() async {
    await _audioPlayer.pause();
    notifyListeners();
  }

  Future<void> stopSong() async {
    await _audioPlayer.stop();
    notifyListeners();
  }

  Future<void> playSpotifyTrack(Song music) async {
    var artistName = music.artists.first.name ?? "";
    var tempSongName = music.name;
    String? image = music.album.images.first.url;
    final tempSongColor = await getImagePalette(NetworkImage(image));
    final yt = YoutubeExplode();
    final video = (await yt.search.search("$tempSongName $artistName")).first;
    final videoId = video.id.value;
    final url = "https://www.youtube.com/watch?v=$videoId";
    var manifest = await yt.videos.streamsClient.getManifest(videoId);
    var audioUrl = manifest.audioOnly.last.url;

    var streamManifest = await yt.videos.streamsClient.getManifest(videoId);
    var audioOnlyStreams = streamManifest.audioOnly;

    // Get the highest quality audio-only stream
    var audioStream = audioOnlyStreams.withHighestBitrate();

    // print(audioS);
    // await _audioPlayer.play(UrlSource(audioStream.url.toString()));
  }

  Future<Color?> getImagePalette(ImageProvider imageProvider) async {
    final PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(imageProvider);
    return paletteGenerator.dominantColor?.color;
  }
}
