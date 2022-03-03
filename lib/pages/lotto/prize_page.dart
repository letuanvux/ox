import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../configs/themes.dart';
import '../../models/lotto.dart';
import '../../models/prize.dart';
import '../../services/prize_service.dart';
import '../widgets/app_search.dart';
import '../widgets/loading_progress.dart';
import 'prize_detail_page.dart';

class PrizePage extends StatefulWidget {
  final Lotto? lotto;
  const PrizePage({Key? key, this.lotto}) : super(key: key);

  @override
  _PrizePageState createState() => _PrizePageState();
}

class _PrizePageState extends State<PrizePage> {
  final ScrollController _scrollController = ScrollController();
  final itemService = PrizeService();
  String keyword = '';
  bool isLoading = false, allloaded = false;
  List<Prize> lstItems = [];
  int page = 1;

  Future<void> loadData() async {
    if (allloaded) {
      return;
    }
    setState(() {
      isLoading = true;
    });
   
    var newItems = await itemService.search(widget.lotto!.id, page, limit: 20);
    if (newItems.isNotEmpty) {
      lstItems.addAll(newItems);
    }
    setState(() {
      isLoading = false;
      allloaded = newItems.isEmpty;
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 40,
        leading: Builder(builder: (context) {
          return IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.blueGrey[300]),
              onPressed: () => Navigator.of(context).pop());
        }),
        leadingWidth: 30,
        title: RichText(
            text: TextSpan(
                text: 'Lotto ',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.primary,
                ),
                children: const [
              TextSpan(
                text: 'Prizes',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Colors.black54,
                ),
              )
            ])),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh,
                color: Theme.of(context).colorScheme.primary),
            onPressed: () {},
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              if (isLoading) ...[
                LoadingProgress(),
              ],
              ListView.builder(
                padding: const EdgeInsets.all(8.0),
                  controller: _scrollController,
                  itemBuilder: (context, index) {
                    if (index < lstItems.length) {
                      return Column(
                        children: [
                          if (index == 0) ...[
                            AppSearch(
                              text: keyword,
                              onChanged: (text) =>
                                  setState(() => keyword = text),
                              hintText: 'Search prize',
                            ),
                            const ListTile(
                              title: Text(
                                'Drawtime/Numbers',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                          ],
                          Container(
                            decoration: boxDecoration,
                            child: ListTile(
                              leading: Text(
                                DateFormat('dd-MM-yyyy')
                                    .format(lstItems[index].drawtime),
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary),
                              ),
                              title: Text(lstItems[index].code),
                              subtitle: Text(
                                lstItems[index].numbers ?? '',
                                textAlign: TextAlign.justify,
                              ),
                              onTap: () => Navigator.of(context)
                                  .push(MaterialPageRoute(
                                      builder: (context) => PrizeDetailPage(
                                            lotto: widget.lotto!,
                                            item: lstItems[index],
                                          ))),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          )
                        ],
                      );
                    } else {
                      return Container(
                        width: constraints.maxWidth,
                        height: 50,
                        child: Center(child: Text('Nothing more to load.')),
                      );
                    }
                  },
                  itemCount: lstItems.length + (allloaded ? 1 : 0)),
            ],
          );
        },
      ),
    );
  }
}
