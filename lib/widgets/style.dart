import 'package:flutter/material.dart';

Widget textWidget(texte) {
  return Text(
    texte,
    style: const TextStyle(
      fontSize: 23,
      color: Colors.purple,
      fontWeight: FontWeight.bold,
    ),
  );
}

Widget textFieldWidget(controller, text) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(hintText: text),
    keyboardType: TextInputType.multiline,
    // maxLines: 9,
    // minLines: 4,
  );
}
