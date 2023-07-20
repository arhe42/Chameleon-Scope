import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'VideoWidget.dart';
import 'FunctionSettingsWidget.dart';
import 'server.dart';
import 'StreamWidget.dart';
import 'DrawerWidget.dart';
import 'ObjectClassificationWidget.dart';
import 'AudioRecorderWidget.dart';
import 'CameraWidget.dart';
import 'TextRecognitionWidget.dart';
import 'FacialRecognitionWidget.dart';

void main() {
  runApp(const MyApp());
}

// List of all routes used by the DrawerWidget
// App-module that needs to have it's own ui should have it's own route to be accessible trough the navigation drawer
final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const MyHomePage(title: 'R2D-App');
        }),
    GoRoute(
        path: '/object-classification',
        builder: (BuildContext context, GoRouterState state) {
          return const ObjectClassificationWidget();
        }),
    GoRoute(
        path: '/audio-recorder',
        builder: (BuildContext context, GoRouterState state) {
          return const AudioRecorderWidget();
        }),
    GoRoute(
        path: '/camera',
        builder: (BuildContext context, GoRouterState state) {
          return const CameraWidget();
        }),
    GoRoute(
        path: '/ocr',
        builder: (BuildContext context, GoRouterState state) {
          return const TextRecognitionWidget();
        }),
    GoRoute(
        path: '/facial-recognition',
        builder: (BuildContext context, GoRouterState state) {
          return  FacialRecognitionWidget();
        }),
    GoRoute(
        path: '/function-settings',
        builder: (BuildContext context, GoRouterState state) {
          return  FunctionSettingsWidget();
        }),
    GoRoute(
        path: '/video',
        builder: (BuildContext context, GoRouterState state) {
          return const VideoWidget();
        }),
  ],
);

// to-do: rename the entry widget from MyApp
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: 'R2D App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: const DrawerWidget(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center
        ),
      ),
    );
  }
}
