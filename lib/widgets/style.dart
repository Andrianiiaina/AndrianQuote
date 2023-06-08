import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget textWidget(texte) {
  return Text(
    texte,
    style: const TextStyle(
        fontSize: 20,
        color: Color.fromARGB(255, 230, 116, 250),
        fontWeight: FontWeight.bold,
        fontFamily: "San Francisco"),
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

Widget textFieldWidgetNumber(controller, text, readOnly) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(hintText: text),
    readOnly: readOnly,
    keyboardType: TextInputType.number,
    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
  );
}

Widget textareaWidget(controller, text, readOnly) {
  return TextField(
    readOnly: readOnly,
    controller: controller,
    decoration: InputDecoration(hintText: text),
    keyboardType: TextInputType.multiline,
    maxLines: 9,
    minLines: 3,
  );
}

Widget iconBottomStyle(func, icon) {
  return IconButton(onPressed: func, icon: icon);
}

Future showForm(BuildContext context, child) async {
  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    elevation: 2,
    builder: (_) => Container(
      padding: EdgeInsets.only(
          left: 10,
          top: 0,
          right: 10,
          bottom: MediaQuery.of(context).viewInsets.bottom),
      child: child,
    ),
  );
}

Widget star(int nbr) {
  return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 5,
      itemBuilder: ((context, index) {
        return Icon(
          (index < nbr) ? Icons.star : Icons.star,
          size: 15,
          color: (index < nbr)
              ? const Color.fromARGB(255, 236, 149, 252)
              : Colors.grey,
        );
      }));
}
