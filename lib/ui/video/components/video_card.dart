import 'package:flutter/material.dart';

import '../../themes.dart';
import '../models/video.dart';

class VideoCard extends StatelessWidget {
  const VideoCard({
    Key? key,
    required this.video,
  }) : super(key: key);

  final Video video;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: VLTxTheme.padding),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              const BorderRadius.all(Radius.circular(VLTxTheme.padding / 2)),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF282828).withOpacity(0.1),
              offset: Offset(2, 2),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ]),
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1.75,
            child: Image.network(
              video.thumbnailUrl!,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: VLTxTheme.padding),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: VLTxTheme.padding),
            child: Text(
              video.title!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: AssetImage("assets/images/logo.png"),
            ),
            title: Text(
              "Lotterix",
              style: Theme.of(context)
                  .textTheme
                  .caption!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}