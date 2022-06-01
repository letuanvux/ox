import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../commons/loading_progress.dart';
import '../themes.dart';

import 'helpers/lotto_helper.dart';
import 'models/bridge.dart';
import 'models/lotto.dart';
import 'models/prize.dart';
import 'prize_bridge_page.dart';
import 'prize_detail_page.dart';
import 'services/prize_service.dart';



class LottoTriplePage extends StatefulWidget {
  final Lotto lotto;
  final Prize? item;
  const LottoTriplePage({
    Key? key,
    required this.lotto,
    this.item,
  }) : super(key: key);

  @override
  _LottoTriplePageState createState() => _LottoTriplePageState();
}

class _LottoTriplePageState extends State<LottoTriplePage> {
  bool isLoading = false;
  bool isReverse = false;
  final itemService = PrizeService();
  late List<Prize> lstPrizes;
  late List<LottoBridge> lstBridges;

  Future<void> loadData() async {
    isLoading = true;
    lstPrizes = await itemService.getOldItems(
        widget.item!.lotto, widget.item!.drawtime, 10);
    try {
      lstBridges = await LottoHelper.getTriples(lstPrizes, isReverse);      
    } catch (ex) {
      print(ex.toString());
    }
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
            ])),
            actions: [
          Row(
            children: [
              const Text(
                'Has Reverse',
                style: TextStyle(fontSize: 13, color: Colors.black),
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
          )
        ],
      ),
      body: isLoading
          ? const LoadingProgress()
          : SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                  text: '${widget.lotto.code} |',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black54,
                                  ),
                                  children: [
                                TextSpan(
                                  text: ' ${widget.lotto.name}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.black54,
                                  ),
                                )
                              ])),
                              Text('Date: ' +DateFormat('dd-MM-yyyy').format(widget.item!.drawtime)),
                          ],
                        ),
                        InkWell(
                          child: Text(
                            'Find bridges',
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => PrizeBridgePage(
                                  lotto: widget.lotto,
                                  item: widget.item,
                                )));
                          },
                        ),
                      ],
                    ),
                  ),                  
                  lstBridges.isEmpty ? Text("Nothing") : ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(10),
                    scrollDirection: Axis.vertical,
                    itemCount: lstBridges.length,
                    itemBuilder: (BuildContext, index) {
                      return Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: LottoHelper.isHasNumber(widget.item!,
                                lstBridges[index].number, 3, false)
                            ? matchDecoration
                            : boxDecoration,
                        child: InkWell(
                          onTap: () {                      
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => PrizeDetailPage(
                                  lotto: widget.lotto,
                                  item: widget.item,
                                  bridge: lstBridges[index],
                                )));
                          },
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                  Text("${lstBridges[index].option!.getLocation()}"),
                                  Text("${lstBridges[index].prefix.getLocation()}"),
                                  Text("${lstBridges[index].suffix.getLocation()}"),
                                ],),
                                SizedBox(width: 5,),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('${lstBridges[index].days.toString()} days'),
                                    Text(DateFormat('dd-MM-yyyy')
                                        .format(lstBridges[index].fromtime)),
                                  ],
                                ),
                                SizedBox(width: 5,),
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
                                SizedBox(width: 5,),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [                          
                                    Text(LottoHelper.getNumberTriple(widget.item!, lstBridges[index]),
                                      style: TextStyle(fontSize: 20, color: Colors.green),                          
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
