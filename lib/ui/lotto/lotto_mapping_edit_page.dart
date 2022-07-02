import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'models/lotto_mapping.dart';
import 'services/lotto_mapping_service.dart';
import 'lotto_crawl_page.dart';

class LottoMappingEditPage extends StatefulWidget {
  final String lottoId;
  final String? id;
  const LottoMappingEditPage({Key? key, required this.lottoId, this.id})
      : super(key: key);

  @override
  _LottoMappingEditPageState createState() => _LottoMappingEditPageState();
}

class _LottoMappingEditPageState extends State<LottoMappingEditPage> {
  final _formKey = GlobalKey<FormState>();
  final itemService = LottoMappingService();
  final _nameController = TextEditingController();
  final _urlController = TextEditingController();
  final _paramsController = TextEditingController();
  final _formatParamsController = TextEditingController();
  final _formatDateController = TextEditingController();
  final _drawtimeController = TextEditingController();
  final _nodeController = TextEditingController();
  final _xsltController = TextEditingController();

  TimeOfDay? pickedTime = TimeOfDay.now();
  int? _method;

  //LottoMapping? item;

  Future<void> loadData() async {
    if (widget.id!.isNotEmpty) {
      await itemService.getOneFuture(widget.id!).then((item) {
        _nameController.text = item.name;
        _urlController.text = item.url;
        _formatParamsController.text = item.formatParams!;
        _paramsController.text = item.params!;
        _nodeController.text = item.node!;
        _xsltController.text = item.xslt!;
        _drawtimeController.text = item.drawtime!;
        _formatDateController.text = item.formatDate!;
        setState(() {
          _method = item.method;
        });
      });
    } else {
      _method = 0;
    }
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
                text: 'Edit',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Colors.black54,
                ),
              )
            ])),
        actions: [
          if (widget.id!.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.data_saver_on, color: Colors.black54),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => LottoCrawlPage(
                          id: widget.id!,
                        )));
              },
            ),
          IconButton(
            icon: Icon(
              Icons.save,
              color: Theme.of(context).colorScheme.primary,
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Record
                var item = LottoMapping(
                  id: widget.id!,
                  lottoId: widget.lottoId,
                  name: _nameController.text,
                  url: _urlController.text,
                  method: _method!,
                  params: _paramsController.text,
                  formatParams: _formatParamsController.text,
                  formatDate: _formatDateController.text,
                  drawtime: _drawtimeController.text,
                  node: _nodeController.text,
                  xslt: _xsltController.text,
                );

                if (widget.id!.isEmpty) {
                  itemService.addItem(item);
                } else {
                  itemService.updateItem(item);
                }
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: buildForm(),
      ),
    );
  }

  Form buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            textCapitalization: TextCapitalization.words,
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Name'),
            validator: (value) {
              if (value!.isEmpty || value.length < 2) {
                return 'Please enter name with 2 or more characters';
              }
              return null;
            },
          ),
          TextFormField(
            keyboardType: TextInputType.url,
            textCapitalization: TextCapitalization.none,
            controller: _urlController,
            decoration: const InputDecoration(labelText: 'Url'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter url';
              }
              bool isUrl = Uri.parse(value).isAbsolute;
              if (!isUrl) {
                return 'Please enter url correct';
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
            decoration: const InputDecoration(labelText: 'Format param'),
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
            decoration: const InputDecoration(labelText: 'Format drawtime'),
          ),
          TextFormField(
            textCapitalization: TextCapitalization.none,
            controller: _xsltController,
            decoration: const InputDecoration(labelText: 'XSLT'),
          ),
        ],
      ),
    );
  }
}
