import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:matrix4_transform/matrix4_transform.dart';

// /////////////////////////////////////////////////////////////////////////////////////////////////

enum Touch { inside, outside }

enum Wins { min, max }

// /////////////////////////////////////////////////////////////////////////////////////////////////

// Developed by Marcelo Glasberg (feb 2019).

/// For more info, see: https://pub.dartlang.org/packages/align_positioned
class AlignPositioned extends SingleChildRenderObjectWidget {
  //
  final Alignment alignment;

  /// Position.
  final double dx,
      dy,
      moveByChildWidth,
      moveByChildHeight,
      moveByContainerWidth,
      moveByContainerHeight;

  /// You may define preferred child sizes, in absolute terms, or relative to the container size.
  /// If you define both, they will be added.
  final double childWidth, childHeight, childWidthRatio, childHeightRatio;

  /// You can also define min and max values, both in absolute and relative terms.
  /// If you define min sizes in both relative and absolute terms, both are applied.
  /// If you define max sizes in both relative and absolute terms, both are applied.
  ///
  /// The ratios, if defined, have priority over absolute sizes.
  /// Size (min/max, if defined, have priority over width/height):
  final double minChildWidth,
      minChildHeight,
      maxChildWidth,
      maxChildHeight,
      minChildWidthRatio,
      minChildHeightRatio,
      maxChildWidthRatio,
      maxChildHeightRatio;

  /// The rotation, in degrees (1 turn is 360 degrees).
  /// The position of the axis of the rotation (the "origin") depends on the
  /// `alignment` parameter and the parent. So, for example, `Alignment.center`
  /// means the axis of rotation is at the center of the parent.
  final double rotateDegrees;

  /// Some transformation to apply to the child.
  /// This uses Matrix4Transform instead of Matrix4, since it's easier to use.
  /// However, you can still use Matrix4 directly with the constructor
  /// `Matrix4Transform.from(matrix4)`.
  final Matrix4Transform matrix4Transform;

  /// If min/max sizes are incompatible, you may define which wins.
  final Wins wins;

  /// If `touch` is `Touch.inside`, then `alignment` works just like the
  /// alignment for the `Align` widget, aligning the child inside of the
  /// container. However, if `touch` is `Touch.outside`, then the alignment
  /// happens outside of the container.
  final Touch touch;

  const AlignPositioned({
    Key key,
    Widget child,
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
    this.rotateDegrees,
    this.matrix4Transform,
    this.wins = Wins.min,
    this.touch = Touch.inside,
  })  : assert(alignment != null),
        super(key: key, child: child);

  /// Use this if you put an [AlignPositioned] inside of a [Stack].
  /// The [AlignPositioned] will then expand and fix itself to the corners
  /// of the [Stack]. The [Stack] will size itself to their other
  /// non-positioned widgets, and then you can use the [AlignPositioned]
  /// to position its child in relation to the [Stack].
  ///
  /// Example:
  /// ```
  /// Stack(
  ///   children: [
  ///     AlignPositioned.expand(child:...),
  ///     ...
  ///     ]);
  /// ```
  ///
  /// Note the [Stack] documentation contains this text:
  /// ```
  /// In particular, when using a [Stack] you can't position
  /// children relative to their size or the stack's own size.
  /// ```
  ///
  /// However, using [AlignPositioned] like this will allow you precisely that:
  /// to position (and size) children relative to their size or the stack's own size.
  ///
  static Positioned expand({
    Key key,
    Widget child,
    Alignment alignment = Alignment.center,
    double dx = 0.0,
    double dy = 0.0,
    double moveByChildWidth = 0.0,
    double moveByChildHeight = 0.0,
    double moveByContainerWidth = 0.0,
    double moveByContainerHeight = 0.0,
    double childWidth,
    double childHeight,
    double minChildWidth,
    double minChildHeight,
    double maxChildWidth,
    double maxChildHeight,
    double childWidthRatio,
    double childHeightRatio,
    double minChildWidthRatio,
    double minChildHeightRatio,
    double maxChildWidthRatio,
    double maxChildHeightRatio,
    double rotateDegrees,
    Matrix4Transform matrix4Transform,
    Wins wins = Wins.min,
    Touch touch = Touch.inside,
  }) =>
      Positioned(
          top: 0,
          right: 0,
          left: 0,
          bottom: 0,
          child: AlignPositioned(
            child: child,
            alignment: alignment,
            dx: dx,
            dy: dy,
            moveByChildWidth: moveByChildWidth,
            moveByChildHeight: moveByChildHeight,
            moveByContainerWidth: moveByContainerWidth,
            moveByContainerHeight: moveByContainerHeight,
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
            rotateDegrees: rotateDegrees,
            matrix4Transform: matrix4Transform,
            wins: wins,
            touch: touch,
          ));

