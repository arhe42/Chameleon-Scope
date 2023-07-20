import "package:flutter/material.dart";
import "dart:typed_data";
import "dart:async";

/****
 * At the moment, this widget is not in use. It is used in combination with the server on compute unit approach to display
 * the input stream.
 ****/

class StreamWidget extends StatefulWidget {
  const StreamWidget({super.key});

  @override
  State<StreamWidget> createState() => StreamWidgetState();
}

List<Uint8List> images = [];
late Uint8List imageBytes;

class StreamWidgetState extends State<StreamWidget> {
  //Uint8List imageBytes = Uint8List.fromList([]);

  /*void setImage(Uint8List message) {
    if (mounted) {
      setState(() {
        imageBytes = message;
      });
    } else {
      print("not mounted");
    }
  }*/

  void setImage(Uint8List message) {
    images.add(message);
    print(images.length);
  }

  void updateImage() async {
    while(true) {
      setState(() {
        imageBytes = images[images.length - 1];
      });
      await Future.delayed(const Duration(milliseconds: 1));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
          images.isEmpty
          ? const CircularProgressIndicator()
          : FadeInImage(placeholder: Image.memory(images[images.length - 1]).image, image: Image.memory(imageBytes).image),
          ElevatedButton(
            onPressed: () => updateImage(), 
            child: const Text("Start stream")
          ),
      ],
    );
  }
}
