import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/material.dart';
import '../../helpers/lotto_helper.dart';
import '../../models/bridge.dart';
import '../../models/long_number.dart';
import '../../models/lotto.dart';
import '../../models/max_miss_day.dart';
import '../../models/prize.dart';
import '../../services/lotto_service.dart';
import '../../services/max_miss_day_service.dart';
import '../../services/prize_service.dart';
import '../widgets/loading_progress.dart';
import 'components/lotto_summary_card.dart';
import 'components/prize_ball_card.dart';
import 'components/prize_card.dart';
import 'prize_bridge_page.dart';
import 'prize_page.dart';

class PrizeDetailPage extends StatefulWidget {
  final Lotto lotto;
  final Prize? item;
  final LottoBridge? bridge;
  const PrizeDetailPage({Key? key, this.item, this.bridge, required this.lotto})
      : super(key: key);

  @override
  _PrizeDetailPageState createState() => _PrizeDetailPageState();
}

class _PrizeDetailPageState extends State<PrizeDetailPage> {
  bool isLoading = false;
  final itemService = PrizeService();
  final lottoService = LottoService();
  final maxMissDayService = MaxMissDayService();

  late List<Prize> lstItems;
  late List<LongNumber> lstLongNumbers;
  late List<MaxMissDay> lstMaxMissDays;
  late List<Prize> lstLastestPrizes;

  Future<void> loadData() async {
    isLoading = true;
    lstLastestPrizes = await itemService.getOldItems(
        widget.item!.lotto, widget.item!.drawtime, 5); 
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
                    height: 35,
                    color: Color(0xff0f9d58),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [                        
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: CountryPickerUtils.getDefaultFlagImage(
                              CountryPickerUtils.getCountryByIsoCode(
                                  widget.lotto.country)),
                        ),
                        Expanded(
                          child: Text(
                            '${widget.lotto.code} - ${widget.lotto.name}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 16),
                          ),
                        ),
                        IconButton(
                          padding: const EdgeInsets.all(0),
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
                      ? PrizeBallCard(prize: widget.item!, items: lstNumbers)
                      : PrizeCard(
                          item: widget.item!,
                          bridge: widget.bridge,
                        ),
                  // Summary
                  LottoSunmaryCard(lotto: widget.lotto, drawtime: widget.item!.drawtime),
                ],
              ),
            ),
    );
  }
}
