import 'package:flutter/material.dart';

import '../../themes.dart';
import 'shimmer.dart';

class VideoCardShimmer extends StatelessWidget {
  const VideoCardShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        SizedBox(height: VLTxTheme.padding),
        AspectRatio(
          aspectRatio: 1.75,
          child: Shimmer(),
        ),
        Padding(
          padding: EdgeInsets.all(VLTxTheme.padding),
          child: SizedBox(
            height: 20,
            child: Shimmer(),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: VLTxTheme.padding),
          child: SizedBox(
            height: 20,
            child: Shimmer(),
          ),
        ),
      ],
    );
  }
}