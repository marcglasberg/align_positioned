import 'package:align_positioned/align_positioned.dart';
import 'package:flutter/material.dart';

void main() async => runApp(MaterialApp(home: Demo()));

class Demo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //

    return Scaffold(
      appBar: AppBar(title: const Text('Align Positioned Widget Example')),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 50, width: double.infinity),
              //
              Container(
                  width: 150,
                  height: 150,
                  color: Colors.yellow,
                  child: Stack(children: circlesInside())),
              //
              SizedBox(height: 50, width: double.infinity),
              //
              Container(
                  width: 150,
                  height: 150,
                  color: Colors.yellow,
                  child: Stack(children: circlesOutside())),
              //
              SizedBox(height: 60),
              //
              Container(
                  width: 150,
                  height: 150,
                  color: Colors.yellow,
                  child: Stack(children: circlesWithOffset())),
              SizedBox(height: 100),
              //
              Container(
                  width: 150,
                  height: 150,
                  color: Colors.yellow,
                  child: Stack(children: circlesWithNamedAlignments())),
              //
              SizedBox(height: 50),
              //
              Container(
                  width: 150,
                  height: 150,
                  color: Colors.yellow,
                  child: Stack(children: circlesWithmoveByChildWidthAndmoveByChildHeightInside())),
              //
              SizedBox(height: 50),
              //
              Container(
                  width: 150,
                  height: 150,
                  color: Colors.yellow,
                  child: Stack(children: circlesWithmoveByChildWidthAndmoveByChildHeightOutside())),
              //
              SizedBox(height: 80),
              //
              Container(
                width: 150,
                height: 150,
                color: Colors.red,
                child: Stack(
                  children: <Widget>[
                    AlignPositioned(
                      touch: Touch.inside,
                      alignment: Alignment.topLeft,
                      dx: 15.0,
                      moveByChildWidth: -0.5,
                      moveByChildHeight: -0.5,
                      child: circle(Color(0x50000000), 60.0),
                    ),
                    AlignPositioned(
                      touch: Touch.inside,
                      alignment: Alignment.topLeft,
                      dx: 15.0,
                      moveByChildWidth: -0.5,
                      moveByChildHeight: -0.5,
                      child: circle(Colors.white, 5.0),
                    ),
                  ],
                ),
              ),
              //
              SizedBox(height: 50),
              //
              Container(
                width: 150,
                height: 150,
                color: Colors.red,
                child: Stack(
                  children: <Widget>[
                    AlignPositioned(
                      touch: Touch.inside,
                      alignment: Alignment.topLeft,
                      dx: 15.0,
                      moveByChildWidth: -0.5,
                      moveByChildHeight: -0.5,
                      moveByContainerWidth: 1,
                      moveByContainerHeight: 1,
                      child: circle(Color(0x50000000), 60.0),
                    ),
                    AlignPositioned(
                      touch: Touch.inside,
                      alignment: Alignment.topLeft,
                      dx: 15.0,
                      moveByChildWidth: -0.5,
                      moveByChildHeight: -0.5,
                      moveByContainerWidth: 1,
                      moveByContainerHeight: 1,
                      child: circle(Colors.white, 5.0),
                    ),
                  ],
                ),
              ),
              //
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> circlesWithmoveByChildWidthAndmoveByChildHeightInside() {
    var children1 = <Widget>[];
    children1.addAll(
        circles(Colors.red, Touch.inside, 0, -1, moveByChildWidth: 0.0, moveByChildHeight: 0.0));
    children1.addAll(
        circles(Colors.blue, Touch.inside, 0, -1, moveByChildWidth: 1.0, moveByChildHeight: 0.0));
    children1.addAll(
        circles(Colors.green, Touch.inside, 0, -1, moveByChildWidth: -1.0, moveByChildHeight: 0.0));

    children1.addAll(
        circles(Colors.red, Touch.inside, 1, 0, moveByChildWidth: 0.0, moveByChildHeight: 0.0));
    children1.addAll(
        circles(Colors.blue, Touch.inside, 1, 0, moveByChildWidth: 0.0, moveByChildHeight: 1.0));
    children1.addAll(
        circles(Colors.green, Touch.inside, 1, 0, moveByChildWidth: 0.0, moveByChildHeight: -1.0));

    children1.addAll(
        circles(Colors.red, Touch.inside, 0, 1, moveByChildWidth: 0.0, moveByChildHeight: 0.0));
    children1.addAll(
        circles(Colors.blue, Touch.inside, 0, 1, moveByChildWidth: 1.0, moveByChildHeight: 0.0));
    children1.addAll(
        circles(Colors.green, Touch.inside, 0, 1, moveByChildWidth: -1.0, moveByChildHeight: 0.0));

    children1.addAll(
        circles(Colors.red, Touch.inside, -1, 0, moveByChildWidth: 0.0, moveByChildHeight: 0.0));
    children1.addAll(
        circles(Colors.blue, Touch.inside, -1, 0, moveByChildWidth: 0.0, moveByChildHeight: 1.0));
    children1.addAll(
        circles(Colors.green, Touch.inside, -1, 0, moveByChildWidth: 0.0, moveByChildHeight: -1.0));
    return children1;
  }

  List<Widget> circlesWithmoveByChildWidthAndmoveByChildHeightOutside() {
    var children1 = <Widget>[];
    children1.addAll(
        circles(Colors.red, Touch.outside, 0, -1, moveByChildWidth: 0.0, moveByChildHeight: 0.0));
    children1.addAll(
        circles(Colors.blue, Touch.outside, 0, -1, moveByChildWidth: 1.0, moveByChildHeight: 0.0));
    children1.addAll(circles(Colors.green, Touch.outside, 0, -1,
        moveByChildWidth: -1.0, moveByChildHeight: 0.0));

    children1.addAll(
        circles(Colors.red, Touch.outside, 1, 0, moveByChildWidth: 0.0, moveByChildHeight: 0.0));
    children1.addAll(
        circles(Colors.blue, Touch.outside, 1, 0, moveByChildWidth: 0.0, moveByChildHeight: 1.0));
    children1.addAll(
        circles(Colors.green, Touch.outside, 1, 0, moveByChildWidth: 0.0, moveByChildHeight: -1.0));

    children1.addAll(
        circles(Colors.red, Touch.outside, 0, 1, moveByChildWidth: 0.0, moveByChildHeight: 0.0));
    children1.addAll(
        circles(Colors.blue, Touch.outside, 0, 1, moveByChildWidth: 1.0, moveByChildHeight: 0.0));
    children1.addAll(
        circles(Colors.green, Touch.outside, 0, 1, moveByChildWidth: -1.0, moveByChildHeight: 0.0));

    children1.addAll(
        circles(Colors.red, Touch.outside, -1, 0, moveByChildWidth: 0.0, moveByChildHeight: 0.0));
    children1.addAll(
        circles(Colors.blue, Touch.outside, -1, 0, moveByChildWidth: 0.0, moveByChildHeight: 1.0));
    children1.addAll(circles(Colors.green, Touch.outside, -1, 0,
        moveByChildWidth: 0.0, moveByChildHeight: -1.0));
    return children1;
  }

  List<Widget> circlesInside() {
    var children1 = <Widget>[];
    children1.addAll(circles(Colors.red, Touch.inside, 0, -1));
    children1.addAll(circles(Colors.red, Touch.inside, -1, 0));
    children1.addAll(circles(Colors.red, Touch.inside, 0, 1));
    children1.addAll(circles(Colors.red, Touch.inside, 1, 0));
    children1.addAll(circles(Colors.blue, Touch.inside, -1, -1));
    children1.addAll(circles(Colors.blue, Touch.inside, -1, 1));
    children1.addAll(circles(Colors.blue, Touch.inside, 1, 1));
    children1.addAll(circles(Colors.blue, Touch.inside, 1, -1));
    return children1;
  }

  List<Widget> circlesOutside() {
    var children1 = <Widget>[];
    children1.addAll(circles(Colors.red, Touch.outside, 0, -1));
    children1.addAll(circles(Colors.red, Touch.outside, -1, 0));
    children1.addAll(circles(Colors.red, Touch.outside, 0, 1));
    children1.addAll(circles(Colors.red, Touch.outside, 1, 0));
    children1.addAll(circles(Colors.blue, Touch.outside, -1, -1));
    children1.addAll(circles(Colors.blue, Touch.outside, -1, 1));
    children1.addAll(circles(Colors.blue, Touch.outside, 1, 1));
    children1.addAll(circles(Colors.blue, Touch.outside, 1, -1));
    return children1;
  }

  List<Widget> circlesWithOffset() {
    var children2 = <Widget>[];
    children2.addAll(circles(Colors.purple, Touch.outside, 0, -1, dx: -15, dy: 15));
    children2.addAll(circles(Colors.purple, Touch.outside, -1, 0, dx: -15, dy: 15));
    children2.addAll(circles(Colors.purple, Touch.outside, 0, 1, dx: -15, dy: 15));
    children2.addAll(circles(Colors.purple, Touch.outside, 1, 0, dx: -15, dy: 15));
    children2.addAll(circles(Colors.green, Touch.inside, 0, -1, dx: -15, dy: 15));
    children2.addAll(circles(Colors.green, Touch.inside, -1, 0, dx: -15, dy: 15));
    children2.addAll(circles(Colors.green, Touch.inside, 0, 1, dx: -15, dy: 15));
    children2.addAll(circles(Colors.green, Touch.inside, 1, 0, dx: -15, dy: 15));

    return children2;
  }

  List<Widget> circles(
    Color color,
    Touch touch,
    int dirX,
    int dirY, {
    double dx,
    double dy,
    double moveByChildWidth,
    double moveByChildHeight,
  }) {
    return <Widget>[
      alignPositionedCircle(
          0.0, color, dirX, dirY, touch, dx, dy, moveByChildWidth, moveByChildHeight),
      alignPositionedCircle(
          0.1, color, dirX, dirY, touch, dx, dy, moveByChildWidth, moveByChildHeight),
      alignPositionedCircle(
          0.2, color, dirX, dirY, touch, dx, dy, moveByChildWidth, moveByChildHeight),
      alignPositionedCircle(
          0.3, color, dirX, dirY, touch, dx, dy, moveByChildWidth, moveByChildHeight),
      alignPositionedCircle(
          0.4, color, dirX, dirY, touch, dx, dy, moveByChildWidth, moveByChildHeight),
      alignPositionedCircle(
          0.5, color, dirX, dirY, touch, dx, dy, moveByChildWidth, moveByChildHeight),
      alignPositionedCircle(
          0.6, color, dirX, dirY, touch, dx, dy, moveByChildWidth, moveByChildHeight),
      alignPositionedCircle(
          0.7, color, dirX, dirY, touch, dx, dy, moveByChildWidth, moveByChildHeight),
      alignPositionedCircle(
          0.8, color, dirX, dirY, touch, dx, dy, moveByChildWidth, moveByChildHeight),
      alignPositionedCircle(
          0.9, color, dirX, dirY, touch, dx, dy, moveByChildWidth, moveByChildHeight),
      alignPositionedCircle(
          1.0, color, dirX, dirY, touch, dx, dy, moveByChildWidth, moveByChildHeight),
    ];
  }

  List<Widget> circlesWithNamedAlignments() {
    return <Widget>[
      AlignPositioned(
          child: circle(Colors.orange), alignment: Alignment.center, touch: Touch.inside),
      AlignPositioned(
          child: circle(Colors.orange), alignment: Alignment.center, touch: Touch.outside),

      //
      AlignPositioned(
          child: circle(Colors.green), alignment: Alignment.centerRight, touch: Touch.inside),
      AlignPositioned(
          child: circle(Colors.green), alignment: Alignment.bottomCenter, touch: Touch.inside),
      AlignPositioned(
          child: circle(Colors.green), alignment: Alignment.centerLeft, touch: Touch.inside),
      AlignPositioned(
          child: circle(Colors.green), alignment: Alignment.topCenter, touch: Touch.inside),
      //
      AlignPositioned(
          child: circle(Colors.blue), alignment: Alignment.topRight, touch: Touch.inside),
      AlignPositioned(
          child: circle(Colors.blue), alignment: Alignment.bottomRight, touch: Touch.inside),
      AlignPositioned(
          child: circle(Colors.blue), alignment: Alignment.topLeft, touch: Touch.inside),
      AlignPositioned(
          child: circle(Colors.blue), alignment: Alignment.bottomLeft, touch: Touch.inside),
      //
      AlignPositioned(
          child: circle(Colors.red), alignment: Alignment.centerRight, touch: Touch.outside),
      AlignPositioned(
          child: circle(Colors.red), alignment: Alignment.bottomCenter, touch: Touch.outside),
      AlignPositioned(
          child: circle(Colors.red), alignment: Alignment.centerLeft, touch: Touch.outside),
      AlignPositioned(
          child: circle(Colors.red), alignment: Alignment.topCenter, touch: Touch.outside),
      //
      AlignPositioned(
          child: circle(Colors.purple), alignment: Alignment.topRight, touch: Touch.outside),
      AlignPositioned(
          child: circle(Colors.purple), alignment: Alignment.bottomRight, touch: Touch.outside),
      AlignPositioned(
          child: circle(Colors.purple), alignment: Alignment.topLeft, touch: Touch.outside),
      AlignPositioned(
          child: circle(Colors.purple), alignment: Alignment.bottomLeft, touch: Touch.outside),
    ];
  }

  AlignPositioned alignPositionedCircle(
    double mult,
    Color color,
    int dirX,
    int dirY,
    Touch touch,
    double dx,
    double dy,
    double moveByChildWidth,
    double moveByChildHeight,
  ) {
    return AlignPositioned(
        child: circle(color),
        alignment: Alignment(mult * dirX, mult * dirY),
        touch: touch,
        dx: dx,
        dy: dy,
        moveByChildWidth: moveByChildWidth,
        moveByChildHeight: moveByChildHeight);
  }

  Container circle(Color color, [double diameter = 30.0]) {
    return Container(
        width: diameter,
        height: diameter,
        decoration: BoxDecoration(
          border: Border.all(width: 1.0, color: Colors.black),
          color: color,
          shape: BoxShape.circle,
        ));
  }
}
