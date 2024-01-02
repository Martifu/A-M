import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:jagvault/models/song.dart';

class MusicApiProvider {
  final baseUrl = 'https://api.spotify.com/v1';
  final clientId = '40c9864e2a664565801c20462b4d0b4e';
  final clientSecret = '9926614aa4e043ebad76ee618b3bc97e';

  String? _accessToken;
  int? _expiresAt;

  Future<String> getAccessToken() async {
    if (_accessToken != null &&
        _expiresAt! > DateTime.now().millisecondsSinceEpoch) {
      return _accessToken!;
    }

    final encodedCredentials =
        base64Encode(utf8.encode('$clientId:$clientSecret'));
    final response = await http
        .post(Uri.parse('https://accounts.spotify.com/api/token'), headers: {
      HttpHeaders.authorizationHeader: "Basic $encodedCredentials",
      HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded",
    }, body: {
      'grant_type': 'client_credentials',
    });
    log(response.body);
    final responseJson = json.decode(response.body);
    _accessToken = responseJson['access_token'];
    _expiresAt = (DateTime.now().millisecondsSinceEpoch +
            (responseJson['expires_in'] * 1000))
        .toInt();

    return _accessToken!;
  }

  Future<List<Song>> searchTracks(String query) async {
    final accessToken = await getAccessToken();

    final response = await http
        .get(Uri.parse('$baseUrl/search?q=$query&type=track'), headers: {
      HttpHeaders.authorizationHeader: "Bearer $accessToken",
    });
    log(response.body);
    print(response.body);
    var songs = jsonDecode(response.body);

    return songFromJson(jsonEncode(songs['tracks']['items']));
  }
}
