import 'dart:developer';

class Log {
  static void d(String tag, String message) {
    log("[$tag] D: $message");
  }

  static void e(String tag, String message, [Exception? e]) {
    if (e != null) {
      log("[$tag] E: $message, error: $e");
    } else {
      log("[$tag] E: $message");
    }
  }

  static void w(String tag, String message) {
    log("[$tag] W: $message");
  }
}
