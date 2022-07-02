import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;

import '../../vltx/vltx.dart';

import '../themes.dart';
import 'models/contest.dart';

class ContestDetailPage extends StatefulWidget {
  final Contest item;
  const ContestDetailPage({ Key? key, required this.item }) : super(key: key);

  @override
  State<ContestDetailPage> createState() => _ContestDetailPageState();
}

class _ContestDetailPageState extends State<ContestDetailPage> {
  bool isLoading = false;
  late List<String> tags = [];

  QuillController _detailController = QuillController.basic();

  Future<void> loadData() async {
    isLoading = true;
    if (widget.item.details.isNotEmpty)
    {
      var myJSON = jsonDecode(widget.item.details);
      _detailController = QuillController(
          document: Document.fromJson(myJSON),
          selection: const TextSelection.collapsed(offset: 0)
        );
    }  
    // tags
    if (widget.item.tags!.isNotEmpty) {
      tags = widget.item.tags!.split(',');
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
          children: const [
            TextSpan(
              text: 'Bài đăng',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.black54,
              ),
            )
          ]
        )
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.save, color: Theme.of(context).colorScheme.primary),
          onPressed: () {
            
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              Stack(
                children: [
                  Container(
                    height: 100,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.07),
                      borderRadius: const BorderRadius.all(
                          Radius.circular(VLTxTheme.radius)),
                    ),
                  ),
                  Center(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                          Radius.circular(VLTxTheme.radius)),
                      child: Container(
                        height: 100,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: VLTxTheme.image(
                                    widget.item.imgUrl ?? VLTxTheme.logoImage),
                                fit: BoxFit.cover)),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              // Title
              Text(
                widget.item.title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),              
              // Content
              QuillEditor.basic(
                controller: _detailController,
                readOnly: true, // true for view only mode
              ),
              // Tags              
              AppTags(items: tags),
              // Bai viet lien quan

            ],
          ),
        ),
        if (isLoading) ...[
          LoadingProgress(),
        ],
      ],      
    );
  }
}