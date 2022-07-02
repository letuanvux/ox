import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../vltx/vltx.dart';

import '../themes.dart';
import 'models/contest.dart';
import 'services/contest_service.dart';

class ContestEditPage extends StatefulWidget {
  final Contest? item;
  const ContestEditPage({Key? key, this.item}) : super(key: key);

  @override
  State<ContestEditPage> createState() => _ContestEditPageState();
}

class _ContestEditPageState extends State<ContestEditPage> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final itemService = ContestService();

  final _lottoController = TextEditingController();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _imageController = TextEditingController();
  final _tagsController = TextEditingController();
  final _beginDateController = TextEditingController();
  final _finishDateController = TextEditingController();

  late List<String> tags = <String>[];

  final dateFormat = new DateFormat('dd/MM/yyyy');

  Future<void> loadData() async {
    isLoading = true;
    if (widget.item != null) {
      _lottoController.text = widget.item!.lotto;
      _titleController.text = widget.item!.title;
      _contentController.text = widget.item!.details;
      if (widget.item!.fromdate != null) {
        _beginDateController.text =
            dateFormat.format(widget.item!.fromdate!);
      }

      if (widget.item!.todate != null) {
        _finishDateController.text =
            dateFormat.format(widget.item!.todate!);
      }
      _imageController.text = widget.item!.imgUrl!;
      if (widget.item!.tags!.isNotEmpty) {
        tags = widget.item!.tags!.split(',');
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
    );
  }

  buildAppBar() {
    return AppBar(
      elevation: 4,
      backgroundColor: Colors.white,
      toolbarHeight: 40,
      leading: Builder(builder: (context) {
        return IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.blueGrey[300]),
            onPressed: () => Navigator.of(context).pop());
      }),
      leadingWidth: 20,
      title: RichText(
          text: TextSpan(
              text: 'Cuộc thi ',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).colorScheme.primary,
              ),
              children: [
            TextSpan(
              text: widget.item != null ? 'chỉnh sửa' : 'thêm mới',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.black54,
              ),
            )
          ])),
      actions: [
        if (widget.item != null) ...[
          IconButton(
              onPressed: () {
                showCupertinoDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CupertinoAlertDialog(
                        title: const Text('Please Confirm'),
                        content: const Text('Are you sure to remove it?'),
                        actions: [
                          // The "Yes" button
                          CupertinoDialogAction(
                            onPressed: () {
                              setState(() {
                                itemService.deleteItem(widget.item!.id);
                                Navigator.of(context).pop(true);
                              });
                            },
                            child: const Text('Yes'),
                            isDefaultAction: true,
                            isDestructiveAction: true,
                          ),
                          // The "No" button
                          CupertinoDialogAction(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('No'),
                            isDefaultAction: false,
                            isDestructiveAction: false,
                          )
                        ],
                      );
                    });
              },
              icon: Icon(Icons.delete_forever_sharp, color: Colors.red)),
        ],
        IconButton(
          icon: Icon(Icons.save, color: Theme.of(context).colorScheme.primary),
          onPressed: () {
            if (_formKey.currentState!.validate()) {              
              var item = Contest(
                lotto: _lottoController.text,
                title: _titleController.text,
                details: _contentController.text,
                fromdate: dateFormat.parse(_beginDateController.text),
                todate: dateFormat.parse(_finishDateController.text),
                imgUrl: _imageController.text,
                tags: tags.join(","),
              );

              if (widget.item == null) {
                itemService.addItem(item);
              } else {
                item.id = widget.item!.id;
                itemService.updateItem(item);
              }
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }

  buildBody() {
    return Stack(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.all(VLTxTheme.padding),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Photo
                AppPhoto(
                    controller: _imageController,
                    directory: 'contests',
                    defaultImage: VLTxTheme.logoImage,
                    url: widget.item != null ? widget.item!.imgUrl : null),
                SizedBox(
                  height: 10,
                ),
                VLTxTextField(
                  keyboardType: TextInputType.text,
                  controller: _titleController,
                  hint: 'Tiêu đề',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter title';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: VLTxDateField(
                        controller: _beginDateController,
                        selectedDate: widget.item != null
                            ? widget.item!.fromdate
                            : DateTime.now(),
                        hint: 'Từ ngày',
                        helpText: 'Select begin date',
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: VLTxDateField(
                        controller: _finishDateController,
                        selectedDate: widget.item != null
                            ? widget.item!.todate
                            : DateTime.now(),
                        hint: 'Đến ngày',
                        helpText: 'Select finish date',
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                VLTxEditorField(
                  controller: _contentController,
                  content: widget.item != null ? widget.item!.details : '',
                ),
                SizedBox(
                  height: 10,
                ),
                TagsField(controller: _tagsController, items: tags),
              ],
            ),
          ),
        ),
        if (isLoading) ...[
          LoadingProgress(),
        ],
      ],
    );
  }
}
