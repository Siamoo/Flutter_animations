import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late Animation<AlignmentGeometry> _redAnimation;
  late AnimationController _redController;

  @override
  void dispose() {
    _redController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _redController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
      reverseDuration: Duration(seconds: 2),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Foo Transition")),
      body: Column(
        children: [
          _stackWidget(),

          ElevatedButton(
            onPressed: () {
              if (_redController.isCompleted) {
                _redController.reverse();
              } else {
                _redController.forward();
              }
            },

            child: Text("Forward"),
          ),
          _statusListenerControlButton(),
          _valueListenerControlButton(),
        ],
      ),
    );
  }

  Widget _stackWidget() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        AlignTransition(
          alignment: _redAnimation,
          child: CircleAvatar(backgroundColor: Colors.red),
        ),
      ],
    );
  }

  void _statusListener(AnimationStatus animationStatus) {
    print('==================$animationStatus');
  }

  _statusListenerControlButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () {
            _redController.addStatusListener(_statusListener);
            // _redAnimation.addStatusListener(_statusListener); can do it for AlignmentGeometry although
          },
          child: Text("Add Status Listener"),
        ),
        ElevatedButton(
          onPressed: () {
            _redController.removeStatusListener(_statusListener);
            // _redAnimation.removeStatusListener(_statusListener); can do it for AlignmentGeometry although
          },
          child: Text("Remove Status Listener"),
        ),
      ],
    );
  }

  void _valueListener() {
    print('==================${_redController.value}');
  }

  _valueListenerControlButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          onPressed: () {
            _redController.addListener(_valueListener);
            // _redAnimation.addListener(_valueListener); can do it for AlignmentGeometry although
          },
          child: Text("Add Value Listener"),
        ),
        ElevatedButton(
          onPressed: () {
            _redController.removeListener(_valueListener);
            // _redAnimation.removeListener(_valueListener); can do it for AlignmentGeometry although
          },
          child: Text("Remove Value Listener"),
        ),
      ],
    );
  }
}
