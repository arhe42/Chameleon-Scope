import 'package:flutter/material.dart';
import 'package:r2d/CameraInputWidget.dart';
import 'DrawerWidget.dart';
import 'ImageLabeling.dart' as Labler;

import 'package:google_ml_kit/google_ml_kit.dart';
import 'dart:typed_data';
import 'package:image/image.dart' as img;

/****
 * This widget will display the input stream, provided by the CameraInputWidget as well as the 
 * labeles for the image, provided by the image labeler 
 ****/

// the labels returned by the labeling
String _classificationText = "";

// the labels that will be displayed in the ui, provided by the classificationText variable
String _labelText = "";

// check if the labels should be updated
bool _realTimeLabelingToggle = false;

class ObjectClassificationWidget extends StatelessWidget {
  const ObjectClassificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Object Classification")),
      drawer: const DrawerWidget(),
      body: Center(
        child: Column(
          children: const [CameraInputWidget(), ImageLabeling()],
        ),
      ),
    );
  }
}

class ImageLabeling extends StatefulWidget {
  const ImageLabeling({Key? key}) : super(key: key);

  // interface to receive the labels 
  void setLastImage(Uint8List inputImage) {
    _classificationText = Labler.ImageLabeling().labelImage(inputImage);
  }

  @override
  State<ImageLabeling> createState() => _ImageLabelingState();
}

class _ImageLabelingState extends State<ImageLabeling> {
  @override
  void initState() {
    // start the labeling when the state is initialized (route is loaded)
    const CameraInputWidget().toggleLabeling();
    super.initState();
  }

  @override
  void dispose() {
    // disable the labeling as well as updating the labels in the ui when the ui is not active
    const CameraInputWidget().toggleLabeling();
    _realTimeLabelingToggle = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        const SizedBox(height: 15),
        SizedBox(
            height: 300,
            child: SingleChildScrollView(
                child: Text(_labelText,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 25, 
                        fontWeight: FontWeight.bold),),),),
        ElevatedButton(
            onPressed: () {
              setState(
                () {
                  onButtonPressed();
                },
              );
            },
            child: Text(
                '${!_realTimeLabelingToggle ? 'Start' : 'Stop'} Image Labeling')),
      ]),
    );
  }

  void onButtonPressed() async {
    _realTimeLabelingToggle = !_realTimeLabelingToggle;
    while (_realTimeLabelingToggle) {
      setState(() {
        // update the labels in the ui 
        _labelText = _classificationText;
      });
      // to prevent the app from crashing we need to wait 1 ms to update the ui
      await Future.delayed(const Duration(milliseconds: 1));
    }
  }
}
