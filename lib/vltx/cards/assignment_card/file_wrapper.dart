import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FileWrapper {
  final String fileName;
  final String fileSize;
  final Function()? onTap;
  final IconData icon;

  FileWrapper({
    required this.fileName,
    required this.fileSize,
    this.onTap,
    this.icon = FontAwesomeIcons.download,
  });
}
