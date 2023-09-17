import 'package:flutter/material.dart';

enum EmptyViewAlignment {
  center,
  slightTop,
  top,
}

class EmptyView extends StatelessWidget {
  const EmptyView({
    super.key,
    this.alignment = EmptyViewAlignment.slightTop,
    this.assetName,
    this.header,
    this.body,
    this.buttonTitle,
    this.onAction,
  });

  final EmptyViewAlignment alignment;
  final String? assetName;
  final String? header;
  final String? body;
  final String? buttonTitle;
  final void Function()? onAction;

  @override
  Widget build(BuildContext context) {
    final int topFlex;
    final int bottomFlex;
    switch (alignment) {
      case EmptyViewAlignment.center:
        topFlex = 1;
        bottomFlex = 1;
        break;
      case EmptyViewAlignment.slightTop:
        topFlex = 2;
        bottomFlex = 3;
        break;
      case EmptyViewAlignment.top:
        topFlex = 1;
        bottomFlex = 2;
        break;
    }

    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Spacer(flex: topFlex),
          if (assetName != null) ...[
            Image.asset(
              assetName!,
              width: 145,
              fit: BoxFit.fitWidth,
            ),
          ],
          if (header != null) ...[
            const SizedBox(height: 15),
            Text(
              header!,
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
          ],
          if (body != null) ...[
            const SizedBox(height: 5),
            Text(
              body!,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.outline,
                  ),
              textAlign: TextAlign.center,
            )
          ],
          if (buttonTitle != null) ...[
            const SizedBox(height: 30),
            FilledButton.tonal(
              onPressed: onAction,
              child: Text(
                buttonTitle!,
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ),
          ],
          Spacer(flex: bottomFlex),
        ],
      ),
    );
  }
}
