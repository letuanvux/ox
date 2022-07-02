import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../vltx/vltx.dart';
import 'helpers/lotto_helper.dart';
import 'models/lotto.dart';
import 'services/lotto_service.dart';
import 'services/max_miss_day_service.dart';
import 'services/prize_service.dart';
import 'models/prize.dart';

import '../themes.dart';
import 'prize_detail_page.dart';

class PrizeCalendarPage extends StatefulWidget {
  final Lotto? lotto;
  const PrizeCalendarPage({Key? key, this.lotto}) : super(key: key);

  @override
  State<PrizeCalendarPage> createState() => _PrizeCalendarPageState();
}

class _PrizeCalendarPageState extends State<PrizeCalendarPage> {
  final lottoService = LottoService();
  final prizeService = PrizeService();
  final maxMissDayService = MaxMissDayService();
  CalendarFormat _calendarFormat = CalendarFormat.twoWeeks;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  bool isLoading = false;
  bool isUpdating = false;
  late List<Prize> items = [];
  late List<Lotto> lottos = [];

  Future<void> loadData() async {
    setState(() {
      isLoading = true;
    });
    items = await prizeService.getByDateOfLotto(widget.lotto!.id,
        DateTime(_focusedDay.year, _focusedDay.month, _focusedDay.day));
    setState(() {
      isLoading = false;
    });
  }

  Future<void> loadLottos() async {
    lottos = await lottoService.getAllFuture();
  }

