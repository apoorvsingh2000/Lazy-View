import 'package:acm_hack_20/screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Page1 extends StatefulWidget {
  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  YoutubePlayerController _controller;
  HomeScreen homeScreen = new HomeScreen();

  Future<String> getId() async {
    final preferences = await SharedPreferences.getInstance();
    final videoId = preferences.getString('id');
    if (videoId == null) {
      return 'aqpUCfb7F3g';
    }
    return videoId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent[100],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Last Viewed...',
                  style: TextStyle(
                      fontFamily: 'Pacifico',
                      fontSize: 40.0,
                      color: Colors.green[900]),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
              ),
              Container(
                color: Colors.green[900],
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: FutureBuilder(
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
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> storeKeyword(String videoId) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('keyword', videoId);
  }
}
