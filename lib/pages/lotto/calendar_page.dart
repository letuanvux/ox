import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/material.dart';

import 'package:table_calendar/table_calendar.dart';

import '../../configs/routes.dart';
import '../../configs/themes.dart';
import '../../models/lotto.dart';
import '../../services/lotto_service.dart';
import '../../services/prize_service.dart';
import '../../models/prize.dart';
import '../widgets/loading_progress.dart';
import 'prize_detail_page.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final lottoService = LottoService();
  final prizeService = PrizeService();
  CalendarFormat _calendarFormat = CalendarFormat.twoWeeks;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  bool isLoading = false;
  late List<Prize> items = [];
  late List<Lotto> lottos = [];
  int _expandedIndex = 0;

  Future<void> loadData() async {
    setState(() {
      isLoading = true;
    });
    items = await prizeService.getByDate(
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
                text: 'Lotto ',
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
            icon: Icon(Icons.list_outlined,
                color: Theme.of(context).colorScheme.primary),
            onPressed: () {
              Navigator.pushNamed(context, VLTxRoutes.lotto);
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
                  TableCalendar(
                    firstDay: kFirstDay,
                    lastDay: kLastDay,
                    focusedDay: _focusedDay,
                    calendarFormat: _calendarFormat,
                    selectedDayPredicate: (day) {
                      // Use `selectedDayPredicate` to determine which day is currently selected.
                      // If this returns true, then `day` will be marked as selected.

                      // Using `isSameDay` is recommended to disregard
                      // the time-part of compared DateTime objects.
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
                  const SizedBox(
                    height: 5,
                  ),                  

                  for (var i = 0; i < lottos.length; i++) ...[
                    if (items.where((o) => o.lotto == lottos[i].id).length >
                        0) ...[
                      Container(
                        decoration: boxDecoration,
                        margin: EdgeInsets.only(bottom: 10.0),
                        child: ExpansionPanelList(
                          animationDuration: Duration(milliseconds: 500),
                          dividerColor: Colors.red,
                          expandedHeaderPadding: EdgeInsets.only(bottom: 0.0),
                          elevation: 1,
                          children: [
                            ExpansionPanel(
                              headerBuilder:
                                  (BuildContext context, bool isExpanded) {
                                return ListTile(
                                  leading: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: CountryPickerUtils.getDefaultFlagImage(
                                        CountryPickerUtils.getCountryByIsoCode(
                                            lottos[i].country)),
                                  ),
                                  title: Text(
                                    lottos[i].name,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black54,
                                    ),
                                  ),
                                );
                              },
                              body: Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Wrap(
                                  spacing: 15,
                                  runSpacing: 15,
                                  alignment: WrapAlignment.start,
                                  children: [
                                    for (var item in items
                                        .where((o) => o.lotto == lottos[i].id)
                                        .toList()) ...[
                                      InkWell(
                                        child: Text(
                                          item.code,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary),
                                        ),
                                         onTap: () =>
                                          Navigator.of(context).push(MaterialPageRoute(
                                              builder: (context) => PrizeDetailPage(
                                                    lotto: lottos[i],
                                                    item: item,
                                                  ))),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                              isExpanded: _expandedIndex == i,
                            )
                          ],
                          expansionCallback: (int index, bool status) {
                            setState(() {
                              _expandedIndex = _expandedIndex == i ? 0 : i;
                            });
                          },
                        ),
                      ),
                    ]
                  ],                  
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
}
