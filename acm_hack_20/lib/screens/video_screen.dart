import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoScreen extends StatefulWidget {
  static const String id = 'video_screen';

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  YoutubePlayerController _controller;

  Future<String> getId() async {
    final preferences = await SharedPreferences.getInstance();
    final videoId = preferences.getString('id');
    return videoId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lazy View',
          style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
        ),
        backgroundColor: Colors.green[900],
      ),
      body: FutureBuilder(
          future: getId(),
          builder: (context, snapshot) {
            while (snapshot.data == null) {
              return Center(child: CircularProgressIndicator());
            }
            String id = snapshot.data;
            _controller = YoutubePlayerController(
              initialVideoId: id,
              flags: YoutubePlayerFlags(
                mute: false,
                autoPlay: true,
              ),
            );
            return YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              onReady: () {
                print('Player is ready.');
              },
            );
          }),
    );
  }
}
