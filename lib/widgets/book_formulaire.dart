import 'package:flutter/material.dart';
import 'package:select_form_field/select_form_field.dart';
import '../models/BookModel.dart';
import 'style.dart';
import '../main.dart';

class BookFormulaire extends StatefulWidget {
  final bool isFinished;
  const BookFormulaire({Key? key, required this.isFinished}) : super(key: key);
  @override
  State<BookFormulaire> createState() => _BookFormulaireState();
}

class _BookFormulaireState extends State<BookFormulaire> {
  int stara = 0;
  TextEditingController authorController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController resumeController = TextEditingController();
  late bool version;
  @override
  void initState() {
    super.initState();
    version = true;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        textWidget("Ajouter un livre"),
        textFieldWidget(authorController, "Nom de l'auteur", false),
        textFieldWidget(titleController, "Titre du livre", false),
        textareaWidget(resumeController, "Resumé", false),
        SelectFormField(
            labelText: 'Category',
            type: SelectFormFieldType.dropdown,
            controller: categoryController,
            items: BookModel.bookCategory),
        const SizedBox(height: 20),
        if (widget.isFinished)
          SizedBox(height: 30, child: star(stara))
        else
          SizedBox(
              height: 120, child: widget.isFinished ? star(stara) : priority()),
        const SizedBox(height: 20),
        ElevatedButton(
            onPressed: () {
              _addBook(BookClass(
                  title: titleController.text,
                  author: authorController.text,
                  version: 'vf',
                  note: stara.toString(),
                  resume: resumeController.text,
                  isFinished: widget.isFinished,
                  category: categoryController.text));

              //message bien enregistrer
            },
            child: const Text('Enregistrer le livre'))
      ],
    );
  }

  _addBook(BookClass values) async {
    await BookModel.addBook(values);
    final idPage = (widget.isFinished) ? 0 : 2;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: ((context) => MyApp(index: idPage)),
      ),
    );
  }

  Widget star(int nbr) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: ((context, index) {
          return IconButton(
            splashRadius: 1,
            constraints: const BoxConstraints(maxWidth: 30, minWidth: 20),
            onPressed: () {
              setState(() {
                stara = index + 1;
              });
            },
            iconSize: 30,
            icon: Icon((index < nbr) ? Icons.star : Icons.star_outline),
            color: (index < nbr)
                ? const Color.fromARGB(255, 236, 149, 252)
                : Colors.grey,
          );
        }));
  }

  Widget priority() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Priorité:'),
          ElevatedButton(
            onPressed: () {
              setState(() {
                stara = 5;
              });
            },
            child: const Text(
              'Dès que possible',
            ),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red)),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                stara = 4;
              });
            },
            child: const Text("Me plait bien"),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.orange)),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                stara = 3;
              });
            },
            child: const Text('Un jour peut etre'),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.yellow)),
          )
        ]);
  }
}
