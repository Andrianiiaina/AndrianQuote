import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final bottomDatas = [
  const BottomNavigationBarItem(
      icon: Icon(Icons.book), label: 'Books', tooltip: "Books"),
  const BottomNavigationBarItem(
      icon: Icon(Icons.bookmark), label: 'quote', tooltip: "Quotes"),
  const BottomNavigationBarItem(
      icon: Icon(Icons.watch_later), label: 'wishlist', tooltip: "wishlist"),
];
var themeLight = ThemeData.light().copyWith(
  backgroundColor: Colors.deepPurple,
  listTileTheme: ListTileThemeData(textColor: Colors.black54),
  hintColor: Colors.grey,
  primaryColorLight: Colors.white,
  colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Colors.deepPurple,
      onPrimary: Colors.white,
      secondary: Colors.purple,
      onSecondary: Colors.purple,
      error: Colors.red,
      onError: Colors.red,
      background: Colors.purple,
      onBackground: Colors.purple,
      surface: Colors.purple,
      onSurface: Colors.white), //ex: style underline
);
Widget titre(String texte, context) {
  return Text(texte,
      style: TextStyle(
          fontSize: 25,
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
          fontFamily: "San Francisco"));
}

Widget textareaWidgetForm(controller, text, readOnly) {
  return TextField(
    readOnly: readOnly,
    controller: controller,
    decoration: InputDecoration(label: Text(text)),
    keyboardType: TextInputType.multiline,
    maxLines: 15,
    minLines: 3,
    style: TextStyle(color: Colors.grey.shade600),
  );
}

Widget textWidget(texte) {
  return Text(
    texte,
    style: const TextStyle(
        fontSize: 25,
        color: Color.fromARGB(255, 230, 116, 250),
        fontWeight: FontWeight.bold,
        fontFamily: "San Francisco"),
  );
}

Widget textFieldWidget(controller, text, readOnly) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(label: Text(text)),
    style: TextStyle(color: Colors.grey.shade600),
    readOnly: readOnly,
    keyboardType: TextInputType.multiline,
    validator: (value) {
      if (value == "") return "Veuillez remplir ce champ";
      return null;
    },
  );
}

Widget textFieldWidgetNumber(controller, text, readOnly) {
  return TextFormField(
    controller: controller,
    style: TextStyle(color: Colors.grey),
    decoration: InputDecoration(label: Text(text)),
    readOnly: readOnly,
    keyboardType: TextInputType.number,
    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
  );
}

Widget textareaWidget(controller, text, readOnly) {
  return TextField(
    readOnly: readOnly,
    controller: controller,
    decoration: InputDecoration(label: Text(text)),
    keyboardType: TextInputType.multiline,
    maxLines: 20,
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
    elevation: 1,
    builder: (_) => Container(
      height: MediaQuery.of(context).size.height,
      alignment: Alignment.topCenter,
      child: child,
    ),
  );
}

Widget star(int nbr) {
  return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 5,
      itemBuilder: ((context, index) {
        final int r = (nbr % 2);
        final int q = (nbr ~/ 2);
        return Icon(
          (index < q)
              ? Icons.star
              : (r == 1 && index == q)
                  ? Icons.star_half
                  : Icons.star,
          size: 15,
          color: (index < q)
              ? const Color.fromARGB(255, 236, 149, 252)
              : (index == q && r == 1)
                  ? const Color.fromARGB(255, 236, 149, 252)
                  : Colors.grey,
        );
      }));
}
