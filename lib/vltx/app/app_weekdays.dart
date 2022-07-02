import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppWeekdays extends StatefulWidget {
  final Function onSelect;
  // list to insert the selected days.
  final List<String> selectedDays;
  final bool border = false;

  const AppWeekdays(
      {Key? key, required this.onSelect, required this.selectedDays})
      : super(key: key);

  @override
  State<AppWeekdays> createState() => _AppWeekdaysState();
}

class _AppWeekdaysState extends State<AppWeekdays> {
  // list of days in a week.
  final List<DayInWeek> _days = [
    DayInWeek(1,'Sunday'),
    DayInWeek(2,'Monday'),      
    DayInWeek(3,'Tuesday'),
    DayInWeek(4,'Wednesday'),
    DayInWeek(5,'Thursday'),
    DayInWeek(6,'Friday'),
    DayInWeek(7,'Saturday'),    
  ];

  void _getSelectedWeekDays(bool isSelected, String day) {
    if (isSelected == true) {
      if (!widget.selectedDays.contains(day)) {
        widget.selectedDays.add(day);
      }
    } else if (isSelected == false) {
      if (widget.selectedDays.contains(day)) {
        widget.selectedDays.remove(day);
      }
    }
    // [onSelect] is the callback which passes the Selected days as list.
    widget.onSelect(widget.selectedDays.toList());
  }

  @override
  Widget build(BuildContext context) {
    // Set selectdays
    for (var i = 0; i < widget.selectedDays.length; i++) {
      _days
          .where((element) => element.day.toString() == widget.selectedDays[i])
          .first
          .isSelected = true;
    }

    return Container(      
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(
          ScreenUtil().setWidth(5.0),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(5.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _days.map(
            (item) {
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(5.0)),
                  child: RawMaterialButton(                    
                    fillColor: item.isSelected == true ? Colors.white : null,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(ScreenUtil().setWidth(5.0)),
                      side: widget.border
                          ? const BorderSide(
                              color: Colors.white,
                            )
                          : BorderSide.none,
                    ),
                    onPressed: () {
                      setState(() {
                        item.toggleIsSelected();
                      });
                      _getSelectedWeekDays(item.isSelected, item.day.toString());
                    },
                    child: Padding(
                      padding: EdgeInsets.all(ScreenUtil().setWidth(5.0)),
                      child: Text(
                        item.name.substring(0, 3),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: item.isSelected ? Colors.black : Colors.black54,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}

class DayInWeek {
  int day;
  String name;
  bool isSelected = false;
  DayInWeek(this.day, this.name);

  void toggleIsSelected() {
    isSelected = !isSelected;
  }
}
