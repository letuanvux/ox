import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../helpers/lotto_helper.dart';
import '../models/bridge.dart';
import '../models/prize.dart';
import 'number_bridge_card.dart';

class PrizeCard extends StatelessWidget {
  final Prize item;
  final LottoBridge? bridge;
  const PrizeCard({Key? key, required this.item, this.bridge})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var lstPrizeNumbers = LottoHelper.getPrizeNumbers(item.json);
    var groupMax = lstPrizeNumbers.reduce((a, b) => a.group > b.group ? a : b).group;
    var gr = lstPrizeNumbers.where((element) => element.group == 0).length;
    var serial = LottoHelper.getSerial(item.json);
    return SafeArea(
      child: Container(
        color: const Color(0xff0f9d58),
        padding: const EdgeInsets.all(3),
        child: Column(
          
          children: [
            Table(
              border: TableBorder.all(
                color: const Color(0xff0f9d58),
                width: 1,
              ),
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              columnWidths: const <int, TableColumnWidth>{
                0: FractionColumnWidth(.15),
                1: FlexColumnWidth(),
              },
              children: [
                if (item.code.isNotEmpty)
                  TableRow(
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 193, 226, 194),
                      ),
                      children: [
                        const Center(
                          child: Text('Date'),
                        ),
                        SizedBox(
                          height: 30,
                          child: Center(
                            child: Text(
                              DateFormat('dd-MM-yyyy').format(item.drawtime),
                              style: const TextStyle(
                                  //color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            ),
                          ),
                        ),
                      ]),
                if (serial.isNotEmpty)
                  TableRow(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      children: [
                        const Center(
                          child: Text('MS'),
                        ),
                        SizedBox(
                          height: 30,
                          child: Center(
                            child: Text(serial),
                          ),
                        ),
                      ]),
                for (var i = 0; i <= groupMax; i++)
                  i == 0
                      ? TableRow(
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 193, 226, 194),
                          ),
                          children: [
                              const Center(
                                child: Text('DB'),
                              ),
                              NumberBridgeCard(
                                prize: lstPrizeNumbers[i],
                                bridge: bridge,
                              ),
                            ])
                      : TableRow(
                          decoration: BoxDecoration(
                            color: i % 2 == 0 ? const Color.fromARGB(255, 193, 226, 194) : Colors.white,
                          ),
                          children: [
                              Center(
                                child: Text(i == 0 ? 'DB' : 'G$i'),
                              ),
                              GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: (i == 3 || i == 5)
                                      ? 3
                                      : lstPrizeNumbers
                                          .where((element) => element.group == i)
                                          .length,
                                  mainAxisExtent: 30,
                                ),
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: lstPrizeNumbers
                                    .where((element) => element.group == i)
                                    .length,
                                itemBuilder: (context, index) => Center(
                                  child: NumberBridgeCard(
                                      prize: lstPrizeNumbers
                                          .where((element) =>
                                              element.group == i &&
                                              element.position == index)
                                          .first,
                                      bridge: bridge),
                                ),
                              ),
                            ]),
                if (bridge != null)
                  TableRow(
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 193, 226, 194),
                      ),
                      children: [
                        const Center(
                          child: Text('Bridge'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                bridge!.number,
                                style: const TextStyle(
                                    color: Color(0xffcf475f),
                                    fontWeight: FontWeight.w800,
                                    fontSize: 16),
                              ),
                              Column(
                                children: [
                                  if (bridge!.option != null)...[
                                    Text('⁰'+bridge!.option!.getLocation()),
                                  ],
                                  Text('¹'+ bridge!.prefix.getLocation()),
                                  Text('²'+ bridge!.suffix.getLocation()),
                                ],
                              ),                            
                            ],
                          ),
                        ),
                      ])
              ],
            ),
          ],
        ),
      ),
    );
  }
}
