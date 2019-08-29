import 'dart:async';

import 'package:flutter/material.dart';

// ////////////////////////////////////////////////////////////////////////////

class AnimChain extends StatefulWidget {
  // If repeats everything.
  final bool repeat;

  // Each widget.
  final List<Widget> widgets;
  final List<Duration> durations;

  AnimChain({this.repeat})
      : widgets = [],
        durations = [];

  AnimChain next({Widget widget, Duration wait}) {
    widgets.add(widget);
    durations.add(wait);
    return this;
  }

  @override
  _AnimChainState createState() => _AnimChainState();
}

// ////////////////////////////////////////////////////////////////////////////

class _AnimChainState extends State<AnimChain> {
  int count;

  @override
  void initState() {
    super.initState();
    count = 0;
    _next();
  }

  void _next() {
    var duration = widget.durations[count];

    if (duration == null)
      WidgetsBinding.instance.addPostFrameCallback((_) => _nextCount());
    else
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
