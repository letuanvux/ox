

import 'package:flutter/material.dart';

class LottoSuggestPage extends StatefulWidget {
  const LottoSuggestPage({ Key? key }) : super(key: key);

  @override
  _LottoSuggestPageState createState() => _LottoSuggestPageState();
}

class _LottoSuggestPageState extends State<LottoSuggestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 40,
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
                text: 'Items',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Colors.black54,
                ),
              )
            ])),
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Theme.of(context).colorScheme.primary),
            onPressed: () {
              //Navigator.pushNamed(context, VLTxRoutes.lottoEdit);
            },
          ),
        ],
      ),
    );
  }
}