import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/material.dart';
import '../../../vltx/vltx.dart';
import '../../lotto/models/lotto.dart';
import '../../themes.dart';

class FeatureCard extends StatelessWidget {
  final Lotto item;
  final GestureTapCallback? onTap;

  const FeatureCard({Key? key, required this.item, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {    
    return GestureDetector(
      onTap: onTap,
      child: Container(
          height: 100,
          width: double.infinity,
          margin: const EdgeInsets.only(
              bottom: 10
          ),
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    offset: const Offset(5,5),
                    blurRadius: 7
                )
              ],
              borderRadius: const BorderRadius.all(Radius.circular(VLTxTheme.radius))
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
                            color: Colors.black.withOpacity(0.07),
                            borderRadius: const BorderRadius.all(Radius.circular(VLTxTheme.radius)),
                          ),
                        ), 
                        ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(VLTxTheme.radius)),
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
                                child: Column(
                                  crossAxisAlignment : CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.code,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    Text(
                                      item.name,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.shade600,
                                        fontWeight: FontWeight.normal,
                                        fontStyle: FontStyle.italic
                                      )
                                    ),
                                  ],
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
                                      style: const TextStyle(color: Colors.black45, fontSize: 12,),
                                    ),  
                                    Container(
                                      height: 30,
                                      width: 40,
                                      decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.08),
                                          borderRadius: const BorderRadius.only(
                                              bottomRight: Radius.circular(VLTxTheme.radius),
                                              topLeft: Radius.circular(VLTxTheme.radius)
                                          )
                                      ),
                                      alignment: Alignment.center,
                                      child: const Icon(
                                        Icons.arrow_forward_ios,
                                        size: 14,
                                        color: Colors.black45,
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
                  color: Colors.black45,
                  bgColor: Colors.grey,
                  isFavorited: item.isFavorite,
                  onTap: () {},
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(VLTxTheme.radius),
                            topLeft: Radius.circular(VLTxTheme.radius)),
                  child: CountryPickerUtils.getDefaultFlagImage(
                                              CountryPickerUtils.getCountryByIsoCode(
                                                  item.country)),
                ), 
              ),
            ],
          )
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