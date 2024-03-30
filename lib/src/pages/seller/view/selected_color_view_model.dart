import 'package:flutter/material.dart';

class SelectedColorViewModel {
  SelectedColorViewModel({this.color, this.isEnabled, this.onRemovePressed});
  final Color? color;
  final bool? isEnabled;
  void Function()? onRemovePressed;
}
