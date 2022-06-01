import 'package:flutter/material.dart';

import '../../themes.dart';
import 'shimmer.dart';

class VideoCardShimmer extends StatelessWidget {
  const VideoCardShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: VLTxTheme.defaultPadding),
        AspectRatio(
          aspectRatio: 1.75,
          child: Shimmer(),
        ),
        Padding(
          padding: const EdgeInsets.all(VLTxTheme.defaultPadding),
          child: SizedBox(
            height: 20,
            child: Shimmer(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: VLTxTheme.defaultPadding),
          child: SizedBox(
            height: 20,
            child: Shimmer(),
          ),
        ),
      ],
    );
  }
}