import 'package:flutter/material.dart';

class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Counter Screen")),
      body: Center(
        child: TweenAnimationBuilder(
          tween: IntTween(
            // if we not find Intween we need to use Tween<int> like Tween<double>
            begin: 0,
            end: 100,
          ),
          duration: Duration(seconds: 1),
          builder: (context, value, child) {
            return Text(value.toString(), style: _getTextStyle());
          },
        ),
      ),
    );
  }

  TextStyle _getTextStyle() {
    return TextStyle(
      fontSize: 120,
      fontWeight: FontWeight.bold,
      color: Colors.blueAccent,
    );
  }
}
