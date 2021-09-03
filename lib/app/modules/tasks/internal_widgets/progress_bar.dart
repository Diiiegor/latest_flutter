import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({Key? key, required this.percent}) : super(key: key);
  final double percent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 10,
      child: LayoutBuilder(builder: (_, constrains) {
        return Align(
          alignment: Alignment.centerLeft,
          child: Container(
            height: 10,
            width: (percent.isNaN ? 0 : percent * constrains.maxWidth) / 100,
            decoration: BoxDecoration(
                color: Get.theme.primaryColor,
                borderRadius: BorderRadius.circular(20)),
          ),
        );
      }),
      decoration: BoxDecoration(
          color: Colors.grey[300], borderRadius: BorderRadius.circular(20)),
    );
  }
}