  @override
  void initState() {
    super.initState();
    loadLottos();
    loadData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final kFirstDay =
        DateTime(_focusedDay.year - 5, _focusedDay.month, _focusedDay.day);
    final kLastDay =
        DateTime(_focusedDay.year, _focusedDay.month + 3, _focusedDay.day);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 40,
        leadingWidth: 0,
        title: RichText(
            text: TextSpan(
                text: 'Prize ',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.primary,
                ),
                children: const [
              TextSpan(
                text: 'Calendar',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Colors.black54,
                ),
              )
            ])),
        actions: [
          IconButton(
            icon: Icon(Icons.error_outline,
                color: Theme.of(context).colorScheme.primary),
            onPressed: () async {
              setState(() {
                isLoading = true;
              });
              await Future.delayed(const Duration(seconds: 5));
              items = await prizeService.getXmlSource(widget.lotto!.id);
              await prizeService.deleteXmlSource(widget.lotto!.id);
              if (items.isEmpty) {
                items = await prizeService.getErrors(widget.lotto!.id, ' ?');
              }

              setState(() {
                isLoading = false;
              });
            },
          ),
          IconButton(
            icon: (isUpdating)
                ? const SizedBox(
                    width: 15,
                    height: 15,
                    child: CircularProgressIndicator(
                      color: Colors.green,
                      strokeWidth: 2,
                    ))
                : Icon(Icons.sync,
                    color: Theme.of(context).colorScheme.primary),
            onPressed: () async {
              await Future.delayed(const Duration(seconds: 5));
              setState(() {
                isUpdating = true;
              });
              try {
                var total = await prizeService.countByLotto(widget.lotto!.id);
                lottoService.updateTotalPrizes(widget.lotto!.id, total);

                var prizes =
                    await prizeService.limitResults(widget.lotto!.id, 60);
                var lstMaxMissDays =
                    await LottoHelper.getMaxMissDays(widget.lotto!, prizes);
                print(lstMaxMissDays.length);
                maxMissDayService.updateByLotto(
                    widget.lotto!.id, lstMaxMissDays);
              } catch (e) {
                print(e.toString());
              }

              setState(() {
                isUpdating = false;
              });
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                          text: TextSpan(
                              text: '${widget.lotto!.code} |',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black54,
                              ),
                              children: [
                            TextSpan(
                              text: ' ${widget.lotto!.name}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                fontStyle: FontStyle.italic,
                                color: Colors.black54,
                              ),
                            )
                          ])),
                      Text(
                        '${widget.lotto!.minCode} - ${widget.lotto!.maxCode}',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Items/Total: ${items.length} / ${widget.lotto!.totalPrizes}',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    decoration: VLTxTheme.decoration,
                    child: TableCalendar(
                      calendarStyle: CalendarStyle(
                        selectedTextStyle:
                            TextStyle(color: Colors.white, fontSize: 16.0),
                        selectedDecoration: BoxDecoration(
                            color: Color.fromARGB(255, 88, 180, 116),
                            shape: BoxShape.circle),
                        todayDecoration: BoxDecoration(
                            color: Color.fromARGB(255, 233, 226, 226),
                            shape: BoxShape.circle),
                        weekendTextStyle:
                            TextStyle(color: Color.fromARGB(255, 196, 25, 25)),
                        outsideDaysVisible: false,
                      ),
                      headerStyle: HeaderStyle(
                        formatButtonTextStyle: TextStyle()
                            .copyWith(color: Colors.white, fontSize: 16.0),
                        formatButtonDecoration: BoxDecoration(
                          color: Color.fromARGB(255, 112, 199, 145),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      firstDay: kFirstDay,
                      lastDay: kLastDay,
                      focusedDay: _focusedDay,
                      selectedDayPredicate: (day) {
                        return isSameDay(_selectedDay, day);
                      },
                      onDaySelected: (selectedDay, focusedDay) {
                        if (!isSameDay(_selectedDay, selectedDay)) {
                          // Call `setState()` when updating the selected day
                          setState(() {
                            _selectedDay = selectedDay;
                            _focusedDay = focusedDay;
                            loadData();
                          });
                        }
                      },
                      onFormatChanged: (format) {
                        if (_calendarFormat != format) {
                          // Call `setState()` when updating calendar format
                          setState(() {
                            _calendarFormat = format;
                          });
                        }
                      },
                      onPageChanged: (focusedDay) {
                        // No need to call `setState()` here
                        _focusedDay = focusedDay;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      if (items.isNotEmpty) {
                        return Container(
                          decoration: VLTxTheme.decoration,
                          margin: const EdgeInsets.only(top: 8.0),
                          child: Slidable(
                            endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  // An action can be bigger than the others.
                                  onPressed: (ctx) => {
                                    showCupertinoDialog(
                                      context: context,
                                      builder: (_) => CupertinoAlertDialog(
                                        title: const Text('Delete Item'),
                                        content: const Text('Do you want to delete?'),
                                        actions: [
                                          CupertinoDialogAction(
                                            child: const Text('Yes'),
                                            onPressed: () async {
                                              deleteItem(items[index].id);
                                              Navigator.pop(context);
                                            },
                                          ),
                                          CupertinoDialogAction(
                                            child: const Text('No'),
                                            onPressed: () async {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      ),
                                      barrierDismissible: false,
                                    ),
                                  },
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                  label: 'Delete',
                                ),
                              ],
                            ),
                            child: ListTile(
                              leading: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    DateFormat('dd-MM-yyyy')
                                        .format(items[index].drawtime),
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                  ),
                                  Text(items[index].code),
                                ],
                              ),
                              title: Text(
                                items[index].numbers ?? '',
                                textAlign: TextAlign.justify,
                              ),
                              onTap: () =>
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => PrizeDetailPage(
                                            lotto: widget.lotto!,
                                            prize: items[index],
                                          ))),
                            ),
                          ),
                        );
                      } else {
                        return Container(
                          width: constraints.maxWidth,
                          height: 50,
                          child: Center(child: Text('Nothing.')),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            if (isLoading) ...[
              LoadingProgress(),
            ],
          ],
        );
      }),
    );
  }

  deleteItem(String id) {
    //print('delete');
    setState(() {
      prizeService.deleteItem(id);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Item deleted.'),
      ));
    });
  }
}
