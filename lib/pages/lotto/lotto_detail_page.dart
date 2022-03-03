import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/material.dart';
import 'package:ox/pages/lotto/components/number_card.dart';

import '../../configs/themes.dart';
import '../../helpers/lotto_helper.dart';
import '../../models/long_number.dart';
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
import '../../models/lotto.dart';

class LottoDetailPage extends StatefulWidget {
  final Lotto lotto;
  const LottoDetailPage({Key? key, required this.lotto}) : super(key: key);

  @override
  _LottoDetailPageState createState() => _LottoDetailPageState();
}

class _LottoDetailPageState extends State<LottoDetailPage> {
  bool isLoading = false;
  final itemService = PrizeService();
  final lottoService = LottoService();
  final maxMissDayService = MaxMissDayService();

  late Prize? prize;
  late List<Prize> lstItems;
  late List<LongNumber> lstLongNumbers;
  late List<MaxMissDay> lstMaxMissDays;
  late List<PrizeNumber> lstNumbers;

  Future<void> loadData() async {
    isLoading = true;
    prize = await itemService.getLastest(widget.lotto.id);
    lstNumbers = LottoHelper.getPrizeNumbers(prize!.json);
    lstItems = await itemService.limitResults(widget.lotto.id, 60);
    lstLongNumbers = await LottoHelper.getLongNumbers(
        lstItems, widget.lotto.min, widget.lotto.max);
    lstMaxMissDays = await maxMissDayService.getByLotto(widget.lotto.id);    

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
            icon: Icon(Icons.book, color: Theme.of(context).colorScheme.primary),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => PrizeBridgePage(lotto: widget.lotto, item: prize,)
                ));
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
                          child: CountryPickerUtils.getDefaultFlagImage(CountryPickerUtils.getCountryByIsoCode(widget.lotto.country)),
                        ), 
                        Expanded(
                          child: Text('${widget.lotto.code} - ${widget.lotto.name}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 16
                            ),
                          ),
                        ),
                        IconButton(                          
                          icon: Icon(Icons.list_alt_sharp, color: Colors.white),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => PrizePage(
                                    lotto: widget.lotto,
                                  )));
                          },
                        ),                       
                      ],
                    ),
                  ),
                  // Prize
                  widget.lotto.isball
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
                                  number: item.number,
                                  color: Colors.red,
                                );
                              }).toList(),
                            ),
                          ),
                      )
                      : PrizeCard(item: prize!),
                  // Long Numbers    
                  LottoLongNumberCard(items: lstLongNumbers, maxDays: lstMaxMissDays,),
                ],
              ),
            ),
    );
  }
}
