import 'dart:async';

import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart';
import 'package:http/http.dart' as http;

import '../util/log_util.dart';

class GoogleSignInPort {
  static const _tag = "GoogleSignInPort";
  static const List<String> _scopes = <String>[
    DriveApi.driveFileScope,
    DriveApi.driveAppdataScope,
  ];
  static final _instance = GoogleSignInPort._internal();

  GoogleSignInPort._internal();

  factory GoogleSignInPort() {
    return _instance;
  }

  final _googleSignIn = GoogleSignIn(
    scopes: _scopes,
  );

  Future<http.Client?> get httpClient => _googleSignIn.authenticatedClient();

  Future<bool> signIn() async {
    try {
      return await _googleSignIn.signIn() != null;
    } catch (e) {
      Log.e(_tag, "Cannot sign in, error = $e");
    }
    return false;
  }

  Future<bool> signOut() async {
    try {
      return await _googleSignIn.signOut() == null;
    } catch (e) {
      Log.e(_tag, "Cannot sign out, error = $e");
    }
    return false;
  }
}
