import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:country_pickers/country_pickers.dart';

import '../../vltx/vltx.dart';
import '../themes.dart';
import 'models/lotto.dart';
import 'services/lotto_service.dart';
import 'services/prize_service.dart';

import 'lotto_mapping_page.dart';
import 'prize_calendar_page.dart';
import 'lotto_edit_page.dart';
import 'prize_detail_page.dart';

class LottoManagePage extends StatefulWidget {
  const LottoManagePage({Key? key}) : super(key: key);

  @override
  _LottoManagePageState createState() => _LottoManagePageState();
}

class _LottoManagePageState extends State<LottoManagePage> {
  final itemService = LottoService();
  final prizeService = PrizeService();
  String keyword = '';
  bool isLoading = false;
  late List<Lotto> lstItems;

  Future<void> loadData() async {
    isLoading = true;
    lstItems = await itemService.getAllFuture();
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
                text: 'Items',
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
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => LottoEditPage()));
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
                                  'Country/Code',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                            Slidable(
                              key: const ValueKey(0),
                              startActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (context) => {
                                      mappingItem(lstItems[index]),
                                    },
                                    backgroundColor: Colors.blue,
                                    foregroundColor: Colors.white,
                                    icon: Icons.shuffle,
                                    label: 'Mapping',
                                  ),
                                  SlidableAction(
                                    onPressed: (context) => {
                                      viewPrizes(lstItems[index]),
                                    },
                                    backgroundColor: Colors.orange,
                                    foregroundColor: Colors.white,
                                    icon: Icons.list,
                                    label: 'Prizes',
                                  ),
                                ],
                              ),
                              endActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    // An action can be bigger than the others.
                                    onPressed: (ctx) => {
                                      showCupertinoDialog(
                                        context: context,
                                        builder: (_) => CupertinoAlertDialog(
                                          title: const Text('Delete Item'),
                                          content:
                                              const Text('Do you want to delete?'),
                                          actions: [
                                            CupertinoDialogAction(
                                              child: const Text('Yes'),
                                              onPressed: () async {
                                                deleteItem(lstItems[index].id);
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            CupertinoDialogAction(
                                              child: const Text('No'),
                                              onPressed: () async {
                                                Navigator.of(context).pop();
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
                                      editItem(lstItems[index]),
                                    },
                                    backgroundColor: Colors.indigo,
                                    foregroundColor: Colors.white,
                                    icon: Icons.edit,
                                    label: 'Edit',
                                  ),
                                ],
                              ),
                              child: Container(
                                decoration: VLTxTheme.decoration,
                                child: ListTile(
                                  leading:
                                      CountryPickerUtils.getDefaultFlagImage(
                                          CountryPickerUtils
                                              .getCountryByIsoCode(
                                                  lstItems[index].country)),
                                  title: Text(lstItems[index].code),
                                  subtitle: Text(lstItems[index].name,
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[600],
                                          fontWeight: FontWeight.normal,
                                          fontStyle: FontStyle.italic)),
                                  trailing: Transform.scale(
                                    scale: 0.65,
                                    child: CupertinoSwitch(
                                      value: lstItems[index].status,
                                      onChanged: (bool val) {
                                        setState(() {
                                          itemService.setStatus(
                                              lstItems[index].id, val);
                                        });
                                      },
                                    ),
                                  ),
                                  onTap: () async {
                                    var prize = await prizeService.getLastest(lstItems[index].id);
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => PrizeDetailPage(lotto: lstItems[index], prize: prize,)
                                      )
                                    );
                                  },                                  
                                ),
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
          ],
        );
      }),
    );
  }

  deleteItem(String id) {
    itemService.deleteItem(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Item deleted.'),
    ));
  }

  editItem(Lotto item) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => LottoEditPage(
              lotto: item,
            )));
  }

  mappingItem(Lotto item) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => LottoMappingPage(lotto: item)));
  }

  viewPrizes(Lotto item) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PrizeCalendarPage(lotto: item)));
  }
}
