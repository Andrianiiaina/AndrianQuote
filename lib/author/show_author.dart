import 'package:andrianiaiina_quote/widgets/style.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/authorClass.dart';
import '../main.dart';

//todo:redirection after modification
class ShowAuthor extends StatefulWidget {
  final int idAuthor;
  const ShowAuthor({Key? key, required this.idAuthor}) : super(key: key);

  @override
  State<ShowAuthor> createState() => _ShowAuthorState();
}

class _ShowAuthorState extends State<ShowAuthor> {
  final box = Hive.box<AuthorClass>("author");
  late AuthorClass? author;
  late int id;
  bool readOnly = true;
  late List<String> listBooks;
  @override
  void initState() {
    super.initState();
    _initState();
  }

  _initState() {
    id = widget.idAuthor;
    author = box.get(id);
    listBooks = author!.books;
  }

  _updateAuthor(AuthorClass values) async {
    await box.put(widget.idAuthor, values);
    setState(() {
      _initState();
      readOnly = true;
    });
  }

  _deleteAuthor(int id) async {
    await box.delete(id);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: ((context) => const MyApp(index: 0)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _author = TextEditingController(text: author?.author);
    TextEditingController _biographie =
        TextEditingController(text: author?.biography);
    TextEditingController _books = TextEditingController();

    return Scaffold(
        appBar: AppBar(
          title: textFieldWidget(_author, "", readOnly),
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    if (readOnly == true) {
                      readOnly = false;
                    } else {
                      _updateAuthor(AuthorClass(
                          author: _author.text,
                          biography: _biographie.text,
                          books: listBooks,
                          profile: author!.profile));
                    }
                  });
                },
                icon: readOnly == true
                    ? const Icon(Icons.edit)
                    : const Icon(Icons.update)),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                _deleteAuthor(id);
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Image(
                image: AssetImage('assets/p2.png'),
                width: 180,
              ),
              const SizedBox(height: 20),
              const Text("Biographie"),
              textareaWidget(_biographie, "Biographie...", readOnly),
              Text("${author!.author} a écrit les livres suivantes:"),
              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: listBooks.length,
                itemBuilder: ((context, index) {
                  return CheckboxListTile(
                      value: true,
                      onChanged: (val) {},
                      title: Text(listBooks[index]));
                }),
              ),
              if (readOnly == false)
                TextButton(
                    onPressed: () {
                      setState(() {
                        if (_books.text != " " && _books.text != "") {
                          listBooks.add(_books.text);
                        }
                      });
                      _books.clear();
                    },
                    child: Row(
                      children: [
                        Expanded(
                            flex: 3,
                            child: textFieldWidget(
                                _books, "un autre livre", readOnly)),
                        const Icon(Icons.add)
                      ],
                    )),
            ],
          ),
        ));
  }
}
