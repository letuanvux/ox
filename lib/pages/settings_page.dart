import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        leading: IconButton(
          icon: Icon(Icons.account_circle_outlined, color: Colors.blueGrey[300]),
          onPressed: () => Scaffold.of(context).openDrawer(),          
        ),
        leadingWidth: 30,
        title: const Text(
          "Settings",
          style: TextStyle(
              color: Color(0xFF3a3737),
              fontSize: 14,
              fontWeight: FontWeight.w500),
        ),
        backgroundColor: const Color(0xFFEFF5F4),
        actions: [
          IconButton (            
            icon: Icon(Icons.qr_code, color: Colors.blueGrey[300]),
            onPressed: (){
              
            },
          ),
          IconButton (
            icon: Icon(Icons.notifications_outlined, color: Colors.blueGrey[300]),
            onPressed: (){

            },            
          ),          
        ],
      ), 
      body: SingleChildScrollView( 
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [            
            Row(
              children: const [
                Icon(Icons.person, color: Colors.green,), 
                SizedBox(width: 8),               
                Text("Account", textAlign: TextAlign.left, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),                
              ],
            ),
            const SizedBox(height: 10),
            buildAccountOptionRow(context, "Change password"),
            buildAccountOptionRow(context, "Content settings"),
            buildAccountOptionRow(context, "Social"),
            buildAccountOptionRow(context, "Language"),
            buildAccountOptionRow(context, "Privacy and security"),
            const SizedBox(height: 10,),
            Row(
              children: const [
                Icon(Icons.volume_up_outlined, color: Colors.green,),
                SizedBox(width: 8),
                Text("Notifications",style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              ],
            ),            
            const SizedBox(height: 10,),
            buildNotificationOptionRow("New for you", true),
            buildNotificationOptionRow("Account activity", true),
            buildNotificationOptionRow("Opportunity", false),
            
            const SizedBox(height: 50,),
            Center(
              child: OutlineButton(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                onPressed: () {},
                child: const Text("SIGN OUT",
                    style: TextStyle(
                        fontSize: 14, letterSpacing: 2.2, color: Colors.black)),
              ),
            )
          ],
        ),
      ),
    );  
  }

  Container buildNotificationOptionRow(String title, bool isActive) {
    return Container(
      margin: const EdgeInsets.only(top: 5.0),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              //fontWeight: FontWeight.w500,
              color: Colors.black
            ),
          ),
          Transform.scale(
              scale: 0.7,
              child: CupertinoSwitch(
                value: isActive,
                onChanged: (bool val) {},
              ))
        ],
      ),
    );
  }

  GestureDetector buildAccountOptionRow(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(title),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text("Option 1"),
                    Text("Option 2"),
                    Text("Option 3"),
                  ],
                ),
                actions: [
                  FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Close")),
                ],
              );
            });
      },
      child: Container(
        margin: const EdgeInsets.only(top: 5.0),
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                //fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey[300],
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
