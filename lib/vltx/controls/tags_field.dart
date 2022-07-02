import 'package:flutter/material.dart';

import '../controls/text_field.dart';
import '../utils/utils.dart';

class TagsField extends StatefulWidget {
  final TextEditingController controller;
  final List<String>? items;
  const TagsField({Key? key, required this.items, required this.controller})
      : super(key: key);

  @override
  State<TagsField> createState() => _TagsFieldState();
}

class _TagsFieldState extends State<TagsField> {
  final textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        VLTxTextField(
          controller: widget.controller,
          keyboardType: TextInputType.text,
          hint: 'Từ khóa...',
          onChanged: (text) {
            if (text.length > 1) {
              var keys = text.split(",");
              if (keys.length > 1) {
                var newtag = text.split(",").first;
                if (newtag.isNotEmpty) {
                  setState(() {
                    widget.items!.add(newtag);
                    widget.controller.clear();
                  });
                }
              }
            }
          },
        ),
        if (widget.items != null) ...[          
          Wrap(
            children:
                Utils.buildWidget<String>(widget.items!, (i, value) {
              return Chip(key: ValueKey(i),
                label: Text(widget.items![i]),
                backgroundColor: Colors.amber.shade200,
                deleteIconColor: Colors.red,
                onDeleted: () {
                  setState(() {
                    widget.items!.removeAt(i);
                  });
                },
              );
            }),
          ),
        ],
      ],
    );
  }
}
