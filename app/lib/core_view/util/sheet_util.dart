import 'package:flutter/material.dart';

class SheetUtil {
  static Future<T?> showSheet<T>({
    required BuildContext context,
    required WidgetBuilder builder,
  }) =>
      showModalBottomSheet<T>(
        isScrollControlled: true,
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.zero,
            topLeft: Radius.circular(15),
            bottomRight: Radius.zero,
            topRight: Radius.circular(15),
          ),
        ),
        builder: (context) {
          return builder(context);
        },
      );
}
