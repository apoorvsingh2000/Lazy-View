class VideoItem {
  final title;
  final thumbnailUrl;
  final videoId;
  final channelTitle;
  final publishedAt;

  VideoItem(this.title, this.thumbnailUrl, this.videoId, this.channelTitle,
      this.publishedAt);

//  @override
//  Widget build(BuildContext context) {
//    return Card(
//      child: Column(
//        children: <Widget>[
//          Image.network(thumbnailUrl),
//          Text(title),
//          Text(channelTitle),
//          Text(publishedAt.substring(0, 10))
//        ],
//      ),
//    );
//  }
}
