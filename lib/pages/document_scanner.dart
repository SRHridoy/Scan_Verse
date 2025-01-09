import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mlkit_document_scanner/google_mlkit_document_scanner.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../utils/custom_colors.dart';

class DocumentScannerScreen extends StatefulWidget {
  const DocumentScannerScreen({super.key});

  @override
  State<DocumentScannerScreen> createState() => _DocumentScannerScreenState();
}

class _DocumentScannerScreenState extends State<DocumentScannerScreen> {
  late DocumentScanner documentScanner;
  bool isFinished = false;
  String? resultPath;

  @override
  void initState() {
    super.initState();
    DocumentScannerOptions documentOptions = DocumentScannerOptions(
      documentFormat: DocumentFormat.jpeg, // set output document format
      mode: ScannerMode.filter, // to control what features are enabled
      pageLimit: 1, // setting a limit to the number of pages scanned
      isGalleryImport: true, // importing from the photo gallery
    );
    documentScanner = DocumentScanner(options: documentOptions);
  }

  @override
  void dispose() {
    documentScanner.close();
    super.dispose();
  }

  Future<void> scanDocument() async {
    try {
      final DocumentScanningResult? result =
          await documentScanner.scanDocument();
      if (result != null) {
        setState(() {
          resultPath = result.images.first;
        });
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('No document was scanned!')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed sorry!')));
    } finally {
      isFinished = true;
    }
  }

//Issue:
  Future saveImage() async {
    if (resultPath == null) return;
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      final String fileName =
          'scanned_iamge${DateTime.now().microsecondsSinceEpoch}_SRHDev.jpeg';
      final File imageFile = File(resultPath!);
      final File savedFile =
          await imageFile.copy('${directory.path}/$fileName');

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Successfully image saved at ${savedFile.path}')));
    } catch (e) {
      //print(e);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save the image! \n Error : $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: textColor),
        backgroundColor: primaryBGColor,
        title: Text(
          "Document Scanner",
          style: TextStyle(color: textColor),
        ),
      ),
      body: isFinished
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (resultPath != null)
                    Image.file(
                      File(resultPath!),
                      width: 200,
                      fit: BoxFit.contain,
                    ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      saveImage();
                      setState(() {
                        isFinished = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: primaryBGColor),
                    child: Text(
                      "Save Image",
                      style: TextStyle(color: textColor),
                    ),
                  ),
                ],
              ),
            )
          : Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width * .7,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Scan and save the image easily!',
                        style: TextStyle(color: secondaryTextColor),
                      ),
                      SizedBox(
                        height: 70,
                      ),
                      Card(
                        elevation: 8,
                        child: Container(
                          padding: EdgeInsets.only(left: 20),
                          decoration: BoxDecoration(
                              color: primaryBGColor,
                              borderRadius: BorderRadius.circular(20)),
                          child: ListTile(
                            onTap: () {
                              scanDocument();
                            },
                            leading: Icon(
                              Icons.document_scanner_outlined,
                              color: Colors.white,
                            ),
                            title: Center(
                              child: Text(
                                "Start Scanning",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
