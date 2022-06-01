import 'package:flutter/material.dart';

import 'chat_dial_page.dart';

import 'chat_video_page.dart';
import 'components/chat_message_card.dart';
import 'components/dial_user_pic.dart';
import 'models/chat_message.dart';
import 'models/send_menu_items.dart';

class ChatMessagePage extends StatefulWidget {
  const ChatMessagePage({ Key? key }) : super(key: key);

  @override
  State<ChatMessagePage> createState() => _ChatMessagePageState();
}

class _ChatMessagePageState extends State<ChatMessagePage> {
  List<ChatMessage> messages = [
    ChatMessage(message: "Hi John", type: MessageType.Receiver),
    ChatMessage(message: "Hope you are doin good", type: MessageType.Receiver),
    ChatMessage(message: "Hello Jane, I'm good what about you", type: MessageType.Sender),
    ChatMessage(message: "I'm fine, Working from home", type: MessageType.Receiver),
    ChatMessage(message: "Oh! Nice. Same here man", type: MessageType.Sender),
  ];

  List<SendMenuItems> menuItems = [
    SendMenuItems(text: "Photos & Videos", icons: Icons.image, color: Colors.amber),
    SendMenuItems(text: "Document", icons: Icons.insert_drive_file, color: Colors.blue),
    SendMenuItems(text: "Audio", icons: Icons.music_note, color: Colors.orange),
    SendMenuItems(text: "Location", icons: Icons.location_on, color: Colors.green),
    SendMenuItems(text: "Contact", icons: Icons.person, color: Colors.purple),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(        
        toolbarHeight: 50,
        backgroundColor: Colors.white,
        leading: BackButton(), 
        leadingWidth: 0,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            DialUserPic(image: "assets/images/logo.png", size: 60,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Jane Russel",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                    fontWeight: FontWeight.normal),
                  ),            
                  Text("Online",style: TextStyle(color: Colors.green,fontSize: 10),),
                ]
              ),
            ),
          ],
        ), 
        actions: [
          IconButton(
            icon: Icon(Icons.call,
                color: Theme.of(context).colorScheme.primary),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ChatDialPage();
              }));
            },
          ),
          IconButton(
            icon: Icon(Icons.videocam,
                color: Theme.of(context).colorScheme.primary),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ChatVideoPage();
              }));
            },
          ),
          IconButton(
            icon: Icon(Icons.info_rounded,
                color: Theme.of(context).colorScheme.primary),
            onPressed: () {
              
            },
          ),
        ],       
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: messages.length,
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 10,bottom: 10),
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index){
              return ChatMessageCard(
                item: messages[index],
              );
            },
         ),
         Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 16,bottom: 10),
              height: 40,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      showModal();
                    },
                    child: Container(
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(Icons.add,color: Colors.white,size: 21,),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Type message...",
                        hintStyle: TextStyle(color: Colors.grey.shade500),
                        border: InputBorder.none
                      ),
                    ),
                  ),
                  FloatingActionButton(
                    mini: true,
                    onPressed: (){},
                    child: Icon(Icons.send,color: Colors.white,),
                    backgroundColor: Colors.pink,
                    elevation: 0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),      
    );
  }

  void showModal(){
    showModalBottomSheet(
      context: context,
      builder: (context){
        return Container(
          height: MediaQuery.of(context).size.height/2,
          color: Color(0xff737373),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)),
            ),
            child: Column(
              children: <Widget>[
                SizedBox(height: 16,),
                Center(
                  child: Container(
                    height: 4,
                    width: 50,
                    color: Colors.grey.shade200,
                  ),
                ),
                SizedBox(height: 10,),
                ListView.builder(
                  itemCount: menuItems.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index){
                    return Container(
                      padding: EdgeInsets.only(top: 10,bottom: 10),
                      child: ListTile(
                        leading: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: menuItems[index].color.shade50,
                          ),
                          height: 50,
                          width: 50,
                          child: Icon(menuItems[index].icons,size: 20,color: menuItems[index].color.shade400,),
                        ),
                        title: Text(menuItems[index].text),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        );
      }
    );
  }
}