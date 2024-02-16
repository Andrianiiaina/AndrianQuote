import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'settings.dart';

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
    style: const TextStyle(color: Colors.grey),
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

Future ShowConfirmation(
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
    content: Text(_content),
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

Widget statisticButton(String title) {
  return Expanded(
      flex: 1,
      child: Container(
        child: Text(title),
        height: 100,
        margin: const EdgeInsets.all(5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white10,
            border: Border.all(color: Colors.purpleAccent),
            borderRadius: const BorderRadius.all(Radius.circular(15))),
      ));
}

Widget statisticText(String title) {
  return Container(
    child: Text(
      title,
      style: const TextStyle(fontWeight: FontWeight.w400),
    ),
    padding: const EdgeInsets.all(10),
    margin: const EdgeInsets.all(2),
    alignment: Alignment.topLeft,
    decoration: BoxDecoration(
        color: Colors.white10,
        border: Border.all(color: const Color.fromARGB(255, 153, 91, 164)),
        borderRadius: const BorderRadius.all(Radius.circular(15))),
  );
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
