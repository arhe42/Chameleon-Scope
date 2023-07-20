import "dart:io";

import "package:r2d/StreamWidget.dart";

/****
 * At the moment, the server widget is not needed.
 * The server widget will allow the compute module (smartphone) to host the server
 * to be accessed by the esp32.
 * This will remove some load from the esp and ensure, that the smartphone will have a
 * permanent connection to the internet.
 * In the following code, the ip to access the server is hardcoded, so there are a few to to-dos if this approach
 * should be followed again.
 * 
 * 1. The ip of the compute module will be the ip for the server. To prevent hardcoding or a additional input field in the app, the device ip could be read by the app.
 * 2. The server needs to send the ip to the esp32. In order to do this, the esp32 will need to open a network first. The compute module will need to connecto to this network and send the credentials. After that, the esp needs to shut down the network and the hotspot of the compute module needs to be started to allow the esp to connect with the sent credentials.
 ****/

class Server {

  void startServer() {
    StreamWidgetState streamWidget = StreamWidgetState();

    String url = "127.0.0.1";
    const port = 8080;

    HttpServer.bind(url, port).then((server) {
      print('Listening on ${server.address}:${server.port}.');

      server.listen((HttpRequest req) {
        if (WebSocketTransformer.isUpgradeRequest(req)) {
          WebSocketTransformer.upgrade(req).then((WebSocket webSocket) {
            webSocket.listen((dynamic message) {
              streamWidget.setImage(message);
            });
          });
        } else {
          // handle http requests
        }
      }); //server.listen
    }); //HttpServer.bind
  }
}
