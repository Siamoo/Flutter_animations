import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late Animation<AlignmentGeometry> _greenAnimation;
  late Animation<AlignmentGeometry> _redAnimation;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
      reverseDuration: Duration(seconds: 1),
    );
    _greenAnimation =
        Tween<AlignmentGeometry>(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
            reverseCurve: Curves.easeInOut,
          ),
        );
    _redAnimation =
        Tween<AlignmentGeometry>(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInBack,
            // reverseCurve: Curves.easeOutBack,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Foo Transition")),
      body: Column(children: [_stackWidget(), _controlButton()]),
    );
  }

  Widget _stackWidget() {
    return Expanded(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          AlignTransition(
            alignment: _greenAnimation,
            child: CircleAvatar(backgroundColor: Colors.green),
          ),
          AlignTransition(
            alignment: _redAnimation,
            child: CircleAvatar(backgroundColor: Colors.red),
          ),
        ],
      ),
    );
  }

  Widget _controlButton() {
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      children: [
        ElevatedButton(
          onPressed: () => _animationController.forward(),
          child: Text("Forward"),
        ),
        ElevatedButton(
          onPressed: () => _animationController.reverse(),
          child: Text("Reverse"),
        ),
        ElevatedButton(
          onPressed: () => _animationController.stop(),
          child: Text("Stop"),
        ),
        ElevatedButton(
          onPressed: () => _animationController.reset(),
          child: Text("Reset"),
        ),
        ElevatedButton(
          onPressed: () => _animationController.repeat(),
          child: Text("Repeat (reverse=false)"),
        ),
        SizedBox(width: 5),
        ElevatedButton(
          onPressed: () => _animationController.repeat(reverse: true),
          child: Text("Repeat (reverse=true)"),
        ),
      ],
    );
  }
}
