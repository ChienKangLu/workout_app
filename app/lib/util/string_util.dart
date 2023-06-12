extension StringExtension on String {
  String trimTrailingZero(int digits) {
    final parts = split(".");
    if (parts.length != digits) {
      return "";
    }

    final buffer = StringBuffer(parts[0]);
    final decimalPart = parts[1].replaceAll("0", "");

    if (decimalPart.isNotEmpty) {
      buffer.write(".$decimalPart");
    }

    return buffer.toString();
  }
}