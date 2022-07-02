import 'package:flutter/material.dart';

import '../constants.dart';
import 'components/video_card.dart';
import 'components/video_card_shimmer.dart';

import 'models/video.dart';
import 'services/video_service.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({Key? key}) : super(key: key);

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late Future<List<Video>> futureVideos;
  @override
  void initState() {
    futureVideos = VideoService.getByChannel(VLTx.channelId, VLTx.apiKey);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (context) {
          return IconButton(
            icon: Icon(Icons.swap_horiz_sharp, color: Colors.blueGrey[300]),
            onPressed: () =>
                Scaffold.of(context).openDrawer(), // <-- Opens drawer.
          );
        }),
        leadingWidth: 20,
        backgroundColor: Colors.white,
        toolbarHeight: 40,
        title: RichText(
          text: TextSpan(
              text: 'Lotto ',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).colorScheme.primary,
              ),
              children: const [
            TextSpan(
              text: 'Videos',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.black54,
              ),
            )
          ])
        ),
      ),
      body: SafeArea(
        child: FutureBuilder<List<Video>>(
          future: futureVideos,
          builder: (context, snapshot) => snapshot.hasData
              ? ListView.builder(
                  clipBehavior: Clip.none,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) =>
                      VideoCard(video: snapshot.data![index]),
                )
              : ListView.builder(
                  itemCount: 2,
                  itemBuilder: (context, index) => VideoCardShimmer(),
                ),
        ),
      ),
    );
  }
}


