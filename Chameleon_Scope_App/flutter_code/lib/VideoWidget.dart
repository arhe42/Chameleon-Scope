import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'DrawerWidget.dart';
import 'websocket_service.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:path_provider/path_provider.dart';

class VideoWidget extends StatelessWidget {
  const VideoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: DrawerWidget(),
      body: VideoPage(),
    );
  }
}

class VideoPage extends StatefulWidget {
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  final picker = ImagePicker();
  final webSocketService = WebSocketService();
  File? _imageFile;
  final FlutterFFmpeg _flutterFFmpeg = FlutterFFmpeg();
  String _videoPath = '';
  String _outputPath = '';
  TextEditingController _ipAddressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    webSocketService.connect();
    webSocketService.onMessageReceived = _onMessageReceived;
    print('WebSocket connection initiated');
    _initPaths();
  }

  Future<void> _initPaths() async {
    final appDir = await getApplicationDocumentsDirectory();
    _videoPath = '${appDir.path}/input.mp4';
    _outputPath = '${appDir.path}/output';
  }

  Future<void> _convertVideoToImages() async {
    final directory = Directory(_outputPath);
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    } else {
      directory.deleteSync(recursive: true);
      await directory.create(recursive: true);
    }

    final arguments = '-i $_videoPath $_outputPath/output-%04d.jpg';
    final int result = await _flutterFFmpeg.execute(arguments);
    print('FFmpeg process exited with result code $result');

    if (result == 0) {
      _sendImages();
    } else {
      print('Error occurred during video to images conversion.');
    }
  }

  Future<void> _sendImages() async {
    final directory = Directory(_outputPath);
    final files = directory.listSync();
    int i = 0;

    for (final file in files) {
      if (i % 2 == 0) {
        if (file is File) {
          final bytes = await file.readAsBytes();
          final image = img.decodeImage(bytes);

          // Rotate the image by 90 degrees
          final rotatedImage = img.copyRotate(image!, angle: 90);

          // Convert image to RGB bitmap
          final rgbImage =
              img.copyResize(rotatedImage, width: 135, height: 240);
          // final rgbBytes = rgbImage.getBytes(format: img.Format.rgb); should work but isnt. needs to be fixed in the future
          final rgbBytes = rgbImage.getBytes(); // can be removed as soon as the above error got fixed

          // Convert Uint16List to byte array (Uint8List)
          final uint16List = Uint16List(rgbBytes.length ~/ 3);
          for (var i = 0; i < rgbBytes.length; i += 3) {
            final r = rgbBytes[i];
            final g = rgbBytes[i + 1];
            final b = rgbBytes[i + 2];
            final hexValue = ((r >> 3) << 11) | ((g >> 2) << 5) | (b >> 3);
            uint16List[i ~/ 3] = hexValue;
          }

          final byteData = uint16List.buffer.asUint8List();

          // Split byte array into smaller chunks
          const chunkSize = 1024; // Adjust this value as per your requirements
          final totalChunks = (byteData.length / chunkSize).ceil();

          for (var chunkIndex = 0; chunkIndex < totalChunks; chunkIndex++) {
            final start = chunkIndex * chunkSize;
            final end = (chunkIndex + 1) * chunkSize;
            final chunk = byteData.sublist(
                start, end > byteData.length ? byteData.length : end);

            // Send the chunk via WebSocket
            webSocketService.sendMessage(chunk);
          }
        }
      } else {
        print('skipped Image');
      }
      i++;
    }
  }

  void _onMessageReceived(dynamic message) {
    print('Received message: $message');
    // Check if the received message is "ImageReceived"
    if (message == 'ImageReceived') {
      // Handle the image received event
      // Add your logic here to request a new image from the ESP32
    }
  }

  void _selectVideo() async {
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _videoPath = pickedFile.path;
      });
    }
  }

  void _connectToWebSocket() {
    final ipAddress = _ipAddressController.text;
    webSocketService.setIpAddress(ipAddress);
    webSocketService.connect();
  }

  @override
  void dispose() {
    webSocketService.disconnect();
    print('WebSocket connection closed');
    _ipAddressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 16,
            runSpacing: 16,
            children: <Widget>[
              ElevatedButton(
                onPressed: _selectVideo,
                child: Text('Select Video'),
              ),
              Text('Selected Video: $_videoPath'),
              ElevatedButton(
                onPressed: _convertVideoToImages,
                child: Text('Convert Video to Images'),
              ),
              Container(
                width: 1000, // Adjust the width as needed
                child: TextFormField(
                  controller: _ipAddressController,
                  keyboardType: TextInputType.numberWithOptions(
                    decimal: true,
                    signed: false,
                  ),
                  decoration: InputDecoration(
                    labelText: 'IP Adresse ESP',
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: _connectToWebSocket,
                child: const Text('Mit Brille verbinden'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
