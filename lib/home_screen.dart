import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double _begin = 100;
  double _end = 200;

    late final Widget _child; // 👈 keep a reference
  @override
  @override
  void initState() {
    super.initState();
    _child = _getColumnWidget();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tween Animations")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 30),
            _containerWidget(),
            Spacer(),
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
          _begin = (_begin == 100) ? 200 : 100;
          _end = (_end == 100) ? 200 : 100;
        });
      },
      child: const Text("Animate"),
    );
  }

Widget _containerWidget() {
  return TweenAnimationBuilder(
    curve: Curves.bounceInOut,
    tween: Tween<double>(begin: _begin, end: _end),
    duration: Duration(seconds: 2),
    child: _child,   
    builder: (context, value, child) {
      return Container(
        height: value,
        width: value,
        decoration: _getBoxDecoration(),
        child: child,   // we use the child from the builder to not rebuild it every time
      );
    },
  );
}

}

Widget _getColumnWidget() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: const [
      Text("Flutter", style: TextStyle(color: Colors.white, fontSize: 20)),
      Text("Animation", style: TextStyle(color: Colors.white, fontSize: 20)),
    ],
  );
}

_getBoxDecoration() {
  return BoxDecoration(
    color: Colors.blueAccent,
    borderRadius: BorderRadius.circular(10),
  );
}
