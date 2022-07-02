import 'package:flutter/material.dart';

import '../utils/utils.dart';

class AppTags extends StatefulWidget {
  final List<String>? items;
  const AppTags({Key? key, required this.items}) : super(key: key);

  @override
  State<AppTags> createState() => _AppTagsState();
}

class _AppTagsState extends State<AppTags> {
  @override
  Widget build(BuildContext context) {
    if (widget.items == null) {
      return Container();
    } else {
      return Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Align(
          alignment: Alignment.topLeft, 
          child: Wrap(
            spacing: 5,
            runSpacing: 0,
            children: Utils.buildWidget<String>(widget.items!, (i, value) {
              return Container(
                child: Text(widget.items![i]),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  //border: Border.all(color: Colors.blueAccent),
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8)              
                  ),
                ),
              );
              return Chip(
                key: ValueKey(i),
                label: Text(widget.items![i]),
                backgroundColor: Colors.grey.shade200,
                padding: const EdgeInsets.all(5),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8))),
              );
            }),
          ),
        ),
      );
    }
  }
}
