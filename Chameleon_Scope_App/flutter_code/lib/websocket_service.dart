import 'dart:io';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService {
  WebSocketChannel? _channel;
  String? _ipAddress;
  Function(dynamic)? onMessageReceived;

  void setIpAddress(String ipAddress) {
    _ipAddress = ipAddress;
  }

  void connect() {
    if (_ipAddress == null || _ipAddress!.isEmpty) {
      print('IP Address is not set. Cannot connect to WebSocket.');
      return;
    }

    final String url = 'ws://$_ipAddress:8080';

    try {
      print(url);
      _channel = WebSocketChannel.connect(Uri.parse(url));
      _channel?.stream.listen(_onMessageReceived);
      print('WebSocket connected');
    } catch (e) {
      print('Failed to connect to WebSocket: $e');
    }
  }


  void disconnect() {
    try {
      _channel?.sink.close();
      print('WebSocket disconnected');
    } catch (e) {
      print('Failed to disconnect from WebSocket: $e');
    }
  }


  void sendMessage(dynamic message) {
    try {
      _channel?.sink.add(message);
      print('Message sent: $message');
    } catch (e) {
      print('Failed to send message: $e');
    }
  }


  void _onMessageReceived(dynamic message) {
    print('Message received: $message');
    if (onMessageReceived != null) {
      onMessageReceived!(message);
    }
  }

}