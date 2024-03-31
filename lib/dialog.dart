import 'tts.dart';
import 'object.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

Widget popUpImage(BuildContext context, PopImage popImage) {
  return StatefulBuilder(
    builder: (BuildContext context, StateSetter setAtomState) {
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
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Image.asset(
                    popImage.path2Image,
                    width: 30.w,
                    height: 60.h,
                    fit: BoxFit.contain,
                  ),
                ),
                if (popImage.isShow)
                  SingleChildScrollView(
                    child: Container(
                      width: 20.w,
                      margin: const EdgeInsets.only(left: 35),
                      alignment: Alignment.center,
                      child: Text(popImage.imageText, style: const TextStyle(fontSize: 20)),
                    ),
                  ),
              ],
            );
          },
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          Text2Speech(
            popImage: popImage,
            onOpen: () {
              setAtomState(() {
                popImage.isShow = !popImage.isShow;
              });
            },
          ),
        ],
      );
    },
  );
}
