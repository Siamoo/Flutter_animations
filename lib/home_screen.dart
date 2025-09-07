import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double _dimension = 100;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Animated Foo Basics")),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 30),
            _containerWidget(),
            Spacer(),
            SizedBox(height: 30),
            _buttonWidget(),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  ElevatedButton _buttonWidget() {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _dimension = _dimension == 100 ? 200 : 100;
        });
      },
      child: const Text("Animate"),
    );
  }

  Widget _containerWidget() {
    return AnimatedContainer(
      height: _dimension,
      width: _dimension,
      curve: Curves.bounceOut,
      decoration: _getBoxDecoration(),
      duration: const Duration(seconds: 2),
    );
  }

  BoxDecoration _getBoxDecoration() {
    return BoxDecoration(
      color: Colors.blueAccent,
      borderRadius: BorderRadius.circular(20),
    );
  }
}
