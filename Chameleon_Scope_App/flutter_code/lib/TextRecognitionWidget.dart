import 'dart:io';
import 'DrawerWidget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TextRecognitionWidget extends StatefulWidget {
  const TextRecognitionWidget({Key? key}) : super(key: key);

  @override
  _TextRecognitionWidgetState createState() => _TextRecognitionWidgetState();
}

class _TextRecognitionWidgetState extends State<TextRecognitionWidget> {
  ImagePicker _imagePicker = ImagePicker();
  File? _capturedImage;

  Future<void> _capturePhoto() async {
    final image = await _imagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _capturedImage = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'OCR',
          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      drawer: DrawerWidget(),
      body: Column(
        children: [
          SizedBox(height: 20.0),
          _capturedImage != null
              ? Column(
                  children: [
                    Image.asset(
                      'assets/images/muster.png',
                      width: 200.0,
                      height: 200.0,
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      '"Code is like humor. When you have to explain it, its bad."',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                )
              : Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    'No picture taken',
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                ),
        ],
      ),
      floatingActionButton: Container(
        width: 100.0,
        height: 100.0,
        margin: EdgeInsets.only(bottom: 30.0), // Anpassung des Abstands
        child: FloatingActionButton(
          onPressed: _capturePhoto,
          child: Icon(
            Icons.camera_alt,
            size: 40.0,
          ),
          backgroundColor: Colors.green,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
