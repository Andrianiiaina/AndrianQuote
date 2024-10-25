import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'settings.dart';
import 'package:select_form_field/select_form_field.dart';

final bottomDatas = [
  const BottomNavigationBarItem(
      icon: Icon(Icons.book), label: 'Books', tooltip: "Books"),
  const BottomNavigationBarItem(
      icon: Icon(Icons.bookmark), label: 'quote', tooltip: "Quotes"),
  const BottomNavigationBarItem(
      icon: Icon(Icons.graphic_eq),
      label: 'statistique',
      tooltip: "Statistiques"),
  const BottomNavigationBarItem(
      icon: Icon(Icons.watch_later), label: 'wishlist', tooltip: "wishlist"),
];

var themeLight = ThemeData.light().copyWith(
    dialogBackgroundColor: Colors.white,
    datePickerTheme: const DatePickerThemeData(backgroundColor: Colors.white),
    appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        titleTextStyle: TextStyle(
            color: Colors.purple, fontSize: 18, fontFamily: "Roboto")),
    listTileTheme: const ListTileThemeData(textColor: Colors.black54),
    hintColor: Colors.grey,
    primaryColorLight: Colors.white,
    colorScheme: const ColorScheme(
            brightness: Brightness.light,
            primary: Colors.deepPurple,
            onPrimary: Colors.purple,
            secondary: Colors.purple,
            onSecondary: Colors.purple,
            error: Colors.red,
            onError: Colors.red,
            background: Colors.purple,
            onBackground: Colors.purple,
            surface: Colors.purple,
            onSurface: Colors.purple)
        .copyWith(
      background: Colors.white,
    ));

Widget textareaWidgetForm(controller, text, readOnly) {
  return TextField(
    readOnly: readOnly,
    controller: controller,
    decoration: InputDecoration(
        label: Text(
      text,
      style: const TextStyle(decoration: TextDecoration.none),
    )),
    keyboardType: TextInputType.multiline,
    maxLines: 14,
    minLines: 3,
    style: const TextStyle(color: Colors.white),
  );
}

Widget textWidget(String text) {
  return Text(
    text,
    style: const TextStyle(
        fontSize: 22,
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontFamily: "Roboto"),
  );
}

Widget textFieldWidget(controller, String text, bool readOnly) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(label: Text(text)),
    style:
        const TextStyle(decoration: TextDecoration.none, color: Colors.white),
    readOnly: readOnly,
    keyboardType: TextInputType.multiline,
    validator: (value) {
      if (value == "") return "Veuillez remplir ce champ";
      return null;
    },
  );
}

Widget textFieldWidgetNumber(controller, String text, bool readOnly) {
  return TextFormField(
    controller: controller,
    style: const TextStyle(color: Colors.white),
    decoration: InputDecoration(label: Text(text)),
    readOnly: readOnly,
    keyboardType: TextInputType.number,
    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
    validator: (value) {
      if (value == "") return "Veuillez remplir ce champ";
      return null;
    },
  );
}

Widget selectFormWidget(
    controller, String title, List<Map<String, dynamic>> datas) {
  return SelectFormField(
    decoration: InputDecoration(hintText: controller.text, label: Text(title)),
    type: SelectFormFieldType.dialog,
    controller: controller,
    items: datas,
    style: const TextStyle(color: Colors.white),
    validator: (value) {
      if (value == "") return "Veuillez remplir ce champ";
      return null;
    },
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

Future showConfirmation(
    BuildContext context, _title, _content, Function _operation) async {
  await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(_title),
          content: Text(_content),
          actions: [
            TextButton(
                onPressed: () {
                  _operation();
                },
                child: const Text('Confirmer')),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Annuler')),
          ],
        );
      });
}

showMessage(BuildContext context, _content) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      _content,
      style: const TextStyle(color: Colors.white),
    ),
    duration: const Duration(seconds: 3),
  ));
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

Widget statisticButton(String title, action) {
  return Expanded(
      child: GestureDetector(
          onTap: action,
          child: Container(
            child: Text(
              title,
              style: const TextStyle(color: Colors.white),
            ),
            // height: 100,
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(5),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: const Color.fromARGB(194, 136, 16, 200),
                border:
                    Border.all(color: const Color.fromARGB(255, 176, 79, 194)),
                borderRadius: const BorderRadius.all(Radius.circular(15))),
          )));
}

Widget drawer = const Drawer(
  child: Settings(),
  width: 300,
);
Widget searchWidget(search) {
  return Container(
      height: 48,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.purple)),
      margin: const EdgeInsets.only(left: 9, right: 9, top: 2),
      child: TextField(
        autofocus: false,
        decoration: const InputDecoration(
            hintText: "search...",
            prefixIcon: Icon(
              Icons.search,
              color: Colors.purple,
            ),
            border: InputBorder.none),
        onChanged: (q) {
          search(q);
        },
      ));
}

final List<Color> bookColors = [
  const Color.fromARGB(156, 88, 2, 208),
  const Color.fromARGB(186, 97, 2, 145),
  const Color.fromARGB(186, 65, 41, 221),
  const Color.fromARGB(172, 44, 0, 60),
  const Color.fromARGB(211, 210, 67, 67),
  const Color.fromARGB(135, 204, 47, 186),
  const Color.fromARGB(181, 230, 91, 91),
  const Color.fromARGB(160, 76, 81, 240),
  const Color.fromARGB(133, 36, 131, 200),
  const Color.fromARGB(134, 184, 4, 178),
  Color.fromARGB(156, 180, 4, 174),
];
