import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../vltx/vltx.dart';
import '../themes.dart';
import 'models/lotto.dart';
import 'models/lotto_mapping.dart';
import 'services/lotto_mapping_service.dart';
import 'lotto_crawl_page.dart';
import 'lotto_mapping_edit_page.dart';
import 'prize_calendar_page.dart';

class LottoMappingPage extends StatefulWidget {
  final Lotto lotto;
  const LottoMappingPage({Key? key, required this.lotto }) : super(key: key);

  @override
  _LottoMappingPageState createState() => _LottoMappingPageState();
}

class _LottoMappingPageState extends State<LottoMappingPage> {
  final itemService = LottoMappingService();
  String keyword = '';
  bool isLoading = false;
  late List<LottoMapping> lstItems;

  Future<void> loadData() async {
    isLoading = true;
    lstItems = await itemService.whereAsFuture(widget.lotto.id);
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
      appBar: AppBar(
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
                text: 'Lotto ',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.primary,
                ),
                children: const [
              TextSpan(
                text: 'Mappings',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Colors.black54,
                ),
              )
            ])),
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
              color: Theme.of(context).colorScheme.primary,
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => LottoMappingEditPage(
                        id: '',
                        lottoId: widget.lotto.id,
                      )));
            },
          ),
        ],
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [                  
                  SearchField(
                    text: keyword,
                    onChanged: (text) => setState(() => keyword = text),
                    hint: 'Search lotto',
                  ),
                  if (!isLoading)
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: lstItems.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            if (index == 0)
                              const ListTile(
                                title: Text(
                                  'Name/Url',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                            Slidable(
                              child: Container(
                                decoration: VLTxTheme.decoration,
                                child: ListTile(
                                  title: Text(lstItems[index].name),
                                  subtitle: Text(lstItems[index].url),
                                  trailing: const Icon(Icons.arrow_left),
                                  onTap: () =>
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) => LottoMappingEditPage(
                                                id: lstItems[index].id,
                                                lottoId: '',
                                              ))),
                                ),
                              ),
                              startActionPane: ActionPane(
                                motion: ScrollMotion(),
                                children: [                            
                                  SlidableAction(
                                    onPressed: (context) => {
                                      crawlItem(lstItems[index].id),
                                    },                              
                                    backgroundColor: Colors.blue,
                                    foregroundColor: Colors.white,
                                    icon: Icons.play_circle,
                                    label: 'Crawl',
                                  ),
                                  SlidableAction(
                                    onPressed: (context) => {
                                      viewPrizes(widget.lotto),
                                    },                              
                                    backgroundColor: Colors.orange,
                                    foregroundColor: Colors.white,
                                    icon: Icons.list,
                                    label: 'Prizes',
                                  ),
                                ],
                              ),  
                              endActionPane: ActionPane(
                                motion: ScrollMotion(),
                                children: [
                                  SlidableAction(                              
                                    onPressed: (ctx) => {
                                      showCupertinoDialog(
                                        context: context,
                                        builder: (_) => CupertinoAlertDialog(
                                          title: Text('Delete Item'),
                                          content: Text('Do you want to delete?'),
                                          actions: [
                                            CupertinoDialogAction(
                                              child: Text('Yes'),
                                              onPressed: () async {
                                                deleteItem(lstItems[index].id);
                                                Navigator.pop(context);
                                              },
                                            ),
                                            CupertinoDialogAction(
                                              child: Text('No'),
                                              onPressed: () async {
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        ),
                                        barrierDismissible: false,
                                      ),
                                    },
                                    backgroundColor: Colors.red,
                                    foregroundColor: Colors.white,
                                    icon: Icons.delete,
                                    label: 'Delete',
                                  ),
                                  SlidableAction(
                                    onPressed: (ctx) => {
                                      editItem(lstItems[index].id, widget.lotto.id),
                                    },                              
                                    backgroundColor: Colors.indigo,
                                    foregroundColor: Colors.white,
                                    icon: Icons.edit,
                                    label: 'Edit',
                                  ),                            
                                ],
                              ),                       
                            ),
                            const SizedBox(
                              height: 5,
                            )
                          ],
                        );
                      },
                    ),
                ],
              ),
            ),
            if (isLoading) ...[
              LoadingProgress(),
            ],
          ]
        );
      }),
    );
  }
  deleteItem(String id) {
    itemService.deleteItem(id);
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(
      content: Text('Item deleted.'),
    ));
  }

  editItem(String id, String lottoId) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => LottoMappingEditPage(id: id, lottoId: lottoId,)
      )
    );
  }

  crawlItem(String id) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => LottoCrawlPage(id: id,))
    );
  }

  viewPrizes(Lotto lotto) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => PrizeCalendarPage(lotto: lotto))
    );
  }
}
