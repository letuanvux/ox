import 'package:flutter/material.dart';
import 'package:ox/ui/commons/app_header.dart';

import '../themes.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final String desc;
  final String subtitle;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? press;
  const SectionTitle({
    Key? key,
    required this.title,
    this.desc = '',
    this.subtitle = '',
    this.padding = null,
    this.press = null, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: VLTxTheme.padding),
      child: Row(      
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [        
          AppHeader(title: title, desc: desc, subtitle: subtitle,),
          GestureDetector(
            onTap: press,
            child: Text(
              'Xem thêm', 
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
