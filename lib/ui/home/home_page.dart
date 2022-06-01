import 'package:flutter/material.dart';

import '../../configs/routes.dart';
import '../chat/messager_page.dart';
import '../commons/loading_progress.dart';
import '../commons/section_title.dart';
import '../lotto/models/lotto.dart';
import '../lotto/services/lotto_service.dart';
import '../themes.dart';
import 'components/event_meeting_tile.dart';
import 'components/lotto_drawer.dart';
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
      drawer: lottodrawer(lottos: lottos),
      appBar: AppBar(
        leading: Builder(builder: (context) {
          return IconButton(
            icon: Icon(Icons.swap_horiz_sharp, color: Colors.blueGrey[300]),
            onPressed: () =>
                Scaffold.of(context).openDrawer(), // <-- Opens drawer.
          );
        }),
        leadingWidth: 20,
        backgroundColor: Colors.white,
        toolbarHeight: 40,
        title: RichText(
            text: TextSpan(
                text: "Chúc bạn gặp ",
                style: TextStyle(
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
                  builder: (context) => MessagerPage()
                )
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.login,
                color: Theme.of(context).colorScheme.primary),
            onPressed: () {
              Navigator.pushNamed(context, VLTxRoutes.login);
            },
          ),
        ],
      ),
      body: isLoading ? const LoadingProgress() : SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // 1. Sự kiện nổi bật
            EventMeetingTile(items: EventMeeting.getFeaturedItems(),),
            // 2. Danh sach moi nhat
            SectionTitle(
              title: 'Kết quả',
              desc: 'mới nhất',
              press: () {},
            ),

            // 3. Danh sap sap toi
            SectionTitle(
            title: 'Xổ số',
            desc: 'sắp quay',
            press: () {},
          ),

            // 4. Tin tuc giai thuong

            // 5. Cau chuyen doi thuc
                                 
          ],
        ),
      ),
    );
  }
}


