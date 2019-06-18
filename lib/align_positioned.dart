library align_positioned;

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

////////////////////////////////////////////////////////////////////////////////////////////////////

enum Touch { inside, outside }

enum Wins { min, max }

////////////////////////////////////////////////////////////////////////////////////////////////////

class AlignPositioned extends SingleChildRenderObjectWidget {
  //
  final Alignment alignment;

  // Position:
  final double dx, dy;
  final double moveByChildWidth, moveByChildHeight;
  final double moveByContainerWidth, moveByContainerHeight;

  // You may define preferred child sizes, in absolute terms, or relative to the container size.
  // It's an error to define preferred sizes in both absolute and relative terms at the same time.
  final double childWidth, childHeight;
  final double childWidthRatio, childHeightRatio;

  // You can also define min and max values, both in absolute and relative terms.
  // If you define min sizes in both relative and absolute terms, both are applied.
  // If you define max sizes in both relative and absolute terms, both are applied.
  //
  // sIf min sizes are defined The ratios, if defined, have priority over absolute sizes.
  // Size (min/max, if defined, have priority over width/height):
  final double minChildWidth, minChildHeight;
  final double maxChildWidth, maxChildHeight;
  final double minChildWidthRatio, minChildHeightRatio;
  final double maxChildWidthRatio, maxChildHeightRatio;

  // If min/max sizes are incompatible, you may define which wins.
  final Wins wins;

  final Touch touch;

  const AlignPositioned({
    Key key,
    this.alignment = Alignment.center,
    this.dx = 0.0,
    this.dy = 0.0,
    this.moveByChildWidth = 0.0,
    this.moveByChildHeight = 0.0,
    this.moveByContainerWidth = 0.0,
    this.moveByContainerHeight = 0.0,
    this.childWidth,
    this.childHeight,
    this.minChildWidth,
    this.minChildHeight,
    this.maxChildWidth,
    this.maxChildHeight,
    this.childWidthRatio,
    this.childHeightRatio,
    this.minChildWidthRatio,
    this.minChildHeightRatio,
    this.maxChildWidthRatio,
    this.maxChildHeightRatio,
    this.wins = Wins.min,
    this.touch = Touch.inside,
    Widget child,
  })  : assert(alignment != null),
        assert(childWidth == null || childWidthRatio == null),
        assert(childHeight == null || childHeightRatio == null),
        super(key: key, child: child);

  @override
  _RenderAlignPositionedBox createRenderObject(BuildContext context) {
    return _RenderAlignPositionedBox(
      alignment: alignment,
      dx: dx ?? 0.0,
      dy: dy ?? 0.0,
      moveByChildWidth: moveByChildWidth ?? 0.0,
      moveByChildHeight: moveByChildHeight ?? 0.0,
      moveByContainerWidth: moveByContainerWidth ?? 0.0,
      moveByContainerHeight: moveByContainerHeight ?? 0.0,
      touch: touch,
      childWidth: childWidth,
      childHeight: childHeight,
      minChildWidth: minChildWidth,
      minChildHeight: minChildHeight,
      maxChildWidth: maxChildWidth,
      maxChildHeight: maxChildHeight,
      childWidthRatio: childWidthRatio,
      childHeightRatio: childHeightRatio,
      minChildWidthRatio: minChildWidthRatio,
      minChildHeightRatio: minChildHeightRatio,
      maxChildWidthRatio: maxChildWidthRatio,
      maxChildHeightRatio: maxChildHeightRatio,
      wins: wins,
      textDirection: Directionality.of(context),
    );
  }

