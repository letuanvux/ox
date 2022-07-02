import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../vltx/vltx.dart';

import 'models/lotto.dart';
import 'services/lotto_service.dart';
import '../themes.dart';
import 'lotto_mapping_page.dart';

class LottoEditPage extends StatefulWidget {
  final Lotto? lotto;
  const LottoEditPage({Key? key, this.lotto}) : super(key: key);

  @override
  _LottoEditPageState createState() => _LottoEditPageState();
}

class _LottoEditPageState extends State<LottoEditPage> {
  final _formKey = GlobalKey<FormState>();
  final itemService = LottoService();
  final _countryController = TextEditingController();
  final _codeController = TextEditingController();
  final _nameController = TextEditingController();
  final _imageController = TextEditingController();
  final _drawtimeController = TextEditingController();
  final _minController = TextEditingController();
  final _maxController = TextEditingController();
  final _colorController = TextEditingController();
  final _gradientController = TextEditingController();
  bool _isball = false;
  bool isLoading = false;

  ImagePicker imagePicker = ImagePicker();
  late File file;
  late String imageUrl;
  late List<String> drawdays = [];

  Future<void> loadData() async {
    isLoading = true;
    if (widget.lotto != null) {
      _countryController.text = widget.lotto!.country;
      _codeController.text = widget.lotto!.code;
      _nameController.text = widget.lotto!.name;
      _imageController.text = widget.lotto!.imgUrl;      
      _drawtimeController.text = widget.lotto!.drawtime;
      _minController.text = widget.lotto!.min.toString();
      _maxController.text = widget.lotto!.max.toString();
      _colorController.text = widget.lotto!.color;
      _gradientController.text = widget.lotto!.gradient;
      if (widget.lotto!.drawdays != null)
      {
        drawdays = widget.lotto!.drawdays.cast<String>();
      }      
      setState(() {
        _isball = widget.lotto!.isball;
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  uploadImage() async {
    var imgPath = await Upload.image('lottos');
    if (imgPath != null) {
      setState(() {
        _imageController.text = imgPath;
      });
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
      appBar: buildAppBar(),
      body: buildBody(),
    );
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
              text: 'Lotto ',
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
        if (widget.lotto != null)
          IconButton(
            icon: const Icon(Icons.shuffle, color: Colors.black54),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => LottoMappingPage(
                        lotto: widget.lotto!,
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
              var item = Lotto(
                country: _countryController.text,
                code: _codeController.text,
                name: _nameController.text,
                drawdays: drawdays,
                drawtime: _drawtimeController.text,
                min: int.parse(_minController.text),
                max: int.parse(_maxController.text),
                isball: _isball,
                color: _colorController.text,
                gradient: _gradientController.text,
                imgUrl: _imageController.text,
              );

              if (widget.lotto == null) {
                itemService.addItem(item);
              } else {
                item.id = widget.lotto!.id;
                itemService.updateItem(item);
              }

              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }

  buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(10),
      child: isLoading
          ? const LoadingProgress()
          : Form(
              key: _formKey,
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 100,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.07),
                          borderRadius: const BorderRadius.all(
                              Radius.circular(VLTxTheme.radius)),
                        ),
                      ),
                      Center(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(
                              Radius.circular(VLTxTheme.radius)),
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: VLTxTheme.image(
                                        _imageController.text.isNotEmpty
                                            ? _imageController.text
                                            : VLTxTheme.logoImage),
                                    fit: BoxFit.cover)),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 5,
                        bottom: 5,
                        child: GestureDetector(
                          child: Container(
                            height: 25,
                            width: 30,
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.08),
                                borderRadius: const BorderRadius.only(
                                  bottomRight:
                                      Radius.circular(VLTxTheme.radius),
                                  topLeft: Radius.circular(VLTxTheme.radius),
                                )),
                            alignment: Alignment.center,
                            child: const Icon(
                              Icons.camera_alt_outlined,
                              size: 25,
                              color: Colors.black45,
                            ),
                          ),
                          onTap: () {
                            uploadImage();
                            print('upload image');
                          },
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    textCapitalization: TextCapitalization.words,
                    controller: _countryController,
                    decoration:
                        const InputDecoration(labelText: 'Country Code'),
                    validator: (value) {
                      if (value!.isEmpty || value.length < 2) {
                        return 'Please enter country code with 2 or more characters';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    textCapitalization: TextCapitalization.words,
                    controller: _codeController,
                    decoration: const InputDecoration(labelText: 'Lotto Code'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter lotto code';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Lotto Name'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter lotto name';
                      }
                      return null;
                    },
                  ),
                  AppWeekdays(
                    selectedDays: drawdays,
                    onSelect: (days) {
                      drawdays = days;
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: _drawtimeController,
                    decoration: const InputDecoration(labelText: 'Draw time'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter draw time';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _minController,
                    decoration: const InputDecoration(labelText: 'Number Min'),
                    validator: (value) {
                      try {
                        int.parse(value!);
                      } catch (error) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _maxController,
                    decoration: const InputDecoration(labelText: 'Number Max'),
                    validator: (value) {
                      try {
                        int.parse(value!);
                      } catch (error) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Format Ball',
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                      Transform.scale(
                        scale: 0.7,
                        child: CupertinoSwitch(
                          value: _isball,
                          onChanged: (v) => setState(() => _isball = v),
                        ),
                      )
                    ],
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: _colorController,
                    decoration: const InputDecoration(labelText: 'Color'),
                    validator: (value) {
                      if (value!.isNotEmpty && value.length > 6) {
                        return 'Please enter a valid hex color.';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: _gradientController,
                    decoration: const InputDecoration(labelText: 'Gradient'),
                    validator: (value) {
                      if (value!.isNotEmpty && value.length > 6) {
                        return 'Please enter a valid hex color.';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
