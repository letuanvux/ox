import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:io' show Platform;

import '../../configs/routes.dart';
import '../commons/app_search.dart';
import '../commons/loading_progress.dart';
import '../themes.dart';

import 'package:country_pickers/country_pickers.dart';

import 'components/lotto_card.dart';
import 'models/lotto.dart';
import 'prize_detail_page.dart';
import 'services/lotto_service.dart';
import 'services/prize_service.dart';

class LottoPage extends StatefulWidget {
  const LottoPage({Key? key}) : super(key: key);

  @override
  _LottoPageState createState() => _LottoPageState();
}

class _LottoPageState extends State<LottoPage> {
  final itemService = LottoService();
  final prizeService = PrizeService();
  String keyword = '';
  bool isLoading = false;
  late List<Lotto> lstItems;


  late BannerAd staticAd;
  bool staticAdLoaded = false;
  late BannerAd inlineAd;
  bool inlineAdLoaded = false;

  static const AdRequest request = AdRequest(
      // keywords: ['', ''],
      // contentUrl: '',
      // nonPersonalizedAds: false,
      );

  void loadStaticBannerAd() {
    staticAd = BannerAd(
      adUnitId: Platform.isIOS ? "ca-app-pub-3940256099942544/2934735716" : "ca-app-pub-3940256099942544/6300978111",
      size: AdSize.banner,
      request: request,
      listener: BannerAdListener(onAdLoaded: (ad) {
        setState(() {
          staticAdLoaded = true;
        });
      }, onAdFailedToLoad: (ad, error) {
        ad.dispose();
        print('ad failed to load ${error.message}');
      }),
    );
    staticAd.load();
  }

  void loadInlineBannerAd() {
    inlineAd = BannerAd(
      adUnitId: Platform.isIOS ? "ca-app-pub-3940256099942544/2934735716" : "ca-app-pub-3940256099942544/6300978111",
      size: AdSize.banner,
      request: request,
      listener: BannerAdListener(onAdLoaded: (ad) {
        setState(() {
          inlineAdLoaded = true;
        });
      }, onAdFailedToLoad: (ad, error) {
        ad.dispose();
        print('ad failed to load ${error.message}');
      }),
    );
    inlineAd.load();
  }

  Future<void> loadData() async {
    isLoading = true;
    lstItems = await itemService.getAllFuture();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    loadStaticBannerAd();
    loadInlineBannerAd();

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
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.primary,
                ),
                children: const [
              TextSpan(
                text: 'Items',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.black54,
                ),
              )
            ])),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_month,
                color: Theme.of(context).colorScheme.primary),
            onPressed: () {
              Navigator.pushNamed(context, VLTxRoutes.calendar);
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
                  if (staticAdLoaded) ...[
                    Container(
                      child: AdWidget(ad: staticAd),
                      width: staticAd.size.width.toDouble(),
                      height: staticAd.size.height.toDouble(),
                      alignment: Alignment.bottomCenter,
                    ),
                  ],
                
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
                              if (index == 0) ...[
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
                              ],
                              if (inlineAdLoaded && index == 5) ...[
                                Container(
                                  child: AdWidget(ad: inlineAd),
                                  width: inlineAd.size.width.toDouble(),
                                  height: inlineAd.size.height.toDouble(),
                                ),
                                const SizedBox(
                                  height: 5,
                                )
                              ],
                              LottoCard(
                                item: lstItems[index],
                                onTap: () async {
                                  var prize = await prizeService.getLastest(lstItems[index].id);
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => PrizeDetailPage(lotto: lstItems[index],item: prize,)
                                    )
                                  );
                                }, 
                              ),                              
                            ],
                          );
                        })
                      ]),
                    ),
              if (isLoading) ...[
                LoadingProgress(),
              ],
            ],
          );
        }
      )
    );
  }
}
