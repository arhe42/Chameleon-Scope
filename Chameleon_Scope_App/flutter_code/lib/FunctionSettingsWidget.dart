import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:notifications/notifications.dart';
import 'package:r2d/notifications_service.dart';
import 'DrawerWidget.dart';

class FunctionSettingsWidget extends StatelessWidget {
  const FunctionSettingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Funktionseinstellungen")),
      drawer: DrawerWidget(),
      body: FunctionSettingsPage(),
    );
  }
}

class FunctionSettingsPage extends StatefulWidget {
  @override
  _FunctionSettingsPageState createState() => _FunctionSettingsPageState();
}

class _FunctionSettingsPageState extends State<FunctionSettingsPage> {
  final notificationsService = NotificationsService();
  String? _notificationText;
  bool _switchvalue1 = false;
  bool _switchvalue2 = false;
  bool _switchvalue3 = false;
  bool _switchvalue4 = false;
  bool _switchvalue5 = false;
  bool _switchvalue6 = false;
  bool _switchvalue7 = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    notificationsService.stopListening();
    super.dispose();
  }

  void onNotificationReceived(NotificationEvent event) {
    setState(() {
      _notificationText = event.message.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Row(children: [
            const Icon(Icons.notifications),
            const Spacer(flex: 1),
            const Text('Benachrichtigungen',
                style: TextStyle(
                  fontSize: 16,
                )),
            const Spacer(flex: 12),
            Switch(
              value: _switchvalue1,
              onChanged: (bool value) {
                if (!value) {
                  notificationsService.startListening(onNotificationReceived);
                } else {
                  notificationsService.stopListening();
                }
                setState(() {
                  _switchvalue1 = value;
                });
              },
            ),
          ]),
          Row(children: [
            const Icon(Icons.watch_later_outlined),
            const Spacer(flex: 1),
            const Text('Uhrzeit',
                style: TextStyle(
                  fontSize: 16,
                )),
            const Spacer(flex: 12),
            Switch(
              value: _switchvalue2,
              onChanged: (bool value) {
                if (!value) {

                } else {

                }
                setState(() {
                  _switchvalue2 = value;
                });
              },
            ),
          ]),
          Row(children: [
            const Icon(Icons.date_range_outlined),
            const Spacer(flex: 1),
            const Text('Datum',
                style: TextStyle(
                  fontSize: 16,
                )),
            const Spacer(flex: 12),
            Switch(
              value: _switchvalue3,
              onChanged: (bool value) {
                if (!value) {

                } else {

                }
                setState(() {
                  _switchvalue3 = value;
                });
              },
            ),
          ]),
          Row(children: [
            const Icon(Icons.battery_unknown),
            const Spacer(flex: 1),
            const Text('Akkustand',
                style: TextStyle(
                  fontSize: 16,
                )),
            const Spacer(flex: 12),
            Switch(
              value: _switchvalue4,
              onChanged: (bool value) {
                if (!value) {

                } else {

                }
                setState(() {
                  _switchvalue4 = value;
                });
              },
            ),
          ]),
          Row(children: [
            const Icon(Icons.call),
            const Spacer(flex: 1),
            const Text('Anrufe',
                style: TextStyle(
                  fontSize: 16,
                )),
            const Spacer(flex: 12),
            Switch(
              value: _switchvalue5,
              onChanged: (bool value) {
                if (!value) {

                } else {

                }
                setState(() {
                  _switchvalue5 = value;
                });
              },
            ),
          ]),
          Row(children: [
            const Icon(Icons.cloud),
            const Spacer(flex: 1),
            const Text('Wetter',
                style: TextStyle(
                  fontSize: 16,
                )),
            const Spacer(flex: 12),
            Switch(
              value: _switchvalue6,
              onChanged: (bool value) {
                if (!value) {

                } else {

                }
                setState(() {
                  _switchvalue6 = value;
                });
              },
            ),
          ]),
          Row(children: [
            const Icon(Icons.sos_outlined),
            const Spacer(flex: 1),
            const Text('Notsignal',
                style: TextStyle(
                  fontSize: 16,
                )),
            const Spacer(flex: 12),
            Switch(
              value: _switchvalue7,
              onChanged: (bool value) {
                if (!value) {

                } else {

                }
                setState(() {
                  _switchvalue7 = value;
                });
              },
            ),
          ]),
          if (_switchvalue7)
            Row(children: [
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Notfallkontakt',
                    labelText: 'Bsp.: +49 123456789',
                  ),
                  onSaved: (String? value) {},
                  validator: (String? value) {},
                ),
              )
            ]),
          if (_notificationText != null) // Display notification text if available
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                _notificationText!,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
