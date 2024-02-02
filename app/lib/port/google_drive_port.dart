import 'dart:io' as io;

import 'package:flutter/foundation.dart';
import 'package:googleapis/drive/v3.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../util/log_util.dart';
import 'google_sign_in_port.dart';
import 'model/port_file.dart';

class DriveApiFactory {
  static const _tag = "DriveApiFactory";

  Future<DriveApi?> create(GoogleSignInPort signInPort) async {
    var httpClient = await signInPort.httpClient;
    if (httpClient == null) {
      Log.e(_tag, "Cannot get authenticated Client");
      return null;
    }

    return DriveApi(httpClient);
  }
}

class GoogleDrivePort {
  static const _tag = "GoogleDrivePort";
  static const _mimeTypeGoogleDriveFolder =
      "application/vnd.google-apps.folder";
  static final _signInPort = GoogleSignInPort();

  static GoogleDrivePort? _instance;
  static GoogleDrivePort get instance =>
      _instance ??= GoogleDrivePort._internal();

  static DriveApiFactory _driveApiFactory = DriveApiFactory();
  static Future<DriveApi?> get _driveApi =>
      _driveApiFactory.create(_signInPort);

  GoogleDrivePort._internal();

  factory GoogleDrivePort() => instance;

  Future<bool> upload(String folder, io.File file) async {
    final driveApi = await _driveApi;
    if (driveApi == null) {
      return false;
    }

    final folderId = await _getFolderId(driveApi, folder);
    if (folderId == null) {
      return false;
    }

    final timestamp = DateFormat("yyyy-MM-dd-hhmmss").format(DateTime.now());
    final driveFile = File()
      ..name = "$timestamp-${basename(file.path)}"
      ..modifiedTime = DateTime.now().toUtc()
      ..parents = [folderId];

    try {
      final responseDriveFile = await driveApi.files.create(
        driveFile,
        uploadMedia: Media(file.openRead(), file.lengthSync()),
      );

      if (driveFile.name != responseDriveFile.name) {
        Log.w(_tag, "Upload result in inconsistent file name");
        return true;
      }

      return true;
    } catch (e) {
      Log.e(_tag, "Cannot upload ${file.path} to $folder, error = $e");
      return false;
    }
  }

  Future<List<PortFile>> getFileList(String folder) async {
    final driveApi = await _driveApi;
    if (driveApi == null) {
      return [];
    }

    final folderId = await _getFolderId(driveApi, folder);
    if (folderId == null) {
      return [];
    }

    try {
      final fileList = await driveApi.files.list(
        q: "'$folderId' in parents and trashed = false",
        $fields: "files(id, name)",
      );

      final files = fileList.files;
      if (files == null || files.isEmpty) {
        return [];
      }

      return files.toPortFiles();
    } catch (e) {
      Log.e(_tag, "Cannot get file list from folder $folder, error = $e");
      return [];
    }
  }

  Future<io.File?> download(PortFile portFile) async {
    final driveApi = await _driveApi;
    if (driveApi == null) {
      return null;
    }

    try {
      final media = await driveApi.files.get(portFile.id,
          downloadOptions: DownloadOptions.fullMedia) as Media;

      final folder = await getTemporaryDirectory();
      final localFile = io.File("${folder.path}/${portFile.name}");
      final ioSink = localFile.openWrite();
      await ioSink.addStream(media.stream);
      await ioSink.flush();
      await ioSink.close();
      return localFile;
    } catch (e) {
      Log.e(_tag,
          "Cannot download ${portFile.name} (id: ${portFile.id}), error = $e");
      return null;
    }
  }

  Future<String?> _getFolderId(DriveApi driveApi, String folderName) async {
    try {
      final folder = File()
        ..name = folderName
        ..mimeType = _mimeTypeGoogleDriveFolder;
      final folderCreation = await driveApi.files.create(folder);

      return folderCreation.id;
    } catch (e) {
      Log.e(_tag, "Cannot get folder ID, error = $e");
    }
    return null;
  }

  @visibleForTesting
  static void setUpInstance(GoogleDrivePort instance) {
    _instance = instance;
  }

  @visibleForTesting
  static void setUpDriveApiFactory(DriveApiFactory driveApiFactory) {
    _driveApiFactory = driveApiFactory;
  }
}

extension _FileExtension on List<File> {
  List<PortFile> toPortFiles() {
    final portFiles = <PortFile>[];
    for (final file in this) {
      final id = file.id;
      if (id == null) {
        continue;
      }
      portFiles.add(PortFile(id, file.name));
    }
    return portFiles;
  }
}
