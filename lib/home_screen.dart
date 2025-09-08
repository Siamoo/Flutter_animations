import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late Animation<AlignmentGeometry> _greenAnimation;
  late Animation<AlignmentGeometry> _redAnimation;
  late AnimationController _greenController;
  late AnimationController _redController;

  @override
  void initState() {
    super.initState();

    // AnimationStatus types
    AnimationStatus.completed;
    AnimationStatus.dismissed;
    AnimationStatus.forward;
    AnimationStatus.reverse;

    _greenController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
      reverseDuration: Duration(seconds: 1),
    );
    _redController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
      reverseDuration: Duration(seconds: 2),
    );
    _greenAnimation =
        Tween<AlignmentGeometry>(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ).animate(
          CurvedAnimation(
            parent: _greenController,
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
            parent: _redController,
            curve: Curves.easeInBack,
            // reverseCurve: Curves.easeOutBack,
          ),
        );

    _greenController.addStatusListener((status) {
      if (_greenController.status == AnimationStatus.completed &&
          _redController.status == AnimationStatus.dismissed) {
        _redController.forward();
      }
      if (_greenController.status == AnimationStatus.dismissed &&
          _redController.status == AnimationStatus.completed) {
        _redController.reverse();
      }
    });
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
          onPressed: () {
            _greenController.forward();
          },

          child: Text("Forward"),
        ),
        SizedBox(width: 30),
        ElevatedButton(
          onPressed: () {
            _greenController.reverse();
          },
          child: Text("Reverse"),
        ),
      ],
    );
  }
}
