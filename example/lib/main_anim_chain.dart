import 'package:align_positioned/align_positioned.dart';
import 'package:flutter/material.dart';

void main() async => runApp(MaterialApp(home: Demo()));

class Demo extends StatelessWidget {
  //
  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      appBar: AppBar(title: const Text('AnimaChain + AnimatedAlignPositioned')),
      body: Container(
        color: Colors.grey,
        alignment: Alignment.center,
        child: Container(
          width: 150,
          height: 150,
          color: Colors.brown,
          child: AnimChain(repeat: true)
              // 1) Put the yellow box and wait 2 seconds.
              .next(
                wait: Duration(seconds: 2),
                widget: AnimatedAlignPositioned(
                  duration: Duration(seconds: 1),
                  alignment: Alignment.bottomCenter,
                  dy: 0,
                  childHeightRatio: 0.5,
                  childWidthRatio: 0.5,
                  rotateDegrees: 0,
                  child: AnimatedContainer(color: Colors.yellow, duration: Duration(seconds: 0)),
                ),
              )
              // 2) Then rotate and turn it red in 2 seconds.
              .next(
                wait: Duration(seconds: 2),
                widget: AnimatedAlignPositioned(
                  duration: Duration(seconds: 2),
                  alignment: Alignment.bottomCenter,
                  dy: 0,
                  childHeightRatio: 0.75,
                  childWidthRatio: 0.75,
                  rotateDegrees: 180,
                  child: AnimatedContainer(color: Colors.red, duration: Duration(seconds: 1)),
                ),
              )
              // 3) Finally, turn it blue and move it to the top in 3 seconds.
              .next(
                wait: Duration(seconds: 3),
                widget: AnimatedAlignPositioned(
                  duration: Duration(seconds: 3),
                  alignment: Alignment.bottomCenter,
                  dy: 150,
                  childHeightRatio: 0.5,
                  childWidthRatio: 0.5,
                  rotateDegrees: 180,
                  child: AnimatedContainer(color: Colors.blue, duration: Duration(seconds: 2)),
                ),
              ),
        ),
      ),
    );
  }
}
