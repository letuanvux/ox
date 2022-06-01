import 'package:flutter/material.dart';

import '../../configs/routes.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({ Key? key }) : super(key: key);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: RichText(
            text: TextSpan(
                text: "Verification ",
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w500,
                ),
                children: [
              TextSpan(
                text: 'code',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ])),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        shadowColor: Theme.of(context).colorScheme.primary.withOpacity(.24),
        leading: BackButton(),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, VLTxRoutes.home);
              },
              icon: Icon(Icons.home)),
        ],
      ),
    );
  }
}