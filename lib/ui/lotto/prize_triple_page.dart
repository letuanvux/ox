import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../vltx/vltx.dart';
import '../themes.dart';

import 'helpers/lotto_helper.dart';
import 'models/bridge.dart';
import 'models/lotto.dart';
import 'models/prize.dart';
import 'prize_bridge_page.dart';
import 'prize_detail_page.dart';
import 'services/prize_service.dart';



class PrizeTriplePage extends StatefulWidget {
  final Lotto lotto;
  final Prize? item;
  const PrizeTriplePage({
    Key? key,
    required this.lotto,
    this.item,
  }) : super(key: key);

  @override
  _PrizeTriplePageState createState() => _PrizeTriplePageState();
}

class _PrizeTriplePageState extends State<PrizeTriplePage> {
  final itemService = PrizeService();
  bool isLoading = false;
  bool isReverse = false;
  bool isUnique = false;
  
  late List<Prize> lstPrizes;
  late List<LottoBridge> lstBridges;
  late Prize? matchPrize;

  Future<void> loadData() async {
    isLoading = true;
    lstPrizes = await itemService.getByMaxDate(
        widget.item!.lotto, widget.item!.drawtime, 10);
    lstBridges = await LottoHelper.getTriples(lstPrizes, isReverse, isUnique);    
    
    matchPrize = await itemService.getNextPrize(
        widget.item!.lotto, widget.item!.drawtime);
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
                text: 'Triples',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Colors.black54,
                ),
              )
            ]
          )
        ),
        actions: [
          TextButton(
            child: const Text('Find bridges'),
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
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Đảo ngược',
                            style:
                                TextStyle(fontSize: 13, color: Colors.black),
                          ),
                          Transform.scale(
                            scale: 0.7,
                            child: CupertinoSwitch(
                              value: isReverse,
                              onChanged: (bool value) {
                                setState(() {
                                  isLoading = true;
                                  isReverse = value;
                                });
                                loadData();
                                setState(() {
                                  isLoading = false;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            'Khác nhau',
                            style:
                                TextStyle(fontSize: 13, color: Colors.black),
                          ),
                          Transform.scale(
                            scale: 0.7,
                            child: CupertinoSwitch(
                              value: isUnique,
                              onChanged: (bool value) {
                                setState(() {
                                  isLoading = true;
                                  isUnique = value;
                                });
                                loadData();
                                setState(() {
                                  isLoading = false;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: RichText(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                            text: '${widget.lotto.code} |',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54,
                            ),
                            children: [
                              TextSpan(
                                text: ' ${widget.lotto.name}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.black54,
                                ),
                              )
                            ])),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Date: ' +
                          DateFormat('dd-MM-yyyy')
                              .format(widget.item!.drawtime)),
                      if (matchPrize != null) ...[
                        Text('Match Date: ' +
                            DateFormat('dd-MM-yyyy')
                                .format(matchPrize!.drawtime)),
                      ],
                    ],
                  ),

                
                  lstBridges.isEmpty ? const Text("Nothing") : ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(top: 10),
                    scrollDirection: Axis.vertical,
                    itemCount: lstBridges.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: matchPrize != null && LottoHelper.isHasNumber(matchPrize!,
                                lstBridges[index].nextnumber, 3, isReverse)
                            ? VLTxTheme.matchDecoration
                            : VLTxTheme.decoration,
                        child: InkWell(
                          onTap: () {                      
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => PrizeDetailPage(
                                  lotto: widget.lotto,
                                  prize: widget.item,
                                  bridge: lstBridges[index],
                                )));
                          },
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Material(
                                  textStyle: const TextStyle(fontSize: 12, color: Colors.black45),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(lstBridges[index].option!.getLocation()),
                                      Text(lstBridges[index].prefix.getLocation()),
                                      Text(lstBridges[index].suffix.getLocation()),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 5,),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('${lstBridges[index].days.toString()} days'),
                                    Text(DateFormat('dd-MM-yyyy')
                                        .format(lstBridges[index].fromtime)),
                                  ],
                                ),
                                const SizedBox(width: 5,),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(lstBridges[index].number),
                                      Text("${lstBridges[index].times} times"),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 5,),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [                          
                                    Text(lstBridges[index].nextnumber,
                                      style: const TextStyle(fontSize: 20, color: Colors.green),                          
                                    )
                                  ],
                                ),
                              ],
                            ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
