import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  final String url;

  NetworkHelper({this.url});

  Future getData() async {
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}
//FutureBuilder(
//future: getVideos(),
//builder: (context, snapshot) {
//return ListView.builder(
//itemCount: snapshot.data.length,
//itemBuilder: (BuildContext context, int index) {
//return Card(
//child: Column(
//children: <Widget>[
//Image.network(snapshot.data[index].thumbnailUrl),
//Text(snapshot.data[index].title),
//Text(snapshot.data[index].channelTitle),
//Text(snapshot.data[index].publishedAt.substring(0, 10)),
//],
//),
//);
//},
//);
//});
