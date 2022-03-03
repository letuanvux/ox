import 'package:flutter/material.dart';

import '../../configs/routes.dart';
import '../../configs/themes.dart';
import '../../models/lotto.dart';
import '../../services/lotto_service.dart';
import '../widgets/app_search.dart';
import '../widgets/loading_progress.dart';

import 'package:country_pickers/country_pickers.dart';

import 'lotto_detail_page.dart';

class LottoPage extends StatefulWidget {
  const LottoPage({Key? key}) : super(key: key);

  @override
  _LottoPageState createState() => _LottoPageState();
}

class _LottoPageState extends State<LottoPage> {
  final itemService = LottoService();
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
        leadingWidth: 0,
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
            icon: Icon(Icons.help_outline_outlined,
                color: Theme.of(context).colorScheme.primary),
            onPressed: () {
              Navigator.pushNamed(context, VLTxRoutes.suggest);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          if (isLoading) const LoadingProgress(),
          AppSearch(
            text: keyword,
            onChanged: (text) => setState(() => keyword = text),
            hintText: 'Search lotto',
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
                      Container(
                        decoration: boxDecoration,
                        child: ListTile(
                          leading: CountryPickerUtils.getDefaultFlagImage(
                              CountryPickerUtils.getCountryByIsoCode(
                                  lstItems[index].country)),
                          title: Text(lstItems[index].code),
                          subtitle: Text(lstItems[index].name,
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.normal,
                                  fontStyle: FontStyle.italic)),                          
                          onTap: () =>
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => LottoDetailPage(
                                        lotto: lstItems[index],
                                      ))),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      )
                    ],
                  );
                })
        ]),
      ),
    );
  }
}
