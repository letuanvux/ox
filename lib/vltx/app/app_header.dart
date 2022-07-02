import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget {
  final String title;
  final String desc;
  final String subtitle;  
  const AppHeader({
    Key? key,
    required this.title,
    this.desc = '',
    this.subtitle = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          text: TextSpan(
            text: title,
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).colorScheme.primary,
            ),
            children: [
              const TextSpan(text: ' '),
              TextSpan(
                text: desc,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.black54,
                ),
              )
            ]
          )
        ),
        if (subtitle.isNotEmpty) ...[
          Text(
            subtitle,
            maxLines: 1, 
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.normal,
              fontStyle: FontStyle.italic,
              color: Colors.grey),
          ),
        ],
      ],
    );
  }
}
