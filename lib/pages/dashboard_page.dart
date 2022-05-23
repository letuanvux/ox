import 'package:flutter/material.dart';
import 'package:ox/pages/chat/messager_page.dart';

import '../configs/routes.dart';
import '../models/lotto.dart';
import '../services/lotto_service.dart';
import 'widgets/loading_progress.dart';
import 'widgets/lotto_drawer.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({Key? key}) : super(key: key);

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
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
                text: "Welcome ",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
                children: [
              TextSpan(
                text: 'your dreams',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
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
      body: isLoading
          ? const LoadingProgress()
          : SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
                     
          ],
        ),
      ),
    );
  }
}


