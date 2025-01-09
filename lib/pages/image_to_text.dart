import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/custom_colors.dart';

class ImageToText extends StatefulWidget {
  const ImageToText({super.key});

  @override
  State<ImageToText> createState() => _ImageToTextState();
}

class _ImageToTextState extends State<ImageToText> {
  File? selectedImage;
  String? recognizedTextForShow;

  Future<void> pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      selectedImage = File(returnedImage!.path);
    });
  }

  Future<void> pickImageFromCamera() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      selectedImage = File(returnedImage!.path);
    });
  }

  Future<String?> extractFromImage(File file) async {
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final InputImage inputImage = InputImage.fromFile(file);
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);
    String extractedText = recognizedText.text;
    recognizedTextForShow = extractedText;
    textRecognizer.close();
    return extractedText;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: textColor),
        backgroundColor: primaryBGColor,
        title: Text(
          'Text Recognition',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              imageView(),
              SizedBox(
                height: 20,
              ),
              extractText(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryBGColor,
        onPressed: () {
          pickImageFromGallery();
        },
        child: Icon(
          Icons.camera,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget imageView() {
    if (selectedImage == null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Pick an image(bottom button) for text recognition\nor\n',
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: MediaQuery.sizeOf(context).width * .8,
              child: Card(
                elevation: 8,
                child: Container(
                  padding: EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                      color: primaryBGColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: ListTile(
                    onTap: () {
                      pickImageFromCamera();
                    },
                    leading: Icon(
                      Icons.camera_enhance_rounded,
                      color: textColor,
                    ),
                    title: Text(
                      'Capture an image',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      );
    }
    return Center(
      child: Image.file(
        selectedImage!,
        width: 200,
      ),
    );
  }

  Widget extractText() {
    if (selectedImage == null) {
      return Center(
        child: Text('No Result!'),
      );
    }
    return FutureBuilder(
      future: extractFromImage(selectedImage!),
      builder: (context, snapshot) {
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Container(
                  width: MediaQuery.sizeOf(context).width,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: Colors.lightBlue[50],
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    snapshot.data ?? '',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.justify,
                  )),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () async {
                    final String textToCopy = recognizedTextForShow!;
                    if (textToCopy.isNotEmpty) {
                      try {
                        await Clipboard.setData(
                            ClipboardData(text: textToCopy));
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content:
                                Text('Copied to Clipboard Successfully!')));
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Failed to copy to clipboard!')));
                      } finally {
                        setState(() {
                          selectedImage = null;
                        });
                      }
                    }
                  },
                  child: Text(
                    'Copy to clipboard',
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
        );
      },
    );
  }
}
