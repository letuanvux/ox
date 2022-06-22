import 'package:flutter/material.dart';

import '../../configs/routes.dart';
import '../themes.dart';
import '../commons/app_background.dart';
import '../commons/app_logo.dart';

class ForgotPage extends StatefulWidget {
  const ForgotPage({ Key? key }) : super(key: key);

  @override
  State<ForgotPage> createState() => _ForgotPageState();
}

class _ForgotPageState extends State<ForgotPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: RichText(
            text: TextSpan(
                text: "Forgot ",
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w500,
                ),
                children: const [
              TextSpan(
                text: 'password',
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
      body: Stack(
        children: [
          AppBackground(image: VLTxTheme.bgImage),          
          AppLogo(), 
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [                
                SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20))
                    ),
                    child: Form(                    
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
                                InputDecoration(hintText: 'Reset code'),
                          ),
                          SizedBox(height: 10.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't receive the OTP? ",
                              ),
                              GestureDetector(
                                child: Text("Resend OTP",
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontWeight: FontWeight.bold)),
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, VLTxRoutes.login);
                                },
                              )
                            ]),
                            SizedBox(height: 10.0),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary:
                                    Theme.of(context).colorScheme.primary,
                                minimumSize: const Size.fromHeight(40), // NEW
                              ),
                              onPressed: (){
                                Navigator.pushNamed(context, VLTxRoutes.forgot);
                              },
                              child: Text('Submit')
                            ),
                            SizedBox(height: 20.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't have an account. ",
                                ),
                                GestureDetector(
                                  child: Text("Sign up?",
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          fontWeight: FontWeight.bold)),
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, VLTxRoutes.signup);
                                  },
                                )
                              ]),
                        ],
                      )
                    ),
                  ),
                ) 
              ],
            ),
          ),          
        ],
      ),
    );
  }
}