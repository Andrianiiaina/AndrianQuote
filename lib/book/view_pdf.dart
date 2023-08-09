import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class PdfViewPage extends StatefulWidget {
  final String file_path;
  const PdfViewPage({Key? key, required this.file_path}) : super(key: key);

  @override
  State<PdfViewPage> createState() => _PdfViewPageState();
}

class _PdfViewPageState extends State<PdfViewPage> {
  //late PdfControllerPinch pdfPinchController;
  late PdfController pdfController;
  int initialPage = 1;
  int currentPage = 1;
  bool isVercticalScrolling = false;
  @override
  void initState() {
    super.initState();
    pdfController = PdfController(
      document: PdfDocument.openFile(widget.file_path),
      initialPage: initialPage,
    );
    /**
    *  pdfPinchController = PdfControllerPinch(
        document: PdfDocument.openFile(widget.file_path),
        initialPage: initialPage);
    */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.file_path.split('/').last), actions: [
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
        },
      ),
    );
  }
}
