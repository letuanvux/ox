import 'package:flutter/material.dart';

import '../themes.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final String desc;
  final VoidCallback press;
  const SectionTitle({
    Key? key,
    required this.title,
    this.desc ='',
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: VLTxTheme.defaultPadding),
      child: Row(      
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [        
          RichText(
            text: TextSpan(
              text: title,
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).colorScheme.primary,                
              ),
              children: [
                const TextSpan(text: ' '),
                TextSpan(
                  text: desc,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: Colors.black54,
                  ),
                )
              ]
            )
          ),
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
