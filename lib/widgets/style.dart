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

Widget textFieldWidget(controller, text, readOnly) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(hintText: text),
    readOnly: readOnly,
    keyboardType: TextInputType.multiline,
  );
}

Widget textareaWidget(controller, text, readOnly) {
  return TextField(
    readOnly: readOnly,
    controller: controller,
    decoration: InputDecoration(hintText: text),
    keyboardType: TextInputType.multiline,
    maxLines: 9,
    minLines: 2,
  );
}

Widget iconBottomStyle(func, icon) {
  return IconButton(onPressed: func, icon: icon);
}

Future showForm(BuildContext context, truc) async {
  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    elevation: 5,
    builder: (_) => Container(
      padding: EdgeInsets.only(
          left: 10,
          top: 2,
          right: 10,
          bottom: MediaQuery.of(context).viewInsets.bottom),
      child: truc,
    ),
  );
}
