import 'package:flutter/material.dart';
import '../messager_detail_page.dart';
import '../models/chat_user.dart';

class MessageCard extends StatelessWidget {
  final ChatUser user;
  final bool isMessageRead;
  const MessageCard({ Key? key, required this.user, required this.isMessageRead }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return MessagerDetailPage(user: user,);
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
                          SizedBox(height: 5,),
                          Text(
                            user.secondaryText,
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                                fontSize: 12, color: Colors.grey.shade500),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              user.time,
              style: TextStyle(
                  fontSize: 12,
                  color: isMessageRead
                      ? Colors.pink
                      : Colors.grey.shade500),
            ),
          ],
        ),
      ),
    );
  }
}