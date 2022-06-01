
import 'package:flutter/material.dart';

Future<dynamic> bottomsheet(BuildContext context, String title, String content) {
    return showModalBottomSheet(
      context: context,    
      barrierColor: Colors.white.withOpacity(.15),
      backgroundColor: Colors.white.withOpacity(.85),                
      shape: const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(15.0)),
      ),
      builder: (BuildContext context) {
        // return your layout
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(            
              children: [
                Row(
                  children: [
                    Text(title,
                      style: TextStyle(
                        fontSize: 16,                    
                        fontWeight: FontWeight.normal,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10,),
                Expanded(
                  child: SingleChildScrollView(                             
                    child: Text(content)
                  ),
                ),
              ],
            ),
          ),
        );
      });
  }