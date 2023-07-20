import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:web_socket_channel/io.dart';
import 'ObjectClassificationWidget.dart';

/******
 * In this widget we will receive the input from the ESP32-Cam using a websocket-channel and
 * display it using a StreamBuilder-widget.
 * This module will initalize the labeling process of the ObjectClassificationWidget, everytime a new Image
 * is received by the websocket-channel
 ******/

// this varibale will check if a widget that requires image labeling is open in the app right now
bool _sendImageToLabeling = false;

class CameraInputWidget extends StatefulWidget {
  const CameraInputWidget({super.key});

  // turn on the labeling 
  void toggleLabeling(){
    _sendImageToLabeling = !_sendImageToLabeling;
  }

  @override
  State<CameraInputWidget> createState() => _CameraInputWidgetState();
}

late Uint8List lastImageShown;

class _CameraInputWidgetState extends State<CameraInputWidget> {
  late StreamController<Uint8List> _controller;
  late IOWebSocketChannel _channel;

  @override
  void initState() {
    super.initState();

    _controller = StreamController<Uint8List>();
    _channel = IOWebSocketChannel.connect('ws://192.168.4.1:8888');

    _channel.stream.listen((dynamic data) {
      if (data is Uint8List) {
        _controller.add(data);
        if(_sendImageToLabeling){
          // send the image that needs to be labeled
          const ImageLabeling().setLastImage(data);
        }
        return;
      }
      return;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Uint8List>(
        stream: _controller.stream,
        builder: (BuildContext context, AsyncSnapshot<Uint8List> snapshot) {
          List<Widget> children;

          // display a message to the user if there is no stream available
          if (snapshot.hasData == false) {
            children = const [
              Icon(
                Icons.error_outline,
                color: Colors.red,
              ),
              Text('There is no data to be displayed'),
            ];
          } else if (snapshot.hasError) {
            children = const [
              Icon(
                Icons.error_outline,
                color: Colors.red,
              ),
              Text('An error occured while loading the data'),
            ];
          } else {
            Uint8List imgData = snapshot.data!;
            lastImageShown = snapshot.data!;

            children = [
              // use the FadeInImage-widget to prevent flickering, everytime a new image gets rendered in the stream builder
              FadeInImage(
                placeholder: Image.memory(lastImageShown).image,
                 image: Image.memory(imgData).image,
              ),
            ];
          }

          return Column(
            children: children,
          );
        });
  }
}