import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/material.dart';
import '../../lotto/models/lotto.dart';
import '../../lotto/prize_detail_page.dart';
import '../../themes.dart';

class CommingTile extends StatelessWidget {
  final List<Lotto> items;
  const CommingTile({
    Key? key, required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.only(bottom: VLTxTheme.padding),
      child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: items.length,
          separatorBuilder: (BuildContext context, int index) =>
              const SizedBox(width: 10),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () async {                
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => PrizeDetailPage(lotto: items[index],)
                  )
                );
              }, 
              child: Container(
                width: 140,
                margin: const EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      offset: const Offset(4, 4),
                      blurRadius: 10,
                      color: Colors.grey.withOpacity(.2),
                    ),
                    BoxShadow(
                      offset: const Offset(-3, 0),
                      blurRadius: 15,
                      color: Colors.grey.withOpacity(.1),
                    )
                  ],
                ),                
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(VLTxTheme.radius),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(right: VLTxTheme.padding / 2),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.3),
                            borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(VLTxTheme.radius / 2),
                                topLeft: Radius.circular(VLTxTheme.radius / 2))),
                        child: Row(
                          mainAxisAlignment : MainAxisAlignment.spaceBetween,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(VLTxTheme.radius),
                                topLeft: Radius.circular(VLTxTheme.radius)
                              ),
                              child: CountryPickerUtils.getDefaultFlagImage(
                                      CountryPickerUtils.getCountryByIsoCode(
                                          items[index].country)),
                            ),                        
                            Text(
                              items[index].drawtime,
                              style:
                                  const TextStyle(color: Colors.black45, fontSize: 11,),
                            ),
                          ],
                        ),
                      ),                  
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(VLTxTheme.padding / 2),
                          alignment: Alignment.center,                    
                          child: Center(
                            child: Text(
                              items[index].name,
                              style: const TextStyle(
                                color: Colors.black45, 
                                fontSize: 12,                        
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                        ),
                      ),  
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
