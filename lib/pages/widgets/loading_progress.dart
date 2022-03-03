
import 'package:flutter/material.dart';

class LoadingProgress extends StatelessWidget {
  final content = 'Loading...';

  const LoadingProgress({
    Key? key,
    String? content
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Center(child: LinearProgressIndicator()),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(content,
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),                  
      ],
    );
  }
}