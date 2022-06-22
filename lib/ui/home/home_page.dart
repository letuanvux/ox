import 'package:flutter/material.dart';
import 'package:ox/ui/home/components/favorite_card.dart';

import '../../configs/routes.dart';
import '../chat/messager_page.dart';
import '../commons/app_header.dart';
import '../commons/loading_progress.dart';
import '../commons/section_title.dart';
import '../lotto/models/lotto.dart';
import '../lotto/services/lotto_service.dart';
import '../tabbar_page.dart';
import '../themes.dart';
import 'components/activity_tile.dart';
import 'components/feature_card.dart';
import 'components/comming_tile.dart';
import 'components/event_meeting_tile.dart';
import 'components/lastest_tile.dart';
import 'components/lotto_drawer.dart';
import 'components/trending_tile.dart';
import 'data/data.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final lottoService = LottoService();
  bool isLoading = false;
  late List<Lotto> lottos =[];


  Future<void> loadData() async {
    isLoading = true;
    lottos = await lottoService.getAllFuture();
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
      backgroundColor: VLTxTheme.kBgLightColor,
      drawer: LottoDrawer(lottos: lottos),
      appBar: AppBar(
        leading: Builder(builder: (context) {
          return IconButton(
            icon: Icon(Icons.swap_horiz_sharp, color: Colors.blueGrey[300]),
            onPressed: () =>
                Scaffold.of(context).openDrawer(), // <-- Opens drawer.
          );
        }),        
        backgroundColor: Colors.white,
        toolbarHeight: 40,
        title: RichText(
            text: TextSpan(
                text: "Chúc bạn gặp ",
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.black54,                  
                ),
                children: [
              TextSpan(
                text: 'vạn điều may',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,                  
                  color: Theme.of(context).colorScheme.primary,
                ),
              )              
            ])),
        actions: [
          IconButton(
            icon: Icon(Icons.message,
                color: Theme.of(context).colorScheme.primary),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const MessagerPage()
                )
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.login,
                color: Theme.of(context).colorScheme.primary),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SliverWithTabBar()
                )
              );
            },
          ),
        ],
      ),
      body: isLoading ? const LoadingProgress() : SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Sự kiện nổi bật
            EventMeetingTile(items: EventMeeting.getFeaturedItems(),),
            // 2. Danh sach moi nhat
            SectionTitle(
              title: 'Kết quả',
              desc: 'mới nhất',
              subtitle: 'Kết quả xổ số gần nhất',
              press: () {},
            ),
            LastestTile(items: lottos,),
            // 3. Danh sap sap toi
            SectionTitle(
              title: 'Xổ số',
              desc: 'sắp quay',
              subtitle: 'Kết quả sớm nhất',
              press: () {},
            ),
            CommingTile(items: lottos,),
            // 4. Tin tuc giai thuong    
            const AppHeader(
              title: 'Xổ số',
              desc: 'yêu thích',
              subtitle: 'Xổ số được mọi người yêu thích',                        
            ),
            TrendingTile(items: lottos,),
            ListView.separated(     
              shrinkWrap: true,                
              physics: const NeverScrollableScrollPhysics(),             
              itemCount: lottos.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(height: 0),
              itemBuilder: (context, index) {
                return FeatureCard(item: lottos[index]);
              }
            ), 
            ListView.separated(     
              shrinkWrap: true,                
              physics: const NeverScrollableScrollPhysics(),             
              itemCount: lottos.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(height: 0),
              itemBuilder: (context, index) {
                return FavoriteCard(
                  title: lottos[index].code,
                  subtitle: lottos[index].name,
                  country: lottos[index].country,
                  imgUrl: lottos[index].imgUrl,                  
                  color: VLTxTheme.getColor(lottos[index].color),
                  gradient: VLTxTheme.getColor(lottos[index].gradient),
                  onTab: () {}
                );
              }
            ),  
            // 5. Cau chuyen doi thuc
                                            
          ],
        ),
      ),
    );
  }
}


