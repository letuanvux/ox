import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../utils/colors.dart';
import '../../utils/font_size.dart';
import '../deadline_card/deadline_card.dart';
import 'assignment_card_file_element.dart';
import 'file_wrapper.dart';

class AssignmentCard extends StatelessWidget {
  final String question;
  final String subject;
  final String teacher;
  final DateTime deadline;
  final Color? deadlineBackgroundColor;
  final Color? deadlineTextColor;
  final Function()? onUploadHandler;
  final List<FileWrapper>? fileList;

  const AssignmentCard({
    Key? key,
    required this.question,
    required this.subject,
    required this.teacher,
    required this.deadline,
    this.deadlineBackgroundColor,
    this.deadlineTextColor,
    this.onUploadHandler,
    this.fileList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(374),
      height: ScreenUtil().setHeight(140),
      padding: EdgeInsets.symmetric(
        vertical: ScreenUtil().setHeight(15),
        horizontal: ScreenUtil().setWidth(15),
      ),
      constraints: BoxConstraints(
        minHeight: ScreenUtil().setHeight(140),
      ),
      decoration: BoxDecoration(
        color: VLTxColors.blueGrey,
        borderRadius: BorderRadius.circular(
          ScreenUtil().setWidth(10),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(
                FontAwesomeIcons.questionCircle,
                color: VLTxColors.mediumGrey,
                size: FontSize.fontSize16,
              ),
              SizedBox(
                width: ScreenUtil().setWidth(5),
              ),
              SizedBox(
                width: ScreenUtil().setWidth(320),
                child: Text(
                  '$question',
                  style: TextStyle(
                    color: VLTxColors.darkBlack,
                    fontSize: FontSize.fontSize16,
                    fontWeight: FontSize.semiBold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: ScreenUtil().setHeight(20),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                FontAwesomeIcons.book,
                color: VLTxColors.mediumGrey,
                size: FontSize.fontSize16,
              ),
              SizedBox(
                width: ScreenUtil().setWidth(7),
              ),
              Text(
                '$subject',
                style: TextStyle(
                  color: VLTxColors.mediumGrey,
                  fontSize: FontSize.fontSize14,
                  fontWeight: FontSize.medium,
                ),
              ),
            ],
          ),
          SizedBox(
            height: ScreenUtil().setHeight(10),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                FontAwesomeIcons.userGraduate,
                color: VLTxColors.mediumGrey,
                size: FontSize.fontSize16,
              ),
              SizedBox(
                width: ScreenUtil().setWidth(7),
              ),
              Text(
                '$teacher',
                style: TextStyle(
                  color: VLTxColors.mediumGrey,
                  fontSize: FontSize.fontSize14,
                  fontWeight: FontSize.medium,
                ),
              ),
            ],
          ),
          SizedBox(
            height: ScreenUtil().setHeight(15),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              if (deadline != null)
                DeadlineCard(
                  deadline: deadline,
                  primaryColor: deadlineTextColor,
                  secondaryColor: deadlineBackgroundColor,
                ),
              Expanded(
                child: Container(),
              ),
              if (onUploadHandler != null)
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: ScreenUtil().setWidth(36),
                    maxWidth: ScreenUtil().setWidth(36),
                  ),
                  child: FlatButton(
                    onPressed: onUploadHandler,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        ScreenUtil().setWidth(10),
                      ),
                      side: BorderSide(
                        color: VLTxColors.blue,
                        width: ScreenUtil().setWidth(1),
                      ),
                    ),
                    splashColor: VLTxColors.lightBlue,
                    padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(5.0),
                    ),
                    child: Icon(
                      Icons.file_upload,
                      size: FontSize.fontSize18,
                      color: VLTxColors.blue,
                    ),
                  ),
                ),
            ],
          ),
          if (fileList != null && ((fileList?.length ?? 0) > 0)) ...[
            SizedBox(
              height: ScreenUtil().setHeight(10),
            ),
            ...?fileList?.map((e) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: ScreenUtil().setHeight(10),
                ),
                child: AssignmentCardFileElement(fileWrapper: e),
              );
            }).toList(),
          ]
        ],
      ),
    );
  }
}
