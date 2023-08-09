import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:file_picker/file_picker.dart';
import 'view_pdf.dart';

class ManagePdf extends StatefulWidget {
  const ManagePdf({Key? key}) : super(key: key);

  @override
  State<ManagePdf> createState() => _ManagePdfState();
}

class _ManagePdfState extends State<ManagePdf> {
  getPdfFileNames() async {
    FilePickerResult? result;
    //verification permission
    PermissionStatus status = await Permission.storage.status;
    if (!status.isGranted) {
      status = await Permission.storage.request();

      if (!status.isGranted) {
        print("Access réfusé");
        return "";
      }
    }
    print('acces ok');

    try {
      result = await FilePicker.platform
          .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
      if (result!.count > 0) {
        openPdfFile(result.files.first.path);
      }
    } catch (e) {
      print("un erreur s'est produit, sorry");
    }
  }

  openPdfFile(filename) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: ((context) => PdfViewPage(
                  file_path: filename,
                ))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('df'),
      ),
      body: IconButton(
        icon: Icon(Icons.add),
        onPressed: () {
          getPdfFileNames();
        },
      ),
    );
  }
}
