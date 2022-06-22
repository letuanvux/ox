import 'package:flutter/material.dart';

class PrizeViewChat extends StatelessWidget {
  const PrizeViewChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 20,
        itemBuilder: (context, i) => Column(
          children: <Widget>[
            const Divider(height: 0.1),
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.grey,
                backgroundImage: NetworkImage('https://randomuser.me/api/portraits/men/4.jpg'),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('callData $i',
                      style: const TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      )),
                  Icon(
                    i % 2 == 0 ? Icons.call : Icons.videocam,
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              ),
              subtitle: const Text(
                '12:30',
                style: TextStyle(color: Colors.grey, fontSize: 12.0),
              ),
            )
          ],
        ));
  }
}