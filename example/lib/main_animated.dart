import 'dart:async';
import 'dart:math';

import 'package:align_positioned/align_positioned.dart';
import 'package:flutter/material.dart';
import 'package:matrix4_transform/matrix4_transform.dart';

void main() async => runApp(MaterialApp(home: Demo()));

class Demo extends StatefulWidget {
  @override
  _DemoState createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  late ScrollController controller;
  late bool forward;
  late int frame;

  @override
  void initState() {
    super.initState();
    controller = ScrollController();

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      controller.animateTo(3000, duration: Duration(seconds: 35), curve: Curves.easeIn);
    });

    frame = 1;
    forward = true;

    Timer.periodic(Duration(seconds: 1), (_) {
      print("frame: $frame");
      setState(() {
        frame = frame + (forward ? 1 : -1);
        if (frame == 0) forward = true;
        if (frame == 10) forward = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      appBar: AppBar(title: const Text('AnimatedAlignPositioned Example')),
      body: Center(
        child: SingleChildScrollView(
          controller: controller,
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
                child: AnimatedAlignPositioned(
                  matrix4Transform: Matrix4Transform().scale((frame + 1) / 10),
                  child: Container(
                      width: 150,
                      height: 150,
                      color: Colors.yellow,
                      child: Stack(children: circlesWithNamedAlignments())),
                ),
              ),
              //
              SizedBox(height: 50),
              //
              Container(
                  width: 150,
                  height: 150,
                  color: Colors.yellow,
                  child: Stack(children: circlesWithDWidthAndDHeightInside())),
              //
              SizedBox(height: 50),
              //
              Container(
                  width: 150,
                  height: 150,
                  color: Colors.yellow,
                  child: Stack(children: circlesWithDWidthAndDHeightOutside())),
              //
              SizedBox(height: 80),
              //
              Container(
                width: 150,
                height: 150,
                color: Colors.blue,
                child: Stack(
                  children: <Widget>[
                    AnimatedAlignPositioned(
                      rotateDegrees: frame * 90.0,
                      touch: Touch.inside,
                      alignment: Alignment.topLeft,
                      dx: 15.0,
                      moveByChildWidth: -0.5,
                      moveByChildHeight: -0.5,
                      child: circle(Color(0x50F0F000), 60.0),
                    ),
                    AnimatedAlignPositioned(
                      rotateDegrees: frame * 90.0,
                      touch: Touch.inside,
                      alignment: Alignment.topLeft,
                      dx: 15.0,
                      moveByChildWidth: -0.5,
                      moveByChildHeight: -0.5,
                      child: circle(Colors.white, 5.0),
                    ),
                    AnimatedAlignPositioned(
                      rotateDegrees: -frame * 90.0,
                      touch: Touch.inside,
                      alignment: Alignment.bottomRight,
                      dx: 15.0,
                      moveByChildWidth: 0.5,
                      moveByChildHeight: 0.5,
                      child: circle(Color(0x500000F0), 60.0),
                    ),
                    AnimatedAlignPositioned(
                      rotateDegrees: -frame * 90.0,
                      touch: Touch.inside,
                      alignment: Alignment.bottomRight,
                      dx: 15.0,
                      moveByChildWidth: 0.5,
                      moveByChildHeight: 0.5,
                      child: circle(Colors.white, 5.0),
                    ),
                    AnimatedAlignPositioned(
                      rotateDegrees: frame * 90.0,
                      touch: Touch.inside,
                      alignment: Alignment.center,
                      moveByContainerWidth: -0.5,
                      moveByContainerHeight: -0.5,
                      child: circle(Color(0x500F0000), 60.0),
                    ),
                    AnimatedAlignPositioned(
                      rotateDegrees: frame * 90.0,
                      touch: Touch.inside,
                      alignment: Alignment.center,
                      moveByContainerWidth: -0.5,
                      moveByContainerHeight: -0.5,
                      child: circle(Colors.white, 5.0),
                    ),
                    AnimatedAlignPositioned(
                      rotateDegrees: -frame * 90.0,
                      touch: Touch.outside,
                      alignment: Alignment.bottomRight,
                      moveByContainerWidth: -0.5,
                      moveByContainerHeight: -0.5,
                      child: circle(Color(0x50F00000), 60.0),
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
                color: Colors.pink,
                child: Stack(
                  children: <Widget>[
                    for (double i = 0; i < 200; i++)
                      AnimatedAlignPositioned(
                        duration: const Duration(seconds: 2),
                        rotateDegrees: i * 5,
                        touch: Touch.inside,
                        alignment: Alignment.topLeft,
                        dx: 15.0,
                        moveByChildWidth: -0.5,
                        moveByChildHeight: -0.5,
                        moveByContainerWidth: 1 * frame / 20 * (i / 100),
                        moveByContainerHeight: 1 * frame / 20 * (i / 100),
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
                color: Colors.green,
                child: Stack(
                  children: <Widget>[
                    for (double i = 0; i < 360 * 3; i += 5)
                      AnimatedAlignPositioned(
                        duration: Duration(seconds: 2),
                        alignment: Alignment.center,
                        rotateDegrees: i + frame * 36,
                        touch: Touch.inside,
                        moveByContainerWidth: 0.5 / 2 / 360 * i + ((frame - 5) / 20),
                        childWidthRatio: 0.5 / 2 / 360 * i,
                        childHeightRatio: 0.5 / 2 / 360 * i,
                        child: circle(Colors.white10, 15.0),
                      )
                  ],
                ),
              ),
              //
              SizedBox(height: 50),
              //
              Container(
                width: 150,
                height: 150,
                color: Colors.green,
                child: Stack(
                  children: <Widget>[
                    for (double i = 0; i < 360; i += 45)
                      AnimatedAlignPositioned(
                        alignment: Alignment.center,
                        rotateDegrees: i + frame * 36,
                        child: Container(color: Colors.black, width: 60, height: 6),
                      ),
                    for (double i = 0; i < 360; i += 15)
                      AnimatedAlignPositioned(
                        alignment: Alignment.center,
                        dx: 50,
                        dy: 60,
                        rotateDegrees: i * frame,
                        child: Container(color: Colors.black, width: 40, height: 8),
                      ),
                    for (double i = 0; i < 360; i += 5)
                      AnimatedAlignPositioned(
                        duration: Duration(seconds: 2),
                        curve: Curves.linear,
                        alignment: Alignment.bottomLeft,
                        rotateDegrees: i * 3 / (frame / 3.0 + 1),
                        child: Container(
                            color: Colors.black.withOpacity(i / 360 * .8), width: 100, height: 10),
                      )
                  ],
                ),
              ),
              //
              SizedBox(height: 120),
              //
              Container(
                width: 150,
                height: 150,
                color: Colors.purple,
                child: Stack(
                  children: <Widget>[
                    AnimatedAlignPositioned(
                      duration: Duration(milliseconds: 1800),
                      alignment: Alignment.center,
                      rotateDegrees: Random().nextDouble() * 360,
                      child: Container(color: Colors.yellow, width: 60, height: 20),
                    ),
                    AnimatedAlignPositioned(
                      duration: Duration(milliseconds: 2000),
                      alignment: Alignment.center,
                      rotateDegrees: Random().nextDouble() * 360,
                      matrix4Transform: Matrix4Transform().scale(2),
                      child: Container(color: Colors.green.withOpacity(0.5), width: 60, height: 20),
                    ),
                    AnimatedAlignPositioned(
                      duration: Duration(milliseconds: 1200),
                      alignment: Alignment.center,
                      rotateDegrees: Random().nextDouble() * 360,
                      matrix4Transform: Matrix4Transform().scale(2),
                      child: Container(color: Colors.red.withOpacity(0.5), width: 60, height: 20),
                    ),
                    AnimatedAlignPositioned(
                      duration: Duration(milliseconds: 800),
                      alignment: Alignment.center,
                      rotateDegrees: Random().nextDouble() * 360,
                      matrix4Transform: Matrix4Transform().scale(2).rotateDegrees(90),
                      child: Container(color: Colors.blue.withOpacity(0.5), width: 60, height: 20),
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
                color: Colors.brown,
                child: AnimatedAlignPositioned(
                  duration: Duration(seconds: 1),
                  alignment: Alignment.bottomCenter,
                  childHeightRatio: 0.5,
                  childWidthRatio: 0.5,
                  matrix4Transform: Matrix4Transform()
                      .rotateDegrees((frame % 2 == 0) ? 0 : 180)
                      .translate(y: (frame % 2 == 0) ? 0 : -150),
                  child: Container(color: Colors.yellow),
                ),
              ),
              //
              Container(
                width: 150,
                height: 150,
                color: Colors.brown,
                child: AnimatedAlignPositioned(
                  duration: Duration(seconds: 1),
                  alignment: Alignment.bottomCenter,
                  dy: (frame % 2 == 0) ? 0 : 150,
                  childHeightRatio: 0.5,
                  childWidthRatio: 0.5,
                  rotateDegrees: (frame % 2 == 0) ? 0 : -180,
                  child: Container(color: Colors.yellow),
                ),
              ),
              //
              SizedBox(height: 50),
              //
              Container(
                width: 150,
                height: 150,
                color: Colors.red,
                child: AnimatedAlignPositioned(
                  alignment: Alignment.center,
                  childHeightRatio: frame % 2 == 0 ? 1.0 : 0.5,
                  moveByChildHeight: frame % 2 == 0 ? 0 : 0.5,
                  childWidth: frame % 2 == 0 ? 75 : 120,
                  wins: Wins.min,
                  child: Container(color: Color(0x50000000)),
                ),
              ),
              //
              SizedBox(height: 50),
              //
              Container(
                width: 150,
                height: 150,
                color: Colors.red,
                child: AnimatedAlignPositioned(
                  alignment: frame % 2 == 0 ? Alignment.centerLeft : Alignment.centerRight,
                  childHeightRatio: 1.0,
                  minChildWidthRatio: 0.66,
                  maxChildWidthRatio: 0.33,
                  wins: Wins.min,
                  touch: (frame < 5.0) ? Touch.outside : Touch.inside,
                  child: Container(color: Color(0x50000000)),
                ),
              ),
              //
              SizedBox(height: 50),
              //
              Container(
                width: 150,
                height: 150,
                color: Colors.red,
                child: AnimatedAlignPositioned(
                  alignment: Alignment.center,
                  childHeightRatio: 1.0,
                  minChildWidthRatio: 0.66,
                  maxChildWidthRatio: frame % 2 == 0 ? 1.0 : 0.33,
                  wins: Wins.max,
                  child: Container(color: Color(0x50000000)),
                ),
              ),
              //
              SizedBox(height: 50),
              //
              Container(
                width: 150,
                height: 150,
                color: Colors.red,
                child: AnimatedAlignPositioned(
                  alignment: Alignment.center,
                  childHeightRatio: frame % 2 == 0 ? 1.0 : 1.20,
                  moveByContainerHeight: 0.10,
                  childWidth: 190,
                  wins: Wins.max,
                  child: Container(color: Color(0x50000000)),
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

  List<Widget> circlesWithDWidthAndDHeightInside() {
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

  List<Widget> circlesWithDWidthAndDHeightOutside() {
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
    double? dx,
    double? dy,
    double? moveByChildWidth,
    double? moveByChildHeight,
  }) {
    return <Widget>[
      for (double i = 0.0; i <= 1.0; i += 0.1)
        alignPositionedCircle(
            i * (frame % 3), color, dirX, dirY, touch, dx, dy, moveByChildWidth, moveByChildHeight),
    ];
  }

  List<Widget> circlesWithNamedAlignments() {
    return <Widget>[
      AnimatedAlignPositioned(
          rotateDegrees: frame * 90.0,
          child: Container(color: Colors.orange, width: 30, height: 30),
          alignment: Alignment.center,
          touch: Touch.inside),

      //
      AnimatedAlignPositioned(
          rotateDegrees: frame * 90.0,
          child: circle(Colors.green),
          alignment: Alignment.centerRight,
          touch: Touch.inside),
      AnimatedAlignPositioned(
          rotateDegrees: frame * 90.0,
          child: circle(Colors.green),
          alignment: Alignment.bottomCenter,
          touch: Touch.inside),
      AnimatedAlignPositioned(
          rotateDegrees: frame * 90.0,
          child: circle(Colors.green),
          alignment: Alignment.centerLeft,
          touch: Touch.inside),
      AnimatedAlignPositioned(
          rotateDegrees: frame * 90.0,
          child: circle(Colors.green),
          alignment: Alignment.topCenter,
          touch: Touch.inside),
      //
      AnimatedAlignPositioned(
          rotateDegrees: frame * 90.0,
          child: circle(Colors.blue),
          alignment: Alignment.topRight,
          touch: Touch.inside),
      AnimatedAlignPositioned(
          rotateDegrees: frame * 90.0,
          child: circle(Colors.blue),
          alignment: Alignment.bottomRight,
          touch: Touch.inside),
      AnimatedAlignPositioned(
          rotateDegrees: frame * 90.0,
          child: circle(Colors.blue),
          alignment: Alignment.topLeft,
          touch: Touch.inside),
      AnimatedAlignPositioned(
          rotateDegrees: frame * 90.0,
          child: circle(Colors.blue),
          alignment: Alignment.bottomLeft,
          touch: Touch.inside),
      //
      AnimatedAlignPositioned(
          rotateDegrees: frame * 90.0,
          child: circle(Colors.red),
          alignment: Alignment.centerRight,
          touch: Touch.outside),
      AnimatedAlignPositioned(
          rotateDegrees: frame * 90.0,
          child: circle(Colors.red),
          alignment: Alignment.bottomCenter,
          touch: Touch.outside),
      AnimatedAlignPositioned(
          rotateDegrees: frame * 90.0,
          child: circle(Colors.red),
          alignment: Alignment.centerLeft,
          touch: Touch.outside),
      AnimatedAlignPositioned(
          rotateDegrees: frame * 90.0,
          child: circle(Colors.red),
          alignment: Alignment.topCenter,
          touch: Touch.outside),
      //
      AnimatedAlignPositioned(
          rotateDegrees: frame * 90.0,
          child: circle(Colors.purple),
          alignment: Alignment.topRight,
          touch: Touch.outside),
      AnimatedAlignPositioned(
          rotateDegrees: frame * 90.0,
          child: circle(Colors.purple),
          alignment: Alignment.bottomRight,
          touch: Touch.outside),
      AnimatedAlignPositioned(
          rotateDegrees: frame * 90.0,
          child: circle(Colors.purple),
          alignment: Alignment.topLeft,
          touch: Touch.outside),
      AnimatedAlignPositioned(
          rotateDegrees: frame * 90.0,
          child: circle(Colors.purple),
          alignment: Alignment.bottomLeft,
          touch: Touch.outside),
    ];
  }

  AnimatedAlignPositioned alignPositionedCircle(
    double mult,
    Color color,
    int dirX,
    int dirY,
    Touch touch,
    double? dx,
    double? dy,
    double? moveByChildWidth,
    double? moveByChildHeight,
  ) {
    return AnimatedAlignPositioned(
        duration: Duration(seconds: 1),
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
