import 'package:flutter/material.dart';

Widget ordercard({String? title, String? subtitle}) {
  return Row(
    children: [
      Text(
        title!,
        textScaleFactor: 1.5,
        style: const TextStyle(fontWeight: FontWeight.w700),
      ),
      Text(
        subtitle!,
        textScaleFactor: 1.2,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
    ],
  );
}
