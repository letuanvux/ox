import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import 'utils.dart';

class Upload {
  static Future<String?> image(String dir) async {
    var deviceId = await Utils.getDeviceId();
    //Check Permissions
    await Permission.photos.request();
    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      //Select Image
      ImagePicker imagePicker = ImagePicker();
      var image = await imagePicker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        var file = File(image.path);
        var now = DateTime.now();
        //Upload to Firebase
        Reference reference =
            FirebaseStorage.instance.ref().child('${dir}/${now.year}/${now.month}/${now.day}/${deviceId}${now.millisecondsSinceEpoch}');
        UploadTask uploadTask = reference.putFile(file);
        TaskSnapshot snapshot = await uploadTask;
        return await snapshot.ref.getDownloadURL();
      } else {
        print('No Image Path Received');
      }
    } else {
      print('Permission not granted. Try Again with permission access');
    }
    return null;
  }
}
