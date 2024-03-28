import 'tts.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

AlertDialog popUpImage(BuildContext context, String imageName, path2Image) {
  return AlertDialog(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(imageName),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.close),
        ),
      ],
    ),
    content: StatefulBuilder(
      builder: (BuildContext context, StateSetter setAtomState) {
        return FittedBox(
          fit: BoxFit.fitWidth,
          child: Image.asset(
            path2Image,
            width: 60.w,
            height: 60.h,
          ),
        );
      },
    ),
    actionsAlignment: MainAxisAlignment.center,
    actions: [
      Text2Speech(textToSpeak: imageName),
    ],
  );
}
