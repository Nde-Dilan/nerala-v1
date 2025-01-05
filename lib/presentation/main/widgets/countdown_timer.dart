import 'dart:async';
import 'package:flutter/material.dart';
import 'package:other_screens/common/constants.dart';

class CountdownTimer extends StatefulWidget {
  const CountdownTimer({super.key});

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  static const int _totalSeconds = 300; // 5 minutes
  late Timer _timer;
  int _seconds = _totalSeconds;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_seconds > 0) {
          _seconds--;
        } else {
          _timer.cancel();
        }
      });
    });
  }

  String get timeLeft {
    int minutes = _seconds ~/ 60;
    int remainingSeconds = _seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 40,
          height: 40,
          child: CircularProgressIndicator(
            value: _seconds / _totalSeconds,
            backgroundColor: seedColorPalette.shade100,
            color: seedColor,
            strokeWidth: 4,
          ),
        ),
        Text(
          timeLeft,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: seedColor,
          ),
        ),
      ],
    );
  }
}