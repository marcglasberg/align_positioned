import 'package:align_positioned/align_positioned.dart';
import 'package:flutter/material.dart';

void main() async => runApp(MaterialApp(home: Demo()));

class Demo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //
    // Center widget A, and then align B to the bottom of that.
    return Scaffold(
      appBar: AppBar(title: const Text('Center Below Example')),
      body: Center(
        child: AlignPositioned.relative(
          widgetA(),
          widgetB(),
          moveByContainerHeight: 0.5,
          moveByChildHeight: 0.5,
        ),
      ),
    );
  }

  Container widgetA() => Container(
        color: Colors.red,
        child: Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
            "sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. "
            "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi "
            "ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit "
            "in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 25)),
      );

  Container widgetB() => Container(
      color: Colors.blue,
      child: Text(
          "Excepteur sint occaecat.\n"
          "Duis aute irure dolor in reprehenderit.",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16)));
}
