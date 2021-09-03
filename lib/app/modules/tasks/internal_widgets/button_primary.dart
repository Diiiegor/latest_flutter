import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ButtonPrimary extends StatelessWidget {
  const ButtonPrimary(
      {Key? key,
      required this.onTab,
      required this.child,
      required this.width,
      required this.height})
      : super(key: key);
  final VoidCallback onTab;
  final Widget child;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: TextButton(
          child: child,
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
            backgroundColor:
                MaterialStateProperty.all<Color>(Get.theme.primaryColor),
          ),
          onPressed: onTab),
    );
  }
}
