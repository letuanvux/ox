import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/material.dart';
import 'package:ox/pages/lotto/components/number_card.dart';

import '../../configs/themes.dart';
import '../../helpers/lotto_helper.dart';
import '../../models/bridge.dart';
import '../../models/long_number.dart';
import '../../models/lotto.dart';
import '../../models/max_miss_day.dart';
import '../../models/prize.dart';
import '../../models/prize_number.dart';
import '../../services/lotto_service.dart';
import '../../services/max_miss_day_service.dart';
import '../../services/prize_service.dart';
import '../widgets/loading_progress.dart';
import 'components/lotto_longnumber_card.dart';
import 'components/prize_card.dart';
import 'prize_bridge_page.dart';
import 'prize_page.dart';

class PrizeDetailPage extends StatefulWidget {
  final Lotto lotto;
  final Prize? item;
  final LottoBridge? bridge;
  const PrizeDetailPage({Key? key, this.item, this.bridge, required this.lotto}) : super(key: key);

  @override
  _PrizeDetailPageState createState() => _PrizeDetailPageState();
}

class _PrizeDetailPageState extends State<PrizeDetailPage> {
  bool isLoading = false;
  final itemService = PrizeService();
  final lottoService = LottoService();
  final maxMissDayService = MaxMissDayService();

  late Lotto lotto;
  late List<Prize> lstItems;
  late List<LongNumber> lstLongNumbers;
  late List<MaxMissDay> lstMaxMissDays;

  Future<void> loadData() async {
    isLoading = true;
    lotto = await lottoService.getOneFuture(widget.item!.lotto);
    lstItems = await itemService.getOldItems(
        widget.item!.lotto, widget.item!.drawtime, 60);
    lstLongNumbers =
        await LottoHelper.getLongNumbers(lstItems, lotto.min, lotto.max);
    lstMaxMissDays = await maxMissDayService.getByLotto(widget.item!.lotto);

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
    var lstNumbers = LottoHelper.getPrizeNumbers(widget.item!.json);

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
                text: 'Lotto Prize ',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.primary,
                ),
                children: const [
              TextSpan(
                text: 'Details',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Colors.black54,
                ),
              )
            ])),
        actions: [
          IconButton(
            icon:
                Icon(Icons.book, color: Theme.of(context).colorScheme.primary),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PrizeBridgePage(
                    lotto: widget.lotto,
                    item: widget.item,
                  )));
            },
          ),
        ],
      ),
      body: isLoading
          ? const LoadingProgress()
          : SingleChildScrollView(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  // Lotto Info
                  Container(
                    color: Color(0xff0f9d58),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: CountryPickerUtils.getDefaultFlagImage(
                              CountryPickerUtils.getCountryByIsoCode(
                                  lotto.country)),
                        ),
                        Expanded(
                          child: Text(
                            '${lotto.code} - ${lotto.name}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 16),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.list_alt_sharp, color: Colors.white),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => PrizePage(
                                      lotto: lotto,
                                    )));
                          },
                        ),
                      ],
                    ),
                  ),
                  // Prize
                  lotto.isball
                      ? Container(
                        decoration: boxDecoration,
                        padding: const EdgeInsets.all(5.0),
                        child: Center(
                            child: Wrap(
                              spacing: 3,
                              runSpacing: 3,
                              alignment: WrapAlignment.center,
                              children: lstNumbers.map((PrizeNumber item) {
                                return NumberCard(
                                    number: item.number, color: Colors.red);
                              }).toList(),
                            ),
                          ),
                      )
                      : PrizeCard(
                          item: widget.item!,
                          bridge: widget.bridge,
                        ),
                  LottoLongNumberCard(items: lstLongNumbers, maxDays: lstMaxMissDays,),
                ],
              ),
            ),
    );
  }
}
