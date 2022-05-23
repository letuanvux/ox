import 'package:flutter/material.dart';
import '../../../models/long_number.dart';

class TripleNumberTile extends StatelessWidget {
  final TripleNumber item;
  const TripleNumberTile({Key? key,required this.item,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      margin: const EdgeInsets.only(bottom: 10),
      width: 210,
      decoration:  const BoxDecoration(    
        color:  Colors.white,              
        borderRadius: BorderRadius.all(Radius.circular(4))
      ),       
      child: Row(
        children: [
          Container(                  
            width: 30,
            height: 25,
            alignment: Alignment.center,                
            child: Text(item.number, style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 16))
          ),
          Expanded(
            child: Stack(
              children: [                
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left:5),
                  width: 200,
                  height: 25,                   
                  decoration: BoxDecoration(    
                    color: Colors.orangeAccent.withOpacity(0.25),         
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(item.items.join(','), style: const TextStyle(color: Colors.black54)),
                ),                           
              ],                                  
            ),
          )
        ],
      ),
    );
  }
}