import 'package:andrianiaiina_quote/models/biblioModel.dart';
import 'package:andrianiaiina_quote/wishlist/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class PdfViewPage extends StatefulWidget {
  final int biblio;
  const PdfViewPage({Key? key, required this.biblio}) : super(key: key);

  @override
  State<PdfViewPage> createState() => _PdfViewPageState();
}

class _PdfViewPageState extends State<PdfViewPage> {
  //late PdfControllerPinch pdfPinchController;
  late BiblioClass biblio;
  late PdfController pdfController;
  late NavigatorState _navigator;

  int currentPage = 1;
  bool isVercticalScrolling = false;
  @override
  void initState() {
    super.initState();
    biblio = BiblioModel.getBiblio(widget.biblio);
    currentPage = biblio.currentPage;
    pdfController = PdfController(
      document: PdfDocument.openFile(biblio.filepath),
      initialPage: currentPage,
    );
  }

  @override
  void didChangeDependencies() {
    _navigator = Navigator.of(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    pdfController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey ke = GlobalKey(debugLabel: "manage");
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () => _navigator.push(
                    MaterialPageRoute(
                        builder: ((context) => Wishlist(
                              key: ke,
                            ))),
                  ),
              icon: const Icon(Icons.arrow_back)),
          title: Text(biblio.filepath.split('/').last),
          actions: [
            PdfPageNumber(
              controller: pdfController,
              // When `loadingState != PdfLoadingState.success`  `pagesCount` equals null_
              builder: (_, state, loadingState, pagesCount) => Container(
                alignment: Alignment.center,
                child: Text(
                  '$currentPage/${pagesCount ?? 0}',
                ),
              ),
            ),
          ]),
      //PdfViewPinch rehefa android
      body: PdfView(
        controller: pdfController,
        scrollDirection: isVercticalScrolling ? Axis.vertical : Axis.horizontal,
        onPageChanged: (page) {
          setState(() {
            currentPage = page;
          });
          final x = BiblioClass(
              filepath: biblio.filepath,
              imagepath: "imagepath",
              currentPage: currentPage,
              nbrPage: pdfController.pagesCount ?? 0);
          BiblioModel.putBiblio(widget.biblio, x);
        },
      ),
    );
  }
}
