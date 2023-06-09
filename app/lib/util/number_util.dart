class NumberUtil {
  static double toPrecision(double value, int digits) =>
      double.parse(value.toStringAsFixed(digits));
}
