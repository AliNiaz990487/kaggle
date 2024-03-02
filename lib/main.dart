import 'dart:async';
import 'package:flutter/material.dart';
bool isChanged = false;
void main() {
  runApp(const Kaggle());
}

class Kaggle extends StatelessWidget {
  const Kaggle({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text("Exercise")),
        body: Column(
          children: [
            const IncDecCounter(),
            const CountdownTimer(),
            TextButton(onPressed: (){ isChanged = true; }, child: const Text("Start"))
          ],
        ),
      ),
    );
  }
}

class IncDecCounter extends StatefulWidget {
  const IncDecCounter({super.key});

  @override
  IncDecCounterState createState() => IncDecCounterState();
}

class IncDecCounterState extends State<IncDecCounter> {
  int count = 1;
  

  void increment() {
    if (count < 10) {
      setState(() {
        count++;
        isChanged = true;
      });
    }
  }

  void decrement() {
    if (count > 1) {
      setState(() {
        count--;
        isChanged = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: decrement,
          icon: const Icon(Icons.remove_circle_outline),
        ),
        Text("$count"),
        IconButton(
          onPressed: increment,
          icon: const Icon(Icons.add_circle_outline),
        ),
      ],
    );
  }
}

class CountdownTimer extends StatefulWidget {
  const CountdownTimer({super.key});

  @override
  CountdownTimerState createState() => CountdownTimerState();
}

class CountdownTimerState extends State<CountdownTimer> {
  late Timer _timer;
  int _seconds = 10;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds > 0 && isChanged) {
        setState(() {
          _seconds--;
        });
      } else {
        _seconds = 10; // Reset the countdown
        isChanged = false;
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      '$_seconds seconds left',
      style: const TextStyle(fontSize: 20),
    );
  }
}
