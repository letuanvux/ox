import 'package:flutter/material.dart';
import 'package:country_pickers/country_pickers.dart';

import '../../lotto/models/lotto.dart';
import '../../lotto/prize_detail_page.dart';
import '../../lotto/services/prize_service.dart';

class LottoDrawer extends StatelessWidget {
  const LottoDrawer({
    Key? key,
    required this.lottos,
  }) : super(key: key);

  final List<Lotto> lottos;

  @override
  Widget build(BuildContext context) {
    final prizeService = PrizeService();
    return Drawer(
      child: ListView.builder(
        
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: lottos.length,
        itemBuilder: (context, index) {
          return Column(
            children: [   
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8, bottom: 0),
                child: Container(
                  color: const Color.fromRGBO(239,242,248, 1),
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () async {
                      var prize = await prizeService.getLastest(lottos[index].id);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => PrizeDetailPage(lotto: lottos[index], prize: prize,)
                        )
                      );                      
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 15,                                         
                          child: ClipOval(
                            child: SizedBox.fromSize(
                              size: const Size.fromRadius(20), // Image radius
                              child: CountryPickerUtils.getDefaultFlagImage(
                                CountryPickerUtils.getCountryByIsoCode(
                                    lottos[index].country)),
                            ),                      
                          ),                    
                        ), 
                        const SizedBox(width: 5,),
                        Expanded(
                          child: Text(lottos[index].name,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                        Text(lottos[index].code,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.normal) 
                        ), 
                      ]
                    ),
                  ),
                ),
              ),              
            ],
          );
        }));
  }
}