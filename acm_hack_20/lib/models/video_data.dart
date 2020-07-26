import 'networking.dart';

class VideoData {
  Future<dynamic> getVideoData(String url) async {
    NetworkHelper networkHelper = NetworkHelper(url: url);

    var videoData = await networkHelper.getData();
    return videoData;
  }
}
