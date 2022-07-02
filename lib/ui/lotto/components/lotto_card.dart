import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/material.dart';
import '../../lotto/models/lotto.dart';
import '../../themes.dart';

class LottoCard extends StatelessWidget {
  final Lotto item;
  final GestureTapCallback? onTap;

  const LottoCard({Key? key, required this.item, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {    
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
          child: ListTile(                                
            contentPadding: const EdgeInsets.only(right: 10),
            leading: Stack(
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
            ),            
            title: RichText(
              text: TextSpan(
                text: item.code,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.primary,
                ),
                children: [
                  TextSpan(
                    text: ' - ${item.name}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.black54,
                    ),
                  )
                ]
              )
            ),
            trailing: Text(item.drawtime),
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