import 'dart:developer';

class Log {
  static void d(String tag, String message) {
    log("[$tag] $message");
  }
}