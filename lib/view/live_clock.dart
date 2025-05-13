import 'dart:async';
import 'package:flutter/material.dart';

class LiveClock extends StatefulWidget {
  const LiveClock({super.key, this.textStyle});

  final TextStyle? textStyle;

  @override
  State<LiveClock> createState() => _LiveClockState();
}

class _LiveClockState extends State<LiveClock> {
  late Timer _timer;
  String _currentTime = '';

  @override
  void initState() {
    super.initState();
    _updateTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _updateTime());
  }

  void _updateTime() {
    final now = DateTime.now();
    setState(() {
      _currentTime =
      '${_formatTwo(now.day)}-${_formatTwo(now.month)}-${now.year} ${_formatTwo(now.hour)}:${_formatTwo(now.minute)}:${_formatTwo(now.second)}';
    });
  }

  String _formatTwo(int n) => n.toString().padLeft(2, '0');

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _currentTime,
      style: widget.textStyle ?? const TextStyle(fontSize: 12, color: Colors.black54),
    );
  }
}
