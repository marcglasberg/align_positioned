import 'package:align_positioned/align_positioned.dart';
import 'package:flutter/material.dart';

void main() async => runApp(MaterialApp(home: Demo()));

class Demo extends StatelessWidget {
  //
  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      appBar: AppBar(title: const Text('AnimaChain Example')),
      body: Container(
        color: Colors.grey,
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _animation(0),
              _animation(1),
              _animation(2),
              _animation(3),
              _animation(4),
              _animation(5),
              _animation(6),
            ],
          ),
        ),
      ),
    );
  }

  AnimChain _animation(int index) => AnimChain(
        repeat: true,
        initialDelay: Duration(milliseconds: 150 * index),
      )
          // 1) Display the yellow box and wait 700 milliseconds.
          .next(
            wait: Duration(milliseconds: 700),
            widget: Container(
              color: Colors.yellow,
              width: 95,
              height: 95,
              margin: const EdgeInsets.all(2.5),
            ),
          )
          // 2) Display the red text and wait 1000 milliseconds.
          .next(
            wait: Duration(milliseconds: 1000),
            widget: Container(
                child: Text("Hello world!", style: TextStyle(color: Colors.red, fontSize: 25)),
                width: 100,
                height: 100),
          )
          // 3) Display the blue icon and wait 1200 milliseconds.
          .next(
            wait: Duration(milliseconds: 1200),
            widget: Icon(Icons.accessibility, color: Colors.blue, size: 100),
          );
}
