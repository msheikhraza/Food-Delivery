import 'package:flutter/material.dart';

Widget appButton({VoidCallback? voidCallback, String? title}) {
  return InkWell(
    onTap: voidCallback,
    child: Container(
      height: 40,
      decoration: BoxDecoration(
          color: Colors.green, borderRadius: BorderRadius.circular(5)),
      child: Center(
          child: Text(
        title!,
        style:
            const TextStyle(fontWeight: FontWeight.w700, color: Colors.white),
        textScaleFactor: 1.3,
      )),
    ),
  );
}
