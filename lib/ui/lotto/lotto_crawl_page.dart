import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../vltx/vltx.dart';
import 'models/lotto_mapping.dart';
import 'models/prize.dart';
import 'services/prize_service.dart';
import 'services/lotto_mapping_service.dart';

import 'helpers/crawl_helper.dart';
import 'helpers/xsl_helper.dart';

class LottoCrawlPage extends StatefulWidget {
  final String id;
  const LottoCrawlPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _LottoCrawlPageState createState() => _LottoCrawlPageState();
}

class _LottoCrawlPageState extends State<LottoCrawlPage> {
  final _formKey = GlobalKey<FormState>();
  final itemService = LottoMappingService();
  final prizeService = PrizeService();
  final _urlController = TextEditingController();
  final _paramsController = TextEditingController();
  final _formatParamsController = TextEditingController();
  final _nodeController = TextEditingController();
  final _drawtimeController = TextEditingController();
  final _formatDateController = TextEditingController();
  final _xsltController = TextEditingController();
  final _minController = TextEditingController();
  final _maxController = TextEditingController();

  bool isLoading = false;
  int? _method;
  LottoMapping? mappingItem;
  late String source;
  late DateTime drawtime;
  late String xml = '';
  late String json = '';
  late String message = '';

  Future<void> loadData() async {
    isLoading = true;

    itemService.getOneFuture(widget.id).then((item) {
      _urlController.text = item.url;
      _paramsController.text = item.params!;
      _formatParamsController.text = item.formatParams!;
      _formatDateController.text = item.formatDate!;
      _nodeController.text = item.node!;
      _drawtimeController.text = item.drawtime!;
      _xsltController.text = item.xslt!;
      mappingItem = item;
      setState(() {
        _method = item.method;
      });
    });

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      toolbarHeight: 40,
      leading: Builder(builder: (context) {
        return IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.blueGrey[300]),
            onPressed: () => Navigator.of(context).pop());
      }),
      leadingWidth: 20,
      title: RichText(
          text: TextSpan(
              text: 'Lotto Mapping ',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).colorScheme.primary,
              ),
              children: const [
            TextSpan(
              text: 'Crawl',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.black54,
              ),
            )
          ])),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.fact_check,
            color: Colors.black54,
          ),
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              try {
                source = await CrawlHelper.getContent(
                    _urlController.text,
                    _method!,
                    _paramsController.text,
                    _minController.text,
                    _formatParamsController.text,
                    _nodeController.text);

                bottomsheet(context, 'Source', source);
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Error: , ${e.toString()}.'),
                ));
              }
            }
          },
        ),
        IconButton(
          icon: (isLoading)
              ? const SizedBox(
                  width: 15,
                  height: 15,
                  child: CircularProgressIndicator(
                    color: Colors.green,
                    strokeWidth: 2,
                  ))
              : Icon(Icons.play_arrow,
                  color: Theme.of(context).colorScheme.primary),
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              setState(() {
                isLoading = true;
              });
              await Future.delayed(const Duration(seconds: 5));
              try {
                await crawlPrize(_minController.text, _maxController.text);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Updated.'),
                ));
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Error: , ${e.toString()}.'),
                ));
              }
              setState(() {
                isLoading = false;
              });
            }
          },
        ),
      ],
    );
  }

  buildBody() {
    return LayoutBuilder(builder: (context, constraints) {
      return Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(10),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    readOnly: true,
                    textCapitalization: TextCapitalization.words,
                    controller: _urlController,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(left: 10, right: 10),
                      hintText: 'Url',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(3.0)),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty || value.length < 2) {
                        return 'Please enter name with 2 or more characters';
                      }
                      return null;
                    },
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: CupertinoSlidingSegmentedControl<int>(
                      padding: const EdgeInsets.all(4),
                      groupValue: _method,
                      children: const <int, Widget>{
                        0: Text('GET'),
                        1: Text('POST'),
                        2: Text('PUT'),
                      },
                      onValueChanged: (value) {
                        setState(() {
                          _method = value!;
                        });
                      },
                    ),
                  ),
                  TextFormField(
                    textCapitalization: TextCapitalization.none,
                    controller: _paramsController,
                    decoration: const InputDecoration(labelText: 'Param'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter param';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    textCapitalization: TextCapitalization.none,
                    controller: _formatParamsController,
                    decoration:
                        const InputDecoration(labelText: 'Format Params'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter format params';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    textCapitalization: TextCapitalization.none,
                    controller: _nodeController,
                    decoration: const InputDecoration(labelText: 'Node'),
                  ),
                  TextFormField(
                    textCapitalization: TextCapitalization.none,
                    controller: _drawtimeController,
                    decoration: const InputDecoration(labelText: 'Drawtime'),
                  ),
                  TextFormField(
                    textCapitalization: TextCapitalization.none,
                    controller: _formatDateController,
                    decoration: const InputDecoration(labelText: 'Format Date'),
                  ),
                  TextFormField(
                    textCapitalization: TextCapitalization.none,
                    controller: _xsltController,
                    decoration: const InputDecoration(labelText: 'Xslt'),
                  ),
                  TextFormField(
                    textCapitalization: TextCapitalization.none,
                    controller: _minController,
                    decoration: const InputDecoration(labelText: 'Min Value'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter min value';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    textCapitalization: TextCapitalization.none,
                    controller: _maxController,
                    decoration: const InputDecoration(labelText: 'Max value'),
                  ),
                ],
              ),
            ),
          ),
          if (isLoading) ...[
            Column(
              children: [
                LoadingProgress(content: message),
                Text(message),
              ],
            )
          ],
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: buildAppBar(),
      body: buildBody(),
    );
  }

  crawlSource(String value) async {
    source = await CrawlHelper.getContent(
        _urlController.text,
        _method!,
        _paramsController.text,
        value,
        _formatParamsController.text,
        _nodeController.text);
    if (source.isNotEmpty) {
      if (_drawtimeController.text.isNotEmpty) {
        var strdrawtime =
            CrawlHelper.getTagName(source, _drawtimeController.text);
        if (_formatDateController.text.isNotEmpty) {
          var inputFormat = DateFormat(_formatDateController.text);
          drawtime = inputFormat.parse(strdrawtime);
        }
      } else {
        drawtime = DateTime.parse(value);
      }

      if (_xsltController.text.isNotEmpty) {
        xml = await XslHelper.xslTransform(source, _xsltController.text);
      }
      // Get json data
      json = CrawlHelper.getJson(xml);
      var item = await prizeService.getByCode(mappingItem!.lottoId, value);

      if (item == null) {
        item = Prize(
          lotto: mappingItem!.lottoId,
          drawtime: drawtime,
          code: value,
          json: json,
        );
        item.numbers = item.getNumbers();
        prizeService.addItem(item);
      } else {
        item.drawtime = drawtime;
        item.json = json;
        item.numbers = item.getNumbers();
        prizeService.updateItem(item);
      }
    }
    setState(() {
      message = 'Crawled $value.';
    });
  }

  crawlPrize(String min, String max) async {
    await crawlSource(min);

    if (max.isNotEmpty) {
      if (DateTime.tryParse(max) != null) {
        DateTime mindate = DateTime.parse(min);
        DateTime maxdate = DateTime.parse(max);
        while (!mindate.isAtSameMomentAs(maxdate)) {
          mindate = mindate.add(const Duration(days: 1));
          await crawlSource(DateFormat('yyyy-MM-dd').format(mindate));
        }
      } else {
        int minint = int.parse(min);
        int maxint = int.parse(max);
        while (minint < maxint) {
          minint++;
          await crawlSource(minint.toString());
        }
      }
    }
    message = '';
  }
}
