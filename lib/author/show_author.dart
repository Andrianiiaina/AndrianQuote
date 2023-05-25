import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/models.dart';
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
        title: TextField(
          controller: _author,
          readOnly: readOnly,
        ),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  readOnly = false;
                });
              },
              icon: const Icon(Icons.edit)),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              _deleteAuthor(id);
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          const Image(
            image: AssetImage('assets/p2.png'),
            width: 180,
          ),
          const SizedBox(height: 20),
          Text(" A écrit ${author!.books.length.toString()} livres:"),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: listBooks.length,
              itemBuilder: ((context, index) {
                return CheckboxListTile(
                    value: true,
                    onChanged: (val) {},
                    title: Text(listBooks[index]));
              }),
            ),
          ),
          const SizedBox(height: 10),
          if (readOnly == false)
            Row(
              children: [
                Expanded(
                  child: TextField(
                    readOnly: readOnly,
                    controller: _books,
                    decoration:
                        const InputDecoration(hintText: "un autre livre"),
                  ),
                ),
                Expanded(
                  child: IconButton(
                      onPressed: () {
                        setState(() {
                          listBooks.add(_books.text);
                          listBooks.remove(" ");
                        });
                        _books.clear();
                      },
                      icon: const Icon(Icons.add)),
                )
              ],
            ),
          const Text("Biographie"),
          TextField(
            controller: _biographie,
            readOnly: readOnly,
            keyboardType: TextInputType.multiline,
            maxLines: 9,
            minLines: 2,
          ),
          const SizedBox(height: 10),
          if (readOnly == false)
            ElevatedButton(
              child: const Text('Appliquer les modifications'),
              onPressed: () {
                if (_books.text != ' ') listBooks.add(_books.text);
                _updateAuthor(AuthorClass(
                    author: _author.text,
                    biography: _biographie.text,
                    books: listBooks,
                    profile: author!.profile));
              },
            )
        ],
      ),
    );
  }
}
