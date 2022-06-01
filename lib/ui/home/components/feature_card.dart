import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/material.dart';
import '../../commons/favorite_box.dart';
import '../../lotto/models/lotto.dart';
import '../../themes.dart';

class FeatureCard extends StatelessWidget {
  final Lotto item;

  const FeatureCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {    
    return Center(
      child: GestureDetector(
        onTap: (){
          
        },
        child: Container(
            height: 100,
            width: double.infinity,
            margin: const EdgeInsets.only(
                bottom: 10
            ),
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 112, 172, 100),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      offset: const Offset(5,5),
                      blurRadius: 7
                  )
                ],
                borderRadius: const BorderRadius.all(Radius.circular(VLTxTheme.defaultRadius))
            ),
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          Container(                    
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.all(Radius.circular(VLTxTheme.defaultRadius)),
                            ),
                          ), 
                          ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(VLTxTheme.defaultRadius)),
                            child: Image.asset(
                              item.imgUrl.isEmpty ? 'assets/images/logo.png' : item.imgUrl,
                              height: 100,
                              width: 100,
                              //color: Colors.white.withOpacity(0.05),
                              fit: BoxFit.cover,
                            ),
                          ),                                                                            
                        ],
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    item.name,
                                    style: TextStyle(
                                        fontSize: 16,
                                        //fontWeight: FontWeight.w500,
                                        color: Colors.white
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(                    
                              height: 30,
                              alignment: Alignment.center,                    
                              child: Padding(
                                padding: const EdgeInsets.only(left :8.0),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [          
                                      Text(
                                        item.drawtime,
                                        style: const TextStyle(color: Colors.white, fontSize: 12,),
                                      ),  
                                      Container(
                                        height: 30,
                                        width: 40,
                                        decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(0.2),
                                            borderRadius: const BorderRadius.only(
                                                bottomRight: Radius.circular(VLTxTheme.defaultRadius),
                                                topLeft: Radius.circular(VLTxTheme.defaultRadius)
                                            )
                                        ),
                                        alignment: Alignment.center,
                                        child: const Icon(
                                          Icons.arrow_forward_ios,
                                          size: 14,
                                          color: Colors.white,
                                        ),
                                      ),                                                              
                                    ],
                                  ),
                              ),
                            ),
                          ],
                        ),
                      ),  
                    ],
                  ),
                ),         
                Positioned(
                  top: 5,
                  right: 5,
                  child: FavoriteBox(
                    isFavorited: item.isFavorite,
                    onTap: () {},
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(VLTxTheme.defaultRadius),
                              topLeft: Radius.circular(VLTxTheme.defaultRadius)),
                    child: CountryPickerUtils.getDefaultFlagImage(
                                                CountryPickerUtils.getCountryByIsoCode(
                                                    item.country)),
                  ), 
                ),
              ],
            )
        ),
      ),
    );
  }

  getAttribute(IconData icon, String info){
    return
      Row(
        children: [
          Icon(icon, size: 15, color: Colors.white,),
          const SizedBox(width: 3,),
          Text(info, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white, fontSize: 13),),
        ],
      );
  }
}