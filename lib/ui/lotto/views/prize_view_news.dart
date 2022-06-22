import 'package:flutter/material.dart';

class PrizeViewNews extends StatelessWidget {
  const PrizeViewNews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 28,
        itemBuilder: (context, i) => Column(
              children: [
                const Divider(height: 0.1),
                ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Colors.grey,
                    backgroundImage: NetworkImage('https://randomuser.me/api/portraits/men/3.jpg'),
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'name $i',
                        style: const TextStyle(
                            fontSize: 13.0, fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        '13:45',
                        style: TextStyle(fontSize: 11.0, color: Colors.grey),
                      )
                    ],
                  ),
                  subtitle: Text(
                    'Noi dung thu kiem tra $i',
                    style: const TextStyle(color: Colors.grey, fontSize: 11.0),
                  ),
                )
              ],
            ));
  }
}