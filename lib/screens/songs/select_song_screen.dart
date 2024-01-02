import 'package:flutter/material.dart';
import 'package:jagvault/models/song.dart';
import 'package:provider/provider.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import 'songs_provider.dart';

class SelectSongScreen extends StatelessWidget {
  const SelectSongScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var songsProvider = context.watch<SongsProvider>();
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Scaffold(
        appBar: AppBar(
          leading: const SizedBox(),
          actions: [
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                songsProvider.stopSong();
                Navigator.pop(context);
              },
            ),
          ],
          title: const Text('Busca una canción'),
        ),
        body: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                hintText: 'Buscar canción',
              ),
              onChanged: (value) => songsProvider.searchTracks(value),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: songsProvider.songs.length,
                itemBuilder: (context, index) {
                  Song song = songsProvider.songs[index];
                  return song.previewUrl == null
                      ? const SizedBox()
                      : ListTile(
                          title: Text(songsProvider.songs[index].name),
                          subtitle: Text(songsProvider.songs[index].uri),
                          onTap: () async {
                            var artistName = song.artists.first.name;
                            var tempSongName = song.name;
                            String? image = song.album.images.first.url;
                            final tempSongColor = await songsProvider
                                .getImagePalette(NetworkImage(image));
                            //get hex color from palette
                            song.colorPalette = tempSongColor?.value
                                .toRadixString(16)
                                .substring(2, 8);
                            final yt = YoutubeExplode();
                            final video = (await yt.search
                                    .search("$tempSongName $artistName"))
                                .first;
                            final videoId = video.id.value;
                            song.youtubeUrl =
                                "https://www.youtube.com/watch?v=$videoId";

                            Navigator.pop(context, song);
                          },
                          trailing: IconButton(
                            icon: const Icon(Icons.play_arrow),
                            onPressed: () async {
                              await songsProvider.playPreviewSong(
                                  songsProvider.songs[index].previewUrl!);
                            },
                          ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
