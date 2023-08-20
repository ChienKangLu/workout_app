import 'dart:async';
import 'dart:io';

import '../port/google_drive_port.dart';
import '../port/google_sign_in_port.dart';
import '../port/model/port_file.dart';

class GoogleRepository {
  final _signInPort = GoogleSignInPort();
  final _drivePort = GoogleDrivePort();

  Future<bool> uploadFile(String folder, File file) async {
    if (await _signInPort.signIn() == false) {
      return false;
    }

    return await _drivePort.upload(folder, file);
  }

  Future<List<PortFile>> getFileList(String folder) async {
    if (await _signInPort.signIn() == false) {
      return [];
    }

    return await _drivePort.getFileList(folder);
  }

  Future<File?> download(PortFile portFile) async {
    if (await _signInPort.signIn() == false) {
      return null;
    }

    return await _drivePort.download(portFile);
  }
}
