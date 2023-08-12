import 'package:flutter/material.dart';
import 'package:select_form_field/select_form_field.dart';
import '../models/WishlistModel.dart';
import 'style.dart';
import '../main.dart';
import '../models/models.dart';

class WishlistFormulaire extends StatefulWidget {
  final int idWishlist;
  const WishlistFormulaire({Key? key, this.idWishlist = -1}) : super(key: key);
  @override
  State<WishlistFormulaire> createState() => _WishlistFormulaireState();
}

class _WishlistFormulaireState extends State<WishlistFormulaire> {
  int stara = 0;
  TextEditingController authorController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController versionController = TextEditingController();
  TextEditingController resumeController = TextEditingController();
  TextEditingController nbrpageController = TextEditingController(text: "0");

  late WishlistClass wishlist;
  final _formKeyWish = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    try {
      wishlist = WishlistModel.getWishlist(widget.idWishlist);
      authorController.text = wishlist.author;
      titleController.text = wishlist.title;
      resumeController.text = wishlist.resume;
      categoryController.text = wishlist.category;
      versionController.text = wishlist.version;
      nbrpageController.text = wishlist.nbrPage.toString();
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
            image: DecorationImage(
                opacity: 0.5,
                image: AssetImage('assets/p (18).jpg'),
                fit: BoxFit.cover)),
        child: Form(
          key: _formKeyWish,
          child: Column(
            children: [
              textWidget("Ajouter un livre à souhait"),
              const SizedBox(height: 20),
              textFieldWidget(authorController, "Nom de l'auteur", false),
              textFieldWidget(titleController, "Titre du livre", false),
              SelectFormField(
                decoration: InputDecoration(
                    hintText: categoryController.text, labelText: 'Category'),
                type: SelectFormFieldType.dropdown,
                controller: categoryController,
                items: Models.bookCategory,
              ),
              SelectFormField(
                decoration: InputDecoration(
                    hintText: versionController.text, labelText: 'Langage'),
                type: SelectFormFieldType.dropdown,
                controller: versionController,
                items: Models.bookversion,
              ),
              textFieldWidgetNumber(nbrpageController, "Nombre de page", false),
              textareaWidget(resumeController, "Resumé", false),
              ElevatedButton(
                onPressed: () async {
                  if (_formKeyWish.currentState!.validate()) {
                    WishlistClass boky = WishlistClass(
                      title: titleController.text,
                      author: authorController.text,
                      version: versionController.text,
                      resume: resumeController.text,
                      category: categoryController.text,
                      nbrPage: nbrpageController.text,
                    );
                    if (widget.idWishlist == -1) {
                      _addWishlist(boky);
                    } else {
                      _updateWishlist(widget.idWishlist, boky);
                    }
                  }

                  //message bien enregistrer
                },
                child: const Text(
                  'Enregistrer',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 230, 116, 250)),
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.all(15))),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  _addWishlist(WishlistClass values) async {
    await WishlistModel.addWishlist(values);
    const idPage = 2;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: ((context) => const MyApp(index: idPage)),
      ),
    );
  }

  _updateWishlist(idWishlist, WishlistClass values) async {
    await WishlistModel.updateWishlist(idWishlist, values);
    const idPage = 2;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: ((context) => const MyApp(index: idPage)),
      ),
    );
  }
}
