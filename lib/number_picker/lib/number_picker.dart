library number_picker;

import 'package:flutter/material.dart';

class CustomNumberPicker extends StatefulWidget {
  const CustomNumberPicker(
      {super.key,
      required this.onLeftButtonPressed,
      required this.onRightButtonPressed,
      required this.textData});
  final int textData;
  final void Function()? onLeftButtonPressed;
  final void Function()? onRightButtonPressed;
  @override
  State<CustomNumberPicker> createState() => _CustomNumberPickerState();
}

class _CustomNumberPickerState extends State<CustomNumberPicker> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        leftButton(
          onPressed: widget.onLeftButtonPressed,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: middleText(count: widget.textData.toString()),
        ),
        rightButton(
          onPressed: widget.onRightButtonPressed,
        )
      ],
    );
  }

  Widget leftButton({required void Function()? onPressed}) =>
      IconButton(onPressed: onPressed, icon: const Icon(Icons.arrow_back));

  Widget rightButton({required void Function()? onPressed}) =>
      IconButton(onPressed: onPressed, icon: const Icon(Icons.arrow_forward));

  Widget middleText({required String count}) => Container(
        width: 35,
        height: 35,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          border: Border.all(
            width: 1,
          ),
        ),
        child: Center(
          child: Text(count),
        ),
      );
}
