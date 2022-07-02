import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/colors.dart';

class VLTxEditorField extends StatefulWidget {
  final TextEditingController? controller;
  final String content;
  final Function(String)? onChanged;
  final Function(String?)? onSaved;
  final Function(String)? onFieldSubmitted;
  final Function(String?)? validator;
  const VLTxEditorField(
      {Key? key,
      required this.content,
      this.controller,
      this.onChanged,
      this.onSaved,
      this.onFieldSubmitted,
      this.validator})
      : super(key: key);

  @override
  State<VLTxEditorField> createState() => _VLTxEditorFieldState();
}

class _VLTxEditorFieldState extends State<VLTxEditorField> {
  QuillController _detailController = QuillController.basic();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();    
    if (widget.content.isNotEmpty) {
      var myJSON = jsonDecode(widget.content);
      _detailController = QuillController(
        document: Document.fromJson(myJSON),
        selection: TextSelection.collapsed(offset: 0),
      );
    } else {
      _detailController = QuillController.basic();
    }

    _detailController.document.changes.listen((event) {
      widget.controller!.text = jsonEncode(_detailController.document.toDelta().toJson());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 8,),
        Container(
          width: double.infinity,
          child: QuillToolbar.basic(
            controller: _detailController,
            toolbarIconAlignment : WrapAlignment.start
          ),
          decoration: BoxDecoration(
            border: Border.all(color: VLTxColors.lightGrey),
            borderRadius: BorderRadius.circular(
              ScreenUtil().setWidth(5.0),
            ),
          ),
        ),
        Container(
          height: 300,
          decoration: BoxDecoration(
            color: VLTxColors.blueGrey,
            border: Border.all(color: Colors.transparent,),
            borderRadius: BorderRadius.circular(
              ScreenUtil().setWidth(5.0),
            ),
          ),
          child: QuillEditor.basic(
            controller: _detailController,
            readOnly: false, // true for view only mode
          ),
        ),
      ],
    );
  }
}
