import 'package:align_positioned/align_positioned.dart';
import 'package:flutter/material.dart';
import 'package:matrix4_transform/matrix4_transform.dart';

void main() async => runApp(MaterialApp(home: Demo()));

class Demo extends StatelessWidget {
  //
  static const angle = 135.0;

  /// Thickness in relation to the height.
  static const thickness = 0.15;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Orthogonal position')),
      body: Center(
        child: Column(
          children: [
            Spacer(),
            Container(
              width: 350,
              height: 350,
              color: Colors.blue,
              child: Center(
                child: AspectRatio(
                  aspectRatio: 1.0,
                  child: Stack(
                    children: [
                      AnimatedAlignPositioned(
                        child: rectangle(Colors.red.withOpacity(0.7)),
                        childWidthRatio: 0.8,
                        childHeightRatio: thickness,
                        moveByChildHeight: 0.5,
                        moveByContainerHeight: -0.21,
                        moveByContainerWidth: -0.1,
                        rotateDegrees: angle,
                      ),
                      AnimatedAlignPositioned(
                        child: rectangle(Colors.green.withOpacity(0.7)),
                        rotateDegrees: 90 + angle,
                        childWidthRatio: 0.42,
                        childHeightRatio: thickness,
                        moveByContainerHeight: -0.3,
                        moveByChildHeight: 0.5,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }

  Widget rectangle(Color color) => Container(
          decoration: BoxDecoration(
        color: color,
        border: Border.all(width: 1.0, color: Colors.black),
        shape: BoxShape.rectangle,
      ));
}
