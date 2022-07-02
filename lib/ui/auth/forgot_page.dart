import 'package:flutter/material.dart';

import '../../vltx/vltx.dart';
import '../app.dart';
import '../themes.dart';
import 'login_page.dart';
import 'signup_page.dart';

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
        leading: const BackButton(),
        actions: [
          IconButton(
              onPressed: () {                
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const App();
                }));             
              },
              icon: const Icon(Icons.home)),
        ],
      ),
      body: Stack(
        children: [
          const AppBackground(image: VLTxTheme.bgImage),          
          AppLogo(), 
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [                
                SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(20))
                    ),
                    child: Form(                    
                      child: Column(
                        children: [
                          TextFormField(                              
                          cursorColor: Colors.black,
                          textInputAction: TextInputAction.next,
                          keyboardType: const TextInputType.numberWithOptions(),
                          decoration:
                              const InputDecoration(hintText: 'Email'),
                          ),
                          TextFormField(                              
                            cursorColor: Colors.black,
                            textInputAction: TextInputAction.next,
                            keyboardType: const TextInputType.numberWithOptions(),
                            decoration:
                                const InputDecoration(hintText: 'Reset code'),
                          ),
                          const SizedBox(height: 10.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
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
                                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                                    return const LoginPage();
                                  }));     
                                },
                              )
                            ]),
                            const SizedBox(height: 10.0),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary:
                                    Theme.of(context).colorScheme.primary,
                                minimumSize: const Size.fromHeight(40), // NEW
                              ),
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) {
                                    return const ForgotPage();
                                  })); 
                              },
                              child: const Text('Submit')
                            ),
                            const SizedBox(height: 20.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
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
                                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                                      return const SignupPage();
                                    }));
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