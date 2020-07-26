import 'package:acm_hack_20/models/video_data.dart';
import 'package:acm_hack_20/screens/video_screen.dart';
import 'package:acm_hack_20/utilities/keys.dart';
import 'package:flutter/material.dart';
import 'package:acm_hack_20/models/video_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Results extends StatefulWidget {
  static const String id = 'results_screen';

  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  VideoData videoData = new VideoData();
  List<VideoItem> videoList = [];
  var keyword;

  @override
  void initState() {
    super.initState();
    this.getVideos();
  }

  Future<List<VideoItem>> getVideos() async {
    final prefs = await SharedPreferences.getInstance();
    final keyword = prefs.getString('keyword');
    var data = await videoData.getVideoData('$BASE_URL=$keyword');
    final items = data['items'];
    for (var item in items) {
      final title = item['snippet']['title'];
      final thumbnailUrl = item['snippet']['thumbnails']['medium']['url'];
      final videoId = item['id']['videoId'];
      final channelTitle = item['snippet']['channelTitle'];
      final publishedAt = item['snippet']['publishedAt'];
      VideoItem vid =
          VideoItem(title, thumbnailUrl, videoId, channelTitle, publishedAt);
      videoList.add(vid);
    }
    return videoList;
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
      backgroundColor: Colors.greenAccent[100],
      body: Column(
        children: <Widget>[
          Expanded(
            child: FutureBuilder(
                future: getVideos(),
                builder: (context, snapshot) {
                  while (snapshot.data == null) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return ListView.builder(
                      itemCount: 20,
                      itemBuilder: (context, index) {
                        VideoItem videoItem = snapshot.data[index];
                        return InkWell(
                          onTap: () {
                            storeId(videoItem.videoId);
                            Navigator.pushNamed(context, VideoScreen.id);
                          },
                          child: Card(
                            color: Colors.lightGreen[300],
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                      color: Colors.green[900],
                                      child: Padding(
                                          padding: EdgeInsets.all(4.0),
                                          child: Image.network(
                                              videoItem.thumbnailUrl))),
                                  SizedBox(
                                    height: 8.0,
                                  ),
                                  Text(
                                    videoItem.title,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0,
                                        color: Colors.green[900]),
                                  ),
                                  SizedBox(
                                    height: 8.0,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        videoItem.channelTitle,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue[700]),
                                      ),
                                      Text(
                                        videoItem.publishedAt.substring(0, 10),
                                        style: TextStyle(
                                            fontFamily: 'Pacifico',
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                }),
          ),
        ],
      ),
    );
  }

  Future<void> storeId(String videoId) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('id', videoId);
  }
}
