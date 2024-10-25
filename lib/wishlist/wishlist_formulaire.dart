import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/wishlist_model.dart';
import '../widgets/widget.dart';
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
    if (widget.idWishlist != -1) {
      wishlist = WishlistModel.getWishlist(widget.idWishlist);
      authorController.text = wishlist.author;
      titleController.text = wishlist.title;
      resumeController.text = wishlist.resume;
      categoryController.text = wishlist.category;
      versionController.text = wishlist.version;
      nbrpageController.text = wishlist.nbrPage.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
          image: DecorationImage(
              opacity: 0.6,
              image: AssetImage('assets/p (11).jpg'),
              fit: BoxFit.cover),
        ),
        child: Form(
          key: _formKeyWish,
          child: Column(
            children: [
              const SizedBox(height: 30),
              textWidget("Ajouter à wishlist"),
              const SizedBox(height: 20),
              textFieldWidget(authorController, "Nom de l'auteur", false),
              textFieldWidget(titleController, "Titre du livre", false),
              selectFormWidget(
                  categoryController, "Catégorie", Models.bookCategory),
              selectFormWidget(
                  versionController, 'Langage', Models.bookversion),
              textFieldWidgetNumber(nbrpageController, "Nombre de page", false),
              textareaWidgetForm(resumeController, "Resumé", false),
              Container(
                margin: const EdgeInsets.all(15),
                height: 40,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKeyWish.currentState!.validate()) {
                      WishlistClass book = WishlistClass(
                        title: titleController.text,
                        author: authorController.text,
                        version: versionController.text,
                        resume: resumeController.text,
                        category: categoryController.text,
                        nbrPage: nbrpageController.text,
                      );
                      if (widget.idWishlist == -1) {
                        await WishlistModel.addWishlist(book);
                      } else {
                        await WishlistModel.updateWishlist(
                            widget.idWishlist, book);
                      }
                      Navigator.pop(context);
                      context.go('/wishlists');
                      showMessage(
                          context, "Livre bien enregistré dans wishlist.");
                    }
                  },
                  child: const Text(
                    'Enregistrer',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
