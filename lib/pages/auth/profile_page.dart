import 'package:flutter/material.dart';

import '../../configs/routes.dart';
import '../../constants.dart';
import '../widgets/app_background.dart';
import '../widgets/app_logo.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({ Key? key }) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: RichText(
            text: TextSpan(
                text: "Profile ",
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w500,
                ),
                children: [
              TextSpan(
                text: 'User',
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
                Navigator.pushNamed(context, VLTxRoutes.login);
              },
              icon: Icon(Icons.home)),
        ],
      ),
      body: Stack(
        children: [
          AppBackground(image: bgImage),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center, 
              children: [                
                AppLogo(),                
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20))
                  ),
                  child: Column(                    
                    children: [
                      TextFormField(                              
                        cursorColor: Colors.black,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.numberWithOptions(),
                        decoration:
                            InputDecoration(hintText: 'Email'),
                      ),
                      TextFormField(                              
                        cursorColor: Colors.black,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.numberWithOptions(),
                        decoration:
                            InputDecoration(hintText: 'Email'),
                      ),
                      
                      TextFormField(                              
                        cursorColor: Colors.black,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.numberWithOptions(),
                        decoration:
                            InputDecoration(hintText: 'Actice Code'),
                      ),
                      
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary:
                              Theme.of(context).colorScheme.primary,
                          minimumSize: const Size.fromHeight(40), // NEW
                        ),
                        onPressed: (){
                          Navigator.pushNamed(context, VLTxRoutes.signup);
                        },
                        child: Text('Submit')
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}