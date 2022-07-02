import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/material.dart';

import 'views/prize_view_chat.dart';
import 'views/prize_view_info.dart';
import 'views/prize_view_summary.dart';

import '../themes.dart';
import 'helpers/lotto_helper.dart';
import 'models/bridge.dart';
import 'models/long_number.dart';
import 'models/lotto.dart';
import 'models/max_miss_day.dart';
import 'models/prize.dart';
import 'models/prize_number.dart';
import 'prize_bridge_page.dart';
import 'prize_page.dart';
import 'services/lotto_service.dart';
import 'services/max_miss_day_service.dart';
import 'services/prize_service.dart';

class PrizeDetailPage extends StatefulWidget {
  final Lotto lotto;
  final Prize? prize;
  final LottoBridge? bridge;
  const PrizeDetailPage(
      {Key? key, this.prize, this.bridge, required this.lotto})
      : super(key: key);

  @override
  State<PrizeDetailPage> createState() => _PrizeDetailPageState();
}

class _PrizeDetailPageState extends State<PrizeDetailPage> with TickerProviderStateMixin {
  bool isLoading = false;

  late TabController tabController;
  int currentTabIndex = 0;

  void onTabChange() {
    setState(() {
      currentTabIndex = tabController.index;
    });
  }

  final itemService = PrizeService();
  final lottoService = LottoService();
  final maxMissDayService = MaxMissDayService();
  late Prize item;

  late List<Prize> lstItems;
  late List<LongNumber> lstLongNumbers;
  late List<MaxMissDay> lstMaxMissDays;
  late List<Prize> lstLastestPrizes;
  late List<PrizeNumber> lstNumbers;

  Future<void> loadData() async {
    isLoading = true;
    item = (widget.prize ?? await itemService.getLastest(widget.lotto.id))!;
    lstNumbers = LottoHelper.getPrizeNumbers(item.json);
    lstLastestPrizes =
        await itemService.getOldItems(item.lotto, item.drawtime, 5);

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: Colors.white,
              expandedHeight: 150.0,
              floating: false,
              pinned: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black38),
                onPressed: () => Navigator.of(context).pop()
              ),
              actions: [
                IconButton(
                  padding: const EdgeInsets.all(0),
                  icon: Icon(
                    Icons.calendar_month_outlined, 
                    color: Theme.of(context).colorScheme.primary
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PrizePage(
                              lotto: widget.lotto,
                            )));
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.bar_chart, 
                    color: Theme.of(context).colorScheme.primary
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PrizeBridgePage(
                              lotto: widget.lotto,
                              item: item,
                            )));
                  },
                ),
              ],  
              flexibleSpace: FlexibleSpaceBar(
                //centerTitle: true,
                expandedTitleScale: 1, 
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(VLTxTheme.radius /2),
                                topLeft: Radius.circular(VLTxTheme.radius /2 )),
                      child: CountryPickerUtils.getDefaultFlagImage(
                                                  CountryPickerUtils.getCountryByIsoCode(
                                                      widget.lotto.country)),
                    ), 
                    const SizedBox(width: 5,),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                            text: widget.lotto.code,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            children: [
                              TextSpan(
                                text: ' - ${widget.lotto.name}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black54,
                                ),
                              )
                            ]),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),                      
                  ],
                ),
                background: Image.asset(                    
                  widget.lotto.imgUrl.isEmpty ? 'assets/images/logo.png' : widget.lotto.imgUrl,                        
                  fit: BoxFit.cover,
                ),
              ),
            ),              
            SliverPersistentHeader(
              delegate: _SliverAppBarDelegate(
                TabBar(
                  labelStyle: const TextStyle(
                    fontSize: 12
                  ),
                  labelColor: Theme.of(context).colorScheme.primary,   
                  unselectedLabelColor: Colors.black38, 
                  controller: tabController, 
                  tabs: const [
                    Tab(
                      icon: Text('Thông tin',), 
                    ),
                    Tab(
                      icon: Text('Thống kê',), 
                    ), 
                    Tab(
                      icon: Text('Thảo luận',), 
                    ),                                                                      
                  ],
                ),
              ),
              pinned: true,
            ),
          ];
        },
        body: Container(
          padding: const EdgeInsets.all(10.0),
          child:  TabBarView(
            controller: tabController,
            children: [
              // Prize Info 
              PrizeViewInfo(lotto: widget.lotto, prize: item, items: lstNumbers, bridge: widget.bridge),                
              // Summary
              PrizeViewSummary(lotto: widget.lotto, drawtime: item.drawtime),
              // Summary
              const PrizeViewChat(),
            ]
          )
        )
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
     color: Colors.white,
      child:_tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}