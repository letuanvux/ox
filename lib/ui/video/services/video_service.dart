import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/video.dart';

class VideoService
{
  static Future<List<Video>> getByChannel(String channelId, String apiKey) async {
    final response = await http.get(Uri.parse(
        'https://www.googleapis.com/youtube/v3/search?key=${apiKey}&channelId=${channelId}&part=snippet,id&order=date&maxResults=15'));

    if (response.statusCode == 200) {
      Iterable items = jsonDecode(response.body)['items'];
      List<Video> videos = items.map((video) => Video.fromJson(video)).toList();
      return videos;
    } else {
      throw Exception('Failed to load');
    }
  }
}