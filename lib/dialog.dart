import 'tts.dart';
import 'object.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

AlertDialog popUpImage(BuildContext context, PopImage popImage) {
  return AlertDialog(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(popImage.imageName),
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
            popImage.path2Image,
            width: 60.w,
            height: 60.h,
          ),
        );
      },
    ),
    actionsAlignment: MainAxisAlignment.center,
    actions: [
      Text2Speech(textToSpeak: popImage.imageText),
    ],
  );
}
