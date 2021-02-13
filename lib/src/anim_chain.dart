import 'dart:async';
import 'package:flutter/material.dart';

// ////////////////////////////////////////////////////////////////////////////

/// [AnimChain] lets you define a sequence of widgets, where each one will be
/// displayed after the previous. You can chain widgets which are totally
/// different from one another. However, if you define implicitly animated
/// widgets (like AnimatedAlignPositioned, AnimatedContainer, AnimatedOpacity
/// etc) you can create an animation.
///
/// Example:
///
///     return AnimChain(repeat: true, initialDelay: Duration(milliseconds: 150))
///        // Show the yellow box and wait 5 seconds.
///        .next(
///           wait: Duration(seconds: 5),
///           widget: AnimatedAlignPositioned(
///              alignment: Alignment.bottomCenter,
///              rotateDegrees: 0,
///              child: Container(color: Colors.yellow),
///              ),
///           )
///        // Rotate to the red box in 3 seconds.
///        .next(
///           wait: Duration(seconds: 3),
///           widget: AnimatedAlignPositioned(
///              duration: Duration(seconds: 3),
///              rotateDegrees: 180,
///              child: Container(color: Colors.red),
///              ),
///           )
///        // Finally, translate the blue in the vertical axis.
///        .next(
///           widget: AnimatedAlignPositioned(
///              duration: Duration(seconds: 15),
///              alignment: Alignment.bottomCenter,
///              dy: 150,
///              rotateDegrees: 180,
///              child: Container(color: Colors.blue),
///              ),
///           ),
///         );
class AnimChain extends StatefulWidget {
  //

  /// if [repeat] is true, the animation chain will be repeated as soon as it
  /// ends. Otherwise, it will play only once.
  final bool repeat;

  /// [initialDelay] is the initial delay before starting the animation chain.
  /// It's only applied at first, when the widget is put in the screen. It
  /// will not be repeated when [repeat] is true. For this reason, it is
  /// different from the delay you can apply when you use the [wait] parameter
  /// of the [next] method, which is repeated.
  final Duration? initialDelay;

  // Each widget.
  final List<Widget> widgets;
  final List<Duration> durations;

  AnimChain({
    Key? key,
    this.repeat = false,
    this.initialDelay,
  })  : widgets = [],
        durations = [],
        super(key: key);

  /// Define the next [widget] in the chain. The [wait] parameter specifies for
  /// how long it should be displayed.
  AnimChain next({
    required Widget widget,
    Duration wait = const Duration(),
  }) {
    widgets.add(widget);
    durations.add(wait);
    return this;
  }

  @override
  _AnimChainState createState() => _AnimChainState();
}

// ////////////////////////////////////////////////////////////////////////////

class _AnimChainState extends State<AnimChain> {
  late int count;
  late bool applyInitialDelay;

  @override
  void initState() {
    super.initState();
    count = 0;
    applyInitialDelay = true;
    _next();
  }

  void _next() {
    var duration = widget.durations[count];

    if (applyInitialDelay && widget.initialDelay != null) {
      applyInitialDelay = false;
      duration += widget.initialDelay!;
    }

    Timer(duration, _nextCount);
  }

  void _nextCount() {
    if (mounted && widget.widgets.length > 1)
      setState(() {
        if (count < widget.widgets.length - 1) {
          count++;
        } else if (widget.repeat) {
          count = 0;
        }
        _next();
      });
  }

  @override
  Widget build(BuildContext context) {
    return widget.widgets[count];
  }
}

// ////////////////////////////////////////////////////////////////////////////
