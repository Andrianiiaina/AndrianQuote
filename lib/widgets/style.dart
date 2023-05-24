import 'package:flutter/material.dart';

Widget TextWidget(texte) {
  return Text(
    texte,
    style: const TextStyle(
      fontSize: 23,
      color: Colors.purple,
      fontWeight: FontWeight.bold,
    ),
  );
}

Widget TextFieldWidget(controller, text) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(hintText: text),
    keyboardType: TextInputType.multiline,
    // maxLines: 9,
    // minLines: 4,
  );
}
