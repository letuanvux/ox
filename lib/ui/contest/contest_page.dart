import 'package:flutter/material.dart';

import '../../vltx/vltx.dart';

import '../themes.dart';
import 'contest_detail_page.dart';
import 'models/contest.dart';
import 'services/contest_service.dart';
import 'contest_edit_page.dart';

class ContestPage extends StatefulWidget {
  const ContestPage({Key? key}) : super(key: key);

  @override
  State<ContestPage> createState() => _ContestPageState();
}

class _ContestPageState extends State<ContestPage> {
  bool isLoading = false;

  final itemService = ContestService();
  String keyword = '';
  List<Contest> lstItems = [];

  final ScrollController _scrollController = ScrollController();
  bool allloaded = false;
  int page = 1;

  Future<void> loadData() async {
    if (allloaded) {
      return;
    }
    setState(() {
      isLoading = true;
    });

    var newItems = await itemService.paging(keyword, page);
    if (newItems.isNotEmpty) {
      lstItems.addAll(newItems);
    }

    setState(() {
      allloaded = newItems.isEmpty;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent &&
          !isLoading) {
        page++;
        loadData();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
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
      leadingWidth: 0,
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
              text: 'thông báo',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.black54,
              ),
            )
          ])),
      actions: [
        IconButton(
          icon: Icon(Icons.add, color: Theme.of(context).colorScheme.primary),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => ContestEditPage()));
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
            children: [
              SearchField(
                text: keyword,
                onChanged: (text) => setState(() {
                  keyword = text;
                }),
                hint: 'Tìm kiếm',
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(bottom: VLTxTheme.padding),
                  controller: _scrollController,
                  itemBuilder: (context, index) {
                    if (index < lstItems.length) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            decoration: VLTxTheme.decoration,
                            child: ListTile(
                              minLeadingWidth: 0,
                              //ignore: sized_box_for_whitespace                              
                              leading: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(VLTxTheme.radius)
                                ),
                                child: Container(
                                  height: 60.0,
                                  width: 80.0, // fixed width and height
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: VLTxTheme.image(lstItems[index].imgUrl ?? VLTxTheme.logoImage),
                                      fit: BoxFit.cover
                                    )
                                  ),
                                ),
                              ),
                              title: Text(
                                lstItems[index].title,
                              ),
                              subtitle: Text(
                                lstItems[index].lotto,
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                              trailing: IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ContestEditPage(item: lstItems[index]))),
                              ), 
                              selected: false,
                              onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ContestDetailPage(item: lstItems[index]))),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return page > 1
                          ? SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: const Center(
                                  child: Text('Nothing more to load.')),
                            )
                          : SizedBox();
                    }
                  },
                  itemCount: lstItems.length + (allloaded ? 1 : 0)),
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
