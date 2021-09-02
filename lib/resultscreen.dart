import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

class ResultScreen extends StatefulWidget {
  final PickedFile? img;
  ResultScreen({required this.img});

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  bool recognized = false;
  String recogtext = 'Nothing Till Now';
  late TextEditingController controller;
  final ScrollController cntrler = ScrollController();
  Future<void> mlModel() async {
    final textDetector = GoogleMlKit.vision.textDetector();
    RecognisedText detectedText = await textDetector
        .processImage(InputImage.fromFile(File(widget.img!.path)));
    setState(() {
      recogtext = detectedText.text;
      recognized = true;
      controller = TextEditingController(text: recogtext);
    });
  }

  @override
  void initState() {
    mlModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recognized Text'),
      ),
      body: recognized == false
          ? CircularProgressIndicator()
          : SingleChildScrollView(
              controller: cntrler,
              child: Column(
                children: [
                  Card(
                    elevation: 20,
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        controller: controller,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            border: InputBorder.none,
                            filled: true),
                        maxLines: 20,
                      ),
                    ),
                  ),
                  ElevatedButton(onPressed: () {}, child: Text('Refresh')),
                ],
              ),
            ),
    );
  }
}
