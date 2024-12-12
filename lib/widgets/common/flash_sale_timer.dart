import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ufo_elektronika/constants/colors.dart';

class FlashSaleTimer extends StatefulWidget {
  const FlashSaleTimer({
    super.key,
    required this.seconds,
    required this.minutes,
    required this.hours,
    this.onCountdownEnd,
  });

  /// seconds
  final int seconds;

  /// minutes
  final int minutes;

  /// hours
  final int hours;

  // callback function when countdown end
  final VoidCallback? onCountdownEnd;

  @override
  State<FlashSaleTimer> createState() => _FlashSaleTimerState();
}

class _FlashSaleTimerState extends State<FlashSaleTimer> {
  // The seconds, minutes and hours
  int _seconds = 0;
  int _minutes = 0;
  int _hours = 0;

  // The timer
  Timer? _timer;

  // This function will be called when the user presses the start button
  // Start the timer
  // The timer will run every second
  // The timer will stop when the hours, minutes and seconds are all 0
  void _startTimer() {
    setState(() {});
    _timer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      setState(() {
        if (_seconds > 0) {
          _seconds--;
        } else {
          if (_minutes > 0) {
            _minutes--;
            _seconds = 59;
          } else {
            if (_hours > 0) {
              _hours--;
              _minutes = 59;
              _seconds = 59;
            } else {
              widget.onCountdownEnd!();
              _timer?.cancel();
            }
          }
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _seconds = widget.seconds;
    _minutes = widget.minutes;
    _hours = widget.hours;

    _startTimer();
  }

  // Cancel the timer when the widget is disposed
  @override
  void dispose() {
    if (_timer != null) {
      _timer!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: AppColor.yellow,
          ),
          child: Center(
            child: Text(
              _hours.toString().padLeft(2, '0'),
              style: const TextStyle(
                color: AppColor.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 9.3,
              ),
            ),
          ),
        ),
        const SizedBox(width: 5),
        Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: AppColor.yellow,
          ),
          child: Center(
            child: Text(
              _minutes.toString().padLeft(2, '0'),
              style: const TextStyle(
                color: AppColor.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 9.3,
              ),
            ),
          ),
        ),
        const SizedBox(width: 5),
        Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: AppColor.yellow,
          ),
          child: Center(
            child: Text(
              _seconds.toString().padLeft(2, '0'),
              style: const TextStyle(
                color: AppColor.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 9.3,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
