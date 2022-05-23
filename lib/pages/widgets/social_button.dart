import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginFacebook extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FlatButton(
        padding: EdgeInsets.all(0), 
        height: 48,
          color: Color(0xFF3b5998),
          shape: RoundedRectangleBorder(            
            borderRadius: BorderRadius.circular(8.0),
          ),
          onPressed: () {},
          child: Row(
            children: [
              Container(
                decoration: new BoxDecoration(    
                  color:  Color(0xFF283d68),              
                  borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(8),
                    bottomLeft: const Radius.circular(8),
                  )
                ),                
                width: 48,
                height: 48,
                alignment: Alignment.center,
                child: FaIcon(FontAwesomeIcons.facebookF, color: Colors.white),
              ),  
              Expanded(
                child: Text(
                  'Facebook',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  )
                )
              ), 
            ],
          )),
    );
  }
}

class LoginGoogle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FlatButton(
      padding: EdgeInsets.all(0),
      height: 48,
      color: Color(0xFFdd4b39),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),            
      ),
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [   
            Container(              
              decoration: new BoxDecoration(
                color:  Color(0xFFb52f1f),
                borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(8),
                  bottomLeft: const Radius.circular(8),
                )
              ),  
              width: 48,
              height: 48,              
              alignment: Alignment.center,
              child: FaIcon(FontAwesomeIcons.google, color: Colors.white),
            ), 
            Expanded(
              child: Text(
                'Google',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                )
              )
            ), 
          ],
        )
      ),
    );
  }
}