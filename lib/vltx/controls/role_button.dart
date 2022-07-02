import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../cards/card.dart';
import '../utils/colors.dart';
import '../utils/font_size.dart';

class VLTxRoleButton extends StatelessWidget {
  final String label;
  final IconData iconData;
  final bool selected;

  const VLTxRoleButton({
    Key? key,
    required this.label,
    required this.iconData,
    this.selected = false,
  })  :  super(key: key);

  @override
  Widget build(BuildContext context) {
    return VLTxCard(
      width: ScreenUtil().setWidth(177),
      height: ScreenUtil().setHeight(120),
      active: selected,
      alignment: Alignment.centerLeft,
      child: AnimatedSwitcher(
        duration: const Duration(
          milliseconds: 300,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Opacity(
              opacity: selected ? 0.3 : 1.0,
              child: Container(
                width: ScreenUtil().setWidth(48),
                height: ScreenUtil().setWidth(48),
                decoration: BoxDecoration(
                  color: selected ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(
                    ScreenUtil().setWidth(10),
                  ),
                ),
                child: Icon(
                  iconData,
                  color: selected ? Colors.white : VLTxColors.blue,
                ),
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(6),
            ),
            Text(
              '$label',
              style: TextStyle(
                color: selected ? Colors.white : VLTxColors.blue,
                fontSize: FontSize.fontSize16,
                fontWeight: FontSize.semiBold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