  /// Use this if you have a main widget, and you want to
  /// position/size/rotate/translate another widget relative
  /// to the main one, but the second is NOT a child of the first.
  ///
  /// Example, to center the main widget, and then put the
  /// relative widget below it:
  ///
  /// ```
  /// Center(
  ///    child: AlignPositioned.relative(
  ///        widgetA(),
  ///        widgetB(),
  ///        moveByContainerHeight: 0.5,
  ///        moveByChildHeight: 0.5));
  /// ```
  ///
  static Widget relative(
    Widget main,
    Widget relative, {
    Key key,
    Widget child,
    Alignment alignment = Alignment.center,
    double dx = 0.0,
    double dy = 0.0,
    double moveByChildWidth = 0.0,
    double moveByChildHeight = 0.0,
    double moveByContainerWidth = 0.0,
    double moveByContainerHeight = 0.0,
    double childWidth,
    double childHeight,
    double minChildWidth,
    double minChildHeight,
    double maxChildWidth,
    double maxChildHeight,
    double childWidthRatio,
    double childHeightRatio,
    double minChildWidthRatio,
    double minChildHeightRatio,
    double maxChildWidthRatio,
    double maxChildHeightRatio,
    double rotateDegrees,
    Matrix4Transform matrix4Transform,
    Wins wins = Wins.min,
    Touch touch = Touch.inside,
  }) {
    return Stack(children: [
      main,
      AlignPositioned.expand(
        child: relative,
        alignment: alignment,
        dx: dx,
        dy: dy,
        moveByChildWidth: moveByChildWidth,
        moveByChildHeight: moveByChildHeight,
        moveByContainerWidth: moveByContainerWidth,
        moveByContainerHeight: moveByContainerHeight,
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
        rotateDegrees: rotateDegrees,
        matrix4Transform: matrix4Transform,
        wins: wins,
        touch: touch,
      ),
    ]);
  }

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
      rotateDegrees: rotateDegrees,
      matrix4Transform: matrix4Transform,
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
      ..rotateDegrees = rotateDegrees
      ..matrix4Transform = matrix4Transform
      ..wins = wins
      ..touch = touch;
  }
}

// /////////////////////////////////////////////////////////////////////////////////////////////////

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
    @required double rotateDegrees,
    @required Matrix4Transform matrix4Transform,
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
        _rotateDegrees = rotateDegrees,
        _matrix4Transform = matrix4Transform,
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
  double _rotateDegrees;
  Matrix4Transform _matrix4Transform;
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

  double get rotateDegrees => _rotateDegrees;

  Matrix4Transform get matrix4Transform => _matrix4Transform;

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

  set rotateDegrees(double value) {
    if (_rotateDegrees == value) return;
    _rotateDegrees = value;
    markNeedsLayout();
  }

  set matrix4Transform(Matrix4Transform value) {
    if (_matrix4Transform == value) return;
    _matrix4Transform = value;
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
    assert(wins != null);
    // ---

    double min, max;

    // If size is not defined, calculate the size form the sizeRatio.
    // If both size and sizeRation are defined, calculate the sizeRatio and then sum the size.
    if (sizeRatio != null) {
      if (size != null)
        size = sizeRatio * available + size;
      else
        size = sizeRatio * available;
    }

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

    // 4) Adds moveByContainerWidth and moveByContainerHeight.
    childParentData.offset += Offset(
      size.width * moveByContainerWidth,
      size.height * moveByContainerHeight,
    );
  }

  Offset _toOffset(Size size) => Offset(size.width, size.height);

  @override
  bool hitTestChildren(BoxHitTestResult result, {Offset position}) {
    assert(!transformHitTests || _effectiveTransform != null);
    return result.addWithPaintTransform(
      transform: transformHitTests ? _effectiveTransform : null,
      position: position,
      hitTest: (BoxHitTestResult result, Offset position) {
        return super.hitTestChildren(result, position: position);
      },
    );
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child != null) {
      final Matrix4 transform = _effectiveTransform;
      final Offset childOffset = MatrixUtils.getAsTranslation(transform);
      if (childOffset == null)
        context.pushTransform(needsCompositing, offset, transform, super.paint);
      else
        super.paint(context, offset + childOffset);
    }
  }

  /// When set to true, hit tests are performed based on the position of the
  /// child as it is painted. When set to false, hit tests are performed
  /// ignoring the transformation.
  ///
  /// applyPaintTransform(), and therefore localToGlobal() and globalToLocal(),
  /// always honor the transformation, regardless of the value of this property.
  bool transformHitTests = true;

  Matrix4 get _effectiveTransform {
    final Alignment resolvedAlignment = alignment;
    if (_origin == null && resolvedAlignment == null) return transform;
    final Matrix4 result = Matrix4.identity();
    if (_origin != null) result.translate(_origin.dx, _origin.dy);
    Offset translation;
    if (resolvedAlignment != null) {
      translation = resolvedAlignment.alongSize(size);
      result.translate(translation.dx, translation.dy);
    }
    result.multiply(transform);
    if (resolvedAlignment != null) result.translate(-translation.dx, -translation.dy);
    if (_origin != null) result.translate(-_origin.dx, -_origin.dy);
    return result;
  }

  /// The origin of the coordinate system (relative to the upper left corner of
  /// this render object) in which to apply the matrix.
  ///
  /// Setting an origin is equivalent to conjugating the transform matrix by a
  /// translation. This property is provided just for convenience.
  Offset get origin => _origin;
  Offset _origin;

  set origin(Offset value) {
    if (_origin == value) return;
    _origin = value;
    markNeedsPaint();
    markNeedsSemanticsUpdate();
  }

  Matrix4 get transform {
    Matrix4 matrix4;

    if (_rotateDegrees == null || _rotateDegrees == 0)
      matrix4 = Matrix4.identity();
    else
      matrix4 = Matrix4Transform().rotateDegrees(_rotateDegrees).matrix4;

    if (matrix4Transform != null) matrix4 = matrix4.multiplied(matrix4Transform.matrix4);

    return matrix4;
  }
}

// /////////////////////////////////////////////////////////////////////////////////////////////////
