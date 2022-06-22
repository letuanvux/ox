import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/material.dart';

import '../../themes.dart';

class FavoriteCard extends StatelessWidget {  
  final String title;
  final String subtitle;
  final String country;
  final String imgUrl;
  final VoidCallback? onTab;
  final Color color;
  final Color gradient;

  const FavoriteCard({Key? key, required this.title, required this.subtitle, required this.country, required this.imgUrl, required this.color, required this.gradient, this.onTab, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 5.0),    
      child: GestureDetector(
        onTap: onTab,
        child: Stack(
          alignment: Alignment.bottomRight,
          children: <Widget>[
            Card(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5.0)
                  ),
                gradient : LinearGradient(colors: [color, gradient],
                begin: Alignment.topCenter,
                end: Alignment.bottomRight)
                ),

                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(top : 8.0),
                      child: Text(title),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        subtitle, 
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                )
              )
            ),
            Positioned(
              top: 4,
              right: 100,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(VLTxTheme.radius),
                  bottomRight: Radius.circular(VLTxTheme.radius),
                ),
                child: Image.asset(
                  CountryPickerUtils.getFlagImageAssetPath(CountryPickerUtils.getCountryByIsoCode(country).isoCode),
                  height: 25.0,
                  width: 40.0,
                  fit: BoxFit.fill,
                  package: "country_pickers",
                ),
              ),
            ), 
       
            Padding(
              padding: const EdgeInsets.only(right: 10, bottom: 0),
              child: Image.asset(
                imgUrl.isEmpty ? 'assets/images/lotto/vietlott-mega-645-logo-white.png' : imgUrl, 
                height: 90,
                width: 160,
              ),
            )
          ]
        ),
        
      ),
    );
  }
}

