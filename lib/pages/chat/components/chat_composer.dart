import 'package:flutter/material.dart';

class ChatComposer extends StatelessWidget {
  const ChatComposer({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      color: Colors.white,
      height: 65,
      child: Row(
        children: [
          Icon(
            Icons.camera_alt,
            color: Theme.of(context).primaryColor,
          ),
          SizedBox(
            width: 10,
          ),
          Icon(
            Icons.attach_file,
            color: Theme.of(context).primaryColor,
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(              
                children: [  
                  Icon(
                    Icons.mic,
                    color: Theme.of(context).primaryColor,
                  ),                
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextField(                      
                      textAlignVertical: TextAlignVertical.bottom,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Type your message ...',
                        hintStyle: TextStyle(color: Colors.grey[500]),
                      ),
                    ),
                  ),
                  Icon(
                    Icons.emoji_emotions_outlined,
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Icon(
            Icons.send_rounded,
            color: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}

