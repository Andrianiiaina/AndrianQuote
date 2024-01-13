import 'showWishlist.dart';
import 'package:flutter/material.dart';
import '../widgets/wishlist_formulaire.dart';
import '../widgets/style.dart';
import '../models/WishlistModel.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:file_picker/file_picker.dart';
//import '../book/view_pdfdart';
import '../models/biblioModel.dart';
import '../widgets/book_formulaire.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({Key? key}) : super(key: key);

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  List<WishlistClass> wishlists = WishlistModel.getAllData();
  late List<WishlistClass> wishlistsFiltered;
  late List biblios;
  @override
  void initState() {
    super.initState();
    wishlistsFiltered = wishlists;
    biblios = BiblioModel.getBiblios().toList();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController maxC = TextEditingController();

    return Scaffold(
      drawer: drawer,
      appBar: AppBar(title: const Text('Wishlists')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Livre du moment",
              style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  fontFamily: "San Francisco")),
          Container(
            padding: const EdgeInsets.all(5),
            height: 190,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              shrinkWrap: true,
              itemBuilder: ((context, index) {
                if (biblios.length > index) {
                  return Container(
                      color: Theme.of(context).backgroundColor.withOpacity(0.1),
                      margin: const EdgeInsets.all(2),
                      width: MediaQuery.of(context).size.width / 3.2,
                      child: GestureDetector(
                          child: Column(
                            children: [
                              const Image(
                                image: AssetImage("assets/p (8).jpg"),
                                height: 140,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(height: 2),
                              LinearProgressIndicator(
                                value: biblios[index].nbrPage != 0
                                    ? (biblios[index].currentPage) /
                                        biblios[index].nbrPage
                                    : 0,
                                backgroundColor: Colors.white24,
                              ),
                              Text(
                                biblios[index].filepath.split('/').last,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          onTap: () {
                            /**Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => PdfViewPage(
                                        biblio: biblios[index].id,
                                      ))),
                            );
                             */
                          },
                          onLongPress: () {
                            showDialog(
                                context: context,
                                builder: (context) => SimpleDialog(
                                      children: [
                                        SimpleDialogOption(
                                            onPressed: () {
                                              showForm(context,
                                                  const BookFormulaire());
                                            },
                                            child:
                                                const Text("Ajouter à books")),
                                        SimpleDialogOption(
                                            onPressed: () {
                                              BiblioModel.deleteBiblio(
                                                  biblios[index].id);
                                              Navigator.pop(context);
                                              setState(() {
                                                biblios =
                                                    BiblioModel.getBiblios();
                                              });
                                            },
                                            child: const Text("Supprimer")),
                                      ],
                                    ));
                          } //Text],),)

                          ));
                } else {
                  return Container(
                    margin: const EdgeInsets.all(2),
                    color: Theme.of(context).backgroundColor.withOpacity(0.1),
                    width: MediaQuery.of(context).size.width / 3.2,
                    //height: MediaQuery,
                    child: IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        getPdfFileNames();
                      },
                    ),
                  );
                }
              }),
            ),
          ),
          /**
           * Flexible(
              child: SizedBox(
            width: 200,
            child: TextField(
              onChanged: (val) {
                setState(() {
                  (val.isNotEmpty)
                      ? wishlistsFiltered = wishlists
                          .where((element) =>
                              int.parse(element.nbrPage) <= int.parse(val))
                          .toList()
                      : wishlistsFiltered = wishlists;
                });
              },
              decoration:
                  const InputDecoration(hintText: "Nombres de page max"),
            ),))
           */
          Text("Listes à souhait (${wishlists.length.toString()})",
              style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  fontFamily: "San Francisco")),
          const SizedBox(height: 10),
          Expanded(
            flex: 5,
            child: ReorderableListView(
              scrollDirection: Axis.vertical,
              onReorder: (oldIndex, newIndex) {
                if (oldIndex < newIndex) newIndex--;

                final item = wishlistsFiltered.removeAt(oldIndex);
                wishlistsFiltered.insert(newIndex, item);

                WishlistModel.updateWishlistList(wishlistsFiltered);
                setState(() {
                  wishlistsFiltered = wishlistsFiltered;
                });
              },
              children: [
                for (int i = 0; i < wishlistsFiltered.length; i++)
                  Container(
                      color: Theme.of(context).backgroundColor.withOpacity(0.1),
                      margin: const EdgeInsets.all(2),
                      key: ValueKey(wishlistsFiltered[i].id),
                      child: ListTile(
                        title: Text(wishlistsFiltered[i].title,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        subtitle: Text(
                          wishlistsFiltered[i].author,
                        ),
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: ((context) => ShowWishlist(
                                    idWishlist: wishlistsFiltered[i].id,
                                  )),
                            ),
                          );
                        },
                      )),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.small(
        heroTag: 'h1',
        backgroundColor: Theme.of(context).primaryColorLight,
        onPressed: () {
          showForm(
            context,
            const WishlistFormulaire(),
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.deepPurple,
        ),
      ),
    );
  }

  getPdfFileNames() async {
    FilePickerResult? result;
    //verification permission
    PermissionStatus status = await Permission.storage.status;
    if (!status.isGranted) {
      status = await Permission.storage.request();

      if (!status.isGranted) {
        return;
      }
    }

    try {
      result = await FilePicker.platform
          .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
      if (result!.count > 0 && result.files.first.path!.endsWith('.pdf')) {
        //0% fona revo mbola tsy nokitihina/ At kitika:update biblio and book
        final x = BiblioClass(
            filepath: result.files.first.path.toString(),
            imagepath: "imagepath",
            currentPage: 1,
            nbrPage: 0);
        setState(() {
          BiblioModel.addBiblio(x);
          biblios = BiblioModel.getBiblios();
        });

        //
      }
    } catch (e) {}
  }
}

/**
 * 
 *  getSuggestions() async {
    https: //www.bibliosurf.com/?page=api_pnb&id={identifiant}&ean={ean13}&gabarit=api_recommandation_pnb
    var url = Uri.https('www.bibliosurf.com', '/', {
      'page': 'api_animation',
      'id': '8',
      'clil': '3442',
    });
    var response = await http.get(url);
    var x = json.decode(response.body);
    if (x is Map) {
      datas = x.values.first[0]['best sellers'];
    }
    for (var i in datas) {
      var url1 = Uri.https('www.bibliosurf.com', '/', {
        'page': 'api_pnb',
        'id': '8',
        'ean': '9782021529111',
        'gabarit': 'api_recommandation_pnb',
      });
      var responses = await http.get(url1);
      print(responses.body);
    }
    //print(x);
  }
 */