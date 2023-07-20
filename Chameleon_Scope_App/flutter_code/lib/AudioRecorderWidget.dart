import 'dart:async';

import 'package:flutter/material.dart';
import 'DrawerWidget.dart';

class AudioRecorderWidget extends StatefulWidget {
  const AudioRecorderWidget({Key? key}) : super(key: key);

  @override
  _AudioRecorderWidgetState createState() => _AudioRecorderWidgetState();
}

class _AudioRecorderWidgetState extends State<AudioRecorderWidget> {
  bool _isRecording = false;
  bool _isPlaying = false;
  int _recordingCount = 1;
  int _selectedRecordingIndex = -1;

  List<String> dummyRecordings = ['Recording 1'];
  List<String> dummyRecordingDurations = ['3:45'];

  List<DateTime> startTimes = [];
  List<DateTime> stopTimes = [];
  Timer? _timer;
  int _secondsElapsed = 0;

  void _toggleRecording() {
    setState(() {
      _isRecording = !_isRecording;
      _isPlaying = false;
      if (_isRecording) {
        _selectedRecordingIndex = -1;
        startTimes.add(DateTime.now());
        _startTimer();
      } else {
        stopTimes.add(DateTime.now());
        _stopTimer();
      }
    });
  }

  void _togglePlaying() {
    setState(() {
      if (_selectedRecordingIndex != -1) {
        _isPlaying = !_isPlaying;
      }
    });
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String recordingName = '';
        return AlertDialog(
          title: Text('Please provide a name for the recording.'),
          content: TextField(
            onChanged: (value) {
              recordingName = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  _recordingCount++;
                  dummyRecordings.add(recordingName.isNotEmpty
                      ? recordingName
                      : 'Recording $_recordingCount');
                  dummyRecordingDurations.add(_calculateRecordingDuration(
                      startTimes.last, stopTimes.last));
                });
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _selectRecording(int index) {
    setState(() {
      _selectedRecordingIndex = index;
      _isPlaying = false;
    });
  }

  void _deleteRecording(int index) {
    if (index >= 0 && index < dummyRecordings.length) {
      setState(() {
        dummyRecordings.removeAt(index);
        dummyRecordingDurations.removeAt(index);
        if (index < startTimes.length) {
          startTimes.removeAt(index);
        }
        if (index < stopTimes.length) {
          stopTimes.removeAt(index);
        }
        _selectedRecordingIndex = -1;
        _isPlaying = false;
      });
    }
  }

  String _calculateRecordingDuration(DateTime startTime, DateTime stopTime) {
    Duration duration = stopTime.difference(startTime);
    int minutes = duration.inMinutes;
    int seconds = duration.inSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _secondsElapsed++;
      });
    });
  }

  void _stopTimer() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
      _secondsElapsed = 0;
    }
  }

  String _getFormattedTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Audiorecording'),
      ),
      drawer: DrawerWidget(),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: dummyRecordings.length,
            itemBuilder: (BuildContext context, int index) {
              return Dismissible(
                key: Key(dummyRecordings[index]),
                direction: DismissDirection.startToEnd,
                onDismissed: (direction) {
                  _deleteRecording(index);
                },
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
                child: ListTile(
                  title: Row(
                    children: [
                      Text(
                        dummyRecordings[index],
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: index == _selectedRecordingIndex
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        index == 0 ? '3:45' : dummyRecordingDurations[index],
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  tileColor:
                      index == _selectedRecordingIndex ? Colors.blue : null,
                  onTap: () {
                    _selectRecording(index);
                  },
                ),
              );
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _isRecording ? _getFormattedTime(_secondsElapsed) : '',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _toggleRecording();
                          if (_isRecording) {
                            // Starte Aufnahme
                          } else {
                            // Stoppe Aufnahme
                            _showDialog();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: _isRecording ? Colors.red : null,
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(20.0),
                        ),
                        child: Icon(
                          _isRecording ? Icons.stop : Icons.mic,
                          size: 50.0,
                        ),
                      ),
                      SizedBox(width: 40.0),
                      ElevatedButton(
                        onPressed: _selectedRecordingIndex != -1
                            ? _togglePlaying
                            : null,
                        style: ElevatedButton.styleFrom(
                          primary: _selectedRecordingIndex != -1
                              ? (_isPlaying ? Colors.blue : Colors.green)
                              : Colors.grey,
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(20.0),
                        ),
                        child: Icon(
                          _isPlaying ? Icons.pause : Icons.play_arrow,
                          size: 50.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