  @override
  void updateRenderObject(BuildContext context, _RenderAlignPositionedBox renderObject) {
    renderObject
      ..alignment = alignment
      ..dx = dx ?? 0.0
      ..dy = dy ?? 0.0
      ..moveByChildWidth = moveByChildWidth ?? 0.0
      ..moveByChildHeight = moveByChildHeight ?? 0.0
      ..moveByContainerWidth = moveByContainerWidth ?? 0.0
      ..moveByContainerHeight = moveByContainerHeight ?? 0.0
      ..childWidth = childWidth
      ..childHeight = childHeight
      ..minChildWidth = minChildWidth
      ..minChildHeight = minChildHeight
      ..maxChildWidth = maxChildWidth
      ..maxChildHeight = maxChildHeight
      ..childWidthRatio = childWidthRatio
      ..childHeightRatio = childHeightRatio
      ..minChildWidthRatio = minChildWidthRatio
      ..minChildHeightRatio = minChildHeightRatio
      ..maxChildWidthRatio = maxChildWidthRatio
      ..maxChildHeightRatio = maxChildHeightRatio
      ..wins = wins
      ..touch = touch;
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////

class _RenderAlignPositionedBox extends RenderShiftedBox {
  //
  _RenderAlignPositionedBox({
    RenderBox child,
    @required double dx,
    @required double dy,
    @required double moveByChildWidth,
    @required double moveByChildHeight,
    @required double moveByContainerWidth,
    @required double moveByContainerHeight,
    @required double childWidth,
    @required double childHeight,
    @required double minChildWidth,
    @required double minChildHeight,
    @required double maxChildWidth,
    @required double maxChildHeight,
    @required double childWidthRatio,
    @required double childHeightRatio,
    @required double minChildWidthRatio,
    @required double minChildHeightRatio,
    @required double maxChildWidthRatio,
    @required double maxChildHeightRatio,
    @required Wins wins,
    @required Touch touch,
    Alignment alignment = Alignment.center,
    TextDirection textDirection,
  })  : assert(dx != null),
        assert(dy != null),
        assert(touch != null),
        _dx = dx,
        _dy = dy,
        _moveByChildWidth = moveByChildWidth,
        _moveByChildHeight = moveByChildHeight,
        _moveByContainerWidth = moveByContainerWidth,
        _moveByContainerHeight = moveByContainerHeight,
        _alignment = alignment,
        _childWidth = childWidth,
        _childHeight = childHeight,
        _minChildWidth = minChildWidth,
        _minChildHeight = minChildHeight,
        _maxChildWidth = maxChildWidth,
        _maxChildHeight = maxChildHeight,
        _childWidthRatio = childWidthRatio,
        _childHeightRatio = childHeightRatio,
        _minChildWidthRatio = minChildWidthRatio,
        _minChildHeightRatio = minChildHeightRatio,
        _maxChildWidthRatio = maxChildWidthRatio,
        _maxChildHeightRatio = maxChildHeightRatio,
        _wins = wins,
        _touch = touch,
        super(child);

  double _childWidth;
  double _childHeight;
  double _minChildWidth;
  double _minChildHeight;
  double _maxChildWidth;
  double _maxChildHeight;
  double _childWidthRatio;
  double _childHeightRatio;
  double _minChildWidthRatio;
  double _minChildHeightRatio;
  double _maxChildWidthRatio;
  double _maxChildHeightRatio;
  Wins _wins;

  double get childWidth => _childWidth;

  double get childHeight => _childHeight;

  double get minChildWidth => _minChildWidth;

  double get minChildHeight => _minChildHeight;

  double get maxChildWidth => _maxChildWidth;

  double get maxChildHeight => _maxChildHeight;

  double get childWidthRatio => _childWidthRatio;

  double get childHeightRatio => _childHeightRatio;

  double get minChildWidthRatio => _minChildWidthRatio;

  double get minChildHeightRatio => _minChildHeightRatio;

  double get maxChildWidthRatio => _maxChildWidthRatio;

  double get maxChildHeightRatio => _maxChildHeightRatio;

  Wins get wins => _wins;

  set childWidth(double value) {
    if (_childWidth == value) return;
    _childWidth = value;
    markNeedsLayout();
  }

  set childHeight(double value) {
    if (_childHeight == value) return;
    _childHeight = value;
    markNeedsLayout();
  }

  set minChildWidth(double value) {
    if (_minChildWidth == value) return;
    _minChildWidth = value;
    markNeedsLayout();
  }

  set minChildHeight(double value) {
    if (_minChildHeight == value) return;
    _minChildHeight = value;
    markNeedsLayout();
  }

  set maxChildWidth(double value) {
    if (_maxChildWidth == value) return;
    _maxChildWidth = value;
    markNeedsLayout();
  }

  set maxChildHeight(double value) {
    if (_maxChildHeight == value) return;
    _maxChildHeight = value;
    markNeedsLayout();
  }

  set childWidthRatio(double value) {
    if (_childWidthRatio == value) return;
    _childWidthRatio = value;
    markNeedsLayout();
  }

  set childHeightRatio(double value) {
    if (_childHeightRatio == value) return;
    _childHeightRatio = value;
    markNeedsLayout();
  }

  set minChildWidthRatio(double value) {
    if (_minChildWidthRatio == value) return;
    _minChildWidthRatio = value;
    markNeedsLayout();
  }

  set minChildHeightRatio(double value) {
    if (_minChildHeightRatio == value) return;
    _minChildHeightRatio = value;
    markNeedsLayout();
  }

  set maxChildWidthRatio(double value) {
    if (_maxChildWidthRatio == value) return;
    _maxChildWidthRatio = value;
    markNeedsLayout();
  }

  set maxChildHeightRatio(double value) {
    if (_maxChildHeightRatio == value) return;
    _maxChildHeightRatio = value;
    markNeedsLayout();
  }

  set wins(Wins value) {
    assert(value != null);
    if (_wins == value) return;
    _wins = value;
    markNeedsLayout();
  }

  bool get definesChildSize =>
      childWidth != null ||
      childHeight != null ||
      minChildWidth != null ||
      minChildHeight != null ||
      maxChildWidth != null ||
      maxChildHeight != null ||
      childWidthRatio != null ||
      childHeightRatio != null ||
      minChildWidthRatio != null ||
      minChildHeightRatio != null ||
      maxChildWidthRatio != null ||
      maxChildHeightRatio != null;

  // ---

  Alignment get alignment => _alignment;
  Alignment _alignment;

  set alignment(Alignment value) {
    assert(value != null);
    if (_alignment == value) return;
    _alignment = value;
    markNeedsLayout();
  }

  // ---

  Touch get touch => _touch;
  Touch _touch;

  set touch(Touch value) {
    assert(value != null);
    if (_touch == value) return;
    _touch = value;
    markNeedsLayout();
  }

  // ---

  double get moveByChildWidth => _moveByChildWidth;
  double _moveByChildWidth;

  set moveByChildWidth(double value) {
    assert(value != null);
    if (_moveByChildWidth == value) return;
    _moveByChildWidth = value;
    markNeedsLayout();
  }

  // ---

  double get moveByChildHeight => _moveByChildHeight;
  double _moveByChildHeight;

  set moveByChildHeight(double value) {
    assert(value != null);
    if (_moveByChildHeight == value) return;
    _moveByChildHeight = value;
    markNeedsLayout();
  }

  // ---

  double get moveByContainerWidth => _moveByContainerWidth;
  double _moveByContainerWidth;

  set moveByContainerWidth(double value) {
    assert(value != null);
    if (_moveByContainerWidth == value) return;
    _moveByContainerWidth = value;
    markNeedsLayout();
  }

  // ---

  double get moveByContainerHeight => _moveByContainerHeight;
  double _moveByContainerHeight;

  set moveByContainerHeight(double value) {
    assert(value != null);
    if (_moveByContainerHeight == value) return;
    _moveByContainerHeight = value;
    markNeedsLayout();
  }

  // ---

  double get dx => _dx;
  double _dx;

  set dx(double value) {
    assert(value != null);
    if (_dx == value) return;
    _dx = value;
    markNeedsLayout();
  }

  // ---

  double get dy => _dy;
  double _dy;

  set dy(double value) {
    assert(value != null);
    if (_dy == value) return;
    _dy = value;
    markNeedsLayout();
  }

  // ---

  BoxConstraints _getInnerConstraints(BoxConstraints constraints) {
    //
    // Ignores minWidth and minHeight.
    var availableWidth = constraints.maxWidth;
    var availableHeight = constraints.maxHeight;

    List<double> minMaxWidth = calculateConstraints(
        available: availableWidth,
        size: childWidth,
        sizeRatio: childWidthRatio,
        minAbsolute: minChildWidth,
        maxAbsolute: maxChildWidth,
        minRatio: minChildWidthRatio,
        maxRatio: maxChildWidthRatio,
        wins: wins);

    List<double> minMaxHeight = calculateConstraints(
        available: availableHeight,
        size: childHeight,
        sizeRatio: childHeightRatio,
        minAbsolute: minChildHeight,
        maxAbsolute: maxChildHeight,
        minRatio: minChildHeightRatio,
        maxRatio: maxChildHeightRatio,
        wins: wins);

    var minWidth = minMaxWidth[0];
    var maxWidth = minMaxWidth[1];

    var minHeight = minMaxHeight[0];
    var maxHeight = minMaxHeight[1];

    return BoxConstraints(
        minWidth: minWidth, maxWidth: maxWidth, minHeight: minHeight, maxHeight: maxHeight);
  }

  List<double> calculateConstraints({
    double available,
    double size,
    double sizeRatio,
    double minAbsolute,
    double maxAbsolute,
    double minRatio,
    double maxRatio,
    @required Wins wins,
  }) {
    assert(size == null || sizeRatio == null);
    assert(wins != null);
    // ---

    double min, max;

    if (sizeRatio != null) size = sizeRatio * available;

    min = maxN(minAbsolute, times(minRatio, available));
    max = minN(maxAbsolute, times(maxRatio, available));

    // Has size, applies min/max and returns exact.
    if (size != null) {
      size = clip(minValue: min, value: size, maxValue: max, wins: wins);
      return [size, size];
    }

    // Has no size, returns min/max.
    else {
      min ??= 0.0;
      max ??= double.infinity;

      if (min > max) {
        if (wins == Wins.min)
          max = min;
        else if (wins == Wins.max)
          min = max;
        else
          throw AssertionError();
      }

      return [min, max];
    }
  }

  /// If any is null, returns null.
  double times(double a, double b) {
    if (a == null)
      return null;
    else if (b == null) return null;
    return a * b;
  }

  /// If any is null, returns the other.
  double minN(double a, double b) {
    if (a == null)
      return b;
    else if (b == null) return a;
    return min(a, b);
  }

  /// If any is null, returns the other.
  double maxN(double a, double b) {
    if (a == null)
      return b;
    else if (b == null) return a;
    return max(a, b);
  }

  /// If value is null, returns null.
  /// If minValue is null, ignores.
  /// If maxValue is null, ignores.
  double clip({
    @required double minValue,
    @required double value,
    @required double maxValue,
    @required Wins wins,
  }) {
    if (value == null)
      return null;
    else if (wins == Wins.min)
      return maxN(minN(value, maxValue), minValue);
    else if (wins == Wins.max)
      return minN(maxN(value, minValue), maxValue);
    else
      throw AssertionError();
  }

  @override
  void performLayout() {
    //
    if (definesChildSize) {
      if (child != null) {
        child.layout(_getInnerConstraints(constraints), parentUsesSize: true);
        size = constraints.constrain(const Size(double.infinity, double.infinity));
        alignChild();
      } else {
        size = constraints.constrain(const Size(double.infinity, double.infinity));
      }
    }
    //
    else {
      if (child != null) {
        child.layout(constraints.loosen(), parentUsesSize: true);
        size = constraints.constrain(const Size(double.infinity, double.infinity));
        alignChild();
      } else {
        size = constraints.constrain(const Size(double.infinity, double.infinity));
      }
    }
  }

  @protected
  void alignChild() {
    assert(child != null);
    assert(!child.debugNeedsLayout);
    assert(child.hasSize);
    assert(hasSize);
    // ---

    final BoxParentData childParentData = child.parentData;
    final Offset containerSize = _toOffset(size);
    final Offset childSize = _toOffset(child.size);

    // 1) Adds touch and alignment.
    if (_touch == Touch.inside)
      childParentData.offset = alignment.alongOffset(containerSize - childSize);
    //
    else if (_touch == Touch.outside)
      childParentData.offset = alignment.alongOffset(containerSize + childSize) - childSize;
    //
    else
      throw AssertionError();

    // 2) Adds dx and dy.
    childParentData.offset += Offset(dx, dy);

    // 3) Adds moveByChildWidth and moveByChildHeight.
    childParentData.offset += Offset(
      child.size.width * moveByChildWidth,
      child.size.height * moveByChildHeight,
    );

    // 3) Adds moveByContainerWidth and moveByContainerHeight.
    childParentData.offset += Offset(
      size.width * moveByContainerWidth,
      size.height * moveByContainerHeight,
    );
  }

  Offset _toOffset(Size size) => Offset(size.width, size.height);
}

////////////////////////////////////////////////////////////////////////////////////////////////////
