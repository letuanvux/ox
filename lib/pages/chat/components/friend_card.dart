import 'package:flutter/material.dart';
import '../chat_message_page.dart';
import '../models/chat_user.dart';

class FriendCard extends StatelessWidget {
  final ChatUser user;
  final bool isOnline;
  const FriendCard({ Key? key, required this.user, required this.isOnline }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ChatMessagePage();
        }));
      },
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: AssetImage(user.image),
                    maxRadius: 20,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(user.text),
                          SizedBox(width: 5,),
                          Text(
                            user.time,
                            style: TextStyle(
                                fontSize: 10,
                                color: isOnline
                                    ? Colors.pink
                                    : Colors.grey.shade500),
                          ),                          
                          
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [                
                IconButton(
                  icon: Icon(Icons.call),
                  color: Theme.of(context).colorScheme.primary,
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.video_call),
                  color: Theme.of(context).colorScheme.primary,
                  onPressed: () {},
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}