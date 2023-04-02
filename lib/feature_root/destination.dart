import 'package:flutter/material.dart';

class Destination {
  const Destination(this.title, this.icon, this.widget);
  final Function(BuildContext context) title;
  final IconData icon;
  final Widget widget;
}