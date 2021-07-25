import 'package:align_positioned/align_positioned.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:matrix4_transform/matrix4_transform.dart';

// ////////////////////////////////////////////////////////////////////////////

// Developed by Marcelo Glasberg (feb 2019).

/// For more info, see: https://pub.dartlang.org/packages/align_positioned
class AnimatedAlignPositioned extends ImplicitlyAnimatedWidget {
  //
  final Alignment alignment;

  /// Position.
  final double dx,
      dy,
      moveByChildWidth,
      moveByChildHeight,
      moveByContainerWidth,
      moveByContainerHeight;

  /// Position moving orthogonally.
  final double moveVerticallyByChildWidth,
      moveHorizontallyByChildHeight,
      moveVerticallyByContainerWidth,
      moveHorizontallyByContainerHeight;

  /// You may define preferred child sizes, in absolute terms, or relative to the container size.
  /// If you define both, they will be added.
  final double? childWidth, childHeight, childWidthRatio, childHeightRatio;

  /// You can also define min and max values, both in absolute and relative terms.
  /// If you define min sizes in both relative and absolute terms, both are applied.
  /// If you define max sizes in both relative and absolute terms, both are applied.
  ///
  /// The ratios, if defined, have priority over absolute sizes.
  /// Size (min/max, if defined, have priority over width/height):
  final double? minChildWidth,
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
  final double? rotateDegrees;

  /// Some transformation to apply to the child.
  /// This uses Matrix4Transform instead of Matrix4, since it's easier to use.
  /// However, you can still use Matrix4 directly with the constructor
  /// `Matrix4Transform.from(matrix4)`.
  final Matrix4Transform? matrix4Transform;

  /// If min/max sizes are incompatible, you may define which wins.
  final Wins wins;

  /// If `touch` is `Touch.inside`, then `alignment` works just like the
  /// alignment for the `Align` widget, aligning the child inside of the
  /// container. However, if `touch` is `Touch.outside`, then the alignment
  /// happens outside of the container.
  final Touch touch;

  final Widget? child;

  const AnimatedAlignPositioned({
    Key? key,
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
    this.child,
    Alignment? alignment,
    double? dx,
    double? dy,
    double? moveByChildWidth,
    double? moveByChildHeight,
    double? moveByContainerWidth,
    double? moveByContainerHeight,
    double? moveVerticallyByChildWidth,
    double? moveHorizontallyByChildHeight,
    double? moveVerticallyByContainerWidth,
    double? moveHorizontallyByContainerHeight,
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
  })  : alignment = alignment ?? Alignment.center,
        dx = dx ?? 0.0,
        dy = dy ?? 0.0,
        moveByChildWidth = moveByChildWidth ?? 0.0,
        moveByChildHeight = moveByChildHeight ?? 0.0,
        moveByContainerWidth = moveByContainerWidth ?? 0.0,
        moveByContainerHeight = moveByContainerHeight ?? 0.0,
        moveVerticallyByChildWidth = moveVerticallyByChildWidth ?? 0.0,
        moveHorizontallyByChildHeight = moveHorizontallyByChildHeight ?? 0.0,
        moveVerticallyByContainerWidth = moveVerticallyByContainerWidth ?? 0.0,
        moveHorizontallyByContainerHeight = moveHorizontallyByContainerHeight ?? 0.0,
        super(
          key: key,
          duration: duration,
          curve: curve,
        );

  /// Use this if you put an [AnimatedAlignPositioned] inside of a [Stack].
  /// The [AnimatedAlignPositioned] will then expand and fix itself to the corners
  /// of the [Stack]. The [Stack] will size itself to their other
  /// non-positioned widgets, and then you can use the [AnimatedAlignPositioned]
  /// to position its child in relation to the [Stack].
  ///
  /// Example:
  /// ```
  /// Stack(
  ///   children: [
  ///     AnimatedAlignPositioned.expand(child:...),
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
  /// However, using [AnimatedAlignPositioned] like this will allow you precisely that:
  /// to position (and size) children relative to their size or the stack's own size.
  ///
  static Positioned expand({
    Key? key,
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
    Widget? child,
    Alignment? alignment,
    double? dx,
    double? dy,
    double? moveByChildWidth,
    double? moveByChildHeight,
    double? moveByContainerWidth,
    double? moveByContainerHeight,
    double? moveVerticallyByChildWidth,
    double? moveHorizontallyByChildHeight,
    double? moveVerticallyByContainerWidth,
    double? moveHorizontallyByContainerHeight,
    double? childWidth,
    double? childHeight,
    double? minChildWidth,
    double? minChildHeight,
    double? maxChildWidth,
    double? maxChildHeight,
    double? childWidthRatio,
    double? childHeightRatio,
    double? minChildWidthRatio,
    double? minChildHeightRatio,
    double? maxChildWidthRatio,
    double? maxChildHeightRatio,
    double? rotateDegrees,
    Matrix4Transform? matrix4Transform,
    Wins wins = Wins.min,
    Touch touch = Touch.inside,
  }) =>
      Positioned(
          top: 0,
          right: 0,
          left: 0,
          bottom: 0,
          child: AnimatedAlignPositioned(
            duration: duration,
            curve: curve,
            child: child,
            alignment: alignment,
            dx: dx,
            dy: dy,
            moveByChildWidth: moveByChildWidth,
            moveByChildHeight: moveByChildHeight,
            moveByContainerWidth: moveByContainerWidth,
            moveByContainerHeight: moveByContainerHeight,
            moveVerticallyByChildWidth: moveVerticallyByChildWidth,
            moveHorizontallyByChildHeight: moveHorizontallyByChildHeight,
            moveVerticallyByContainerWidth: moveVerticallyByContainerWidth,
            moveHorizontallyByContainerHeight: moveHorizontallyByContainerHeight,
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

  @override
  _AnimatedAlignPositionedState createState() => //
      _AnimatedAlignPositionedState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      DiagnosticsProperty<double>(
        'dx',
        dx,
        showName: false,
        defaultValue: null,
      ),
    );
    properties.add(
      DiagnosticsProperty<double>(
        'dy',
        dy,
        showName: false,
        defaultValue: null,
      ),
    );
  }
}

// ////////////////////////////////////////////////////////////////////////////

class _AnimatedAlignPositionedState //
    extends AnimatedWidgetBaseState<AnimatedAlignPositioned> {
  AlignmentTween? _alignment;
  _TweenThatAcceptsNulls<double?>? _dx;
  _TweenThatAcceptsNulls<double?>? _dy;
  _TweenThatAcceptsNulls<double?>? _moveByChildWidth;
  _TweenThatAcceptsNulls<double?>? _moveByChildHeight;
  _TweenThatAcceptsNulls<double?>? _moveByContainerWidth;
  _TweenThatAcceptsNulls<double?>? _moveByContainerHeight;
  _TweenThatAcceptsNulls<double?>? _moveVerticallyByChildWidth;
  _TweenThatAcceptsNulls<double?>? _moveHorizontallyByChildHeight;
  _TweenThatAcceptsNulls<double?>? _moveVerticallyByContainerWidth;
  _TweenThatAcceptsNulls<double?>? _moveHorizontallyByContainerHeight;
  _TweenThatAcceptsNulls<double?>? _childWidth;
  _TweenThatAcceptsNulls<double?>? _childHeight;
  _TweenThatAcceptsNulls<double?>? _minChildWidth;
  _TweenThatAcceptsNulls<double?>? _minChildHeight;
  _TweenThatAcceptsNulls<double?>? _maxChildWidth;
  _TweenThatAcceptsNulls<double?>? _maxChildHeight;
  _TweenThatAcceptsNulls<double?>? _childWidthRatio;
  _TweenThatAcceptsNulls<double?>? _childHeightRatio;
  _TweenThatAcceptsNulls<double?>? _minChildWidthRatio;
  _TweenThatAcceptsNulls<double?>? _minChildHeightRatio;
  _TweenThatAcceptsNulls<double?>? _maxChildWidthRatio;
  _TweenThatAcceptsNulls<double?>? _maxChildHeightRatio;
  _TweenThatAcceptsNulls<double?>? _rotateDegrees;
  Matrix4TransformTween? _matrix4Transform;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _alignment = visitor(
      _alignment,
      widget.alignment,
      (dynamic value) => AlignmentTween(begin: value ?? Alignment.center),
    ) as AlignmentTween?;
    _dx = visitor(
      _dx,
      widget.dx,
      (dynamic value) => _TweenThatAcceptsNulls<double>(begin: value ?? 0.0),
    ) as _TweenThatAcceptsNulls<double?>?;
    _dy = visitor(
      _dy,
      widget.dy,
      (dynamic value) => _TweenThatAcceptsNulls<double>(begin: value ?? 0.0),
    ) as _TweenThatAcceptsNulls<double?>?;
    _moveByChildWidth = visitor(
      _moveByChildWidth,
      widget.moveByChildWidth,
      (dynamic value) => _TweenThatAcceptsNulls<double>(begin: value ?? 0.0),
    ) as _TweenThatAcceptsNulls<double?>?;
    _moveByChildHeight = visitor(
      _moveByChildHeight,
      widget.moveByChildHeight,
      (dynamic value) => _TweenThatAcceptsNulls<double>(begin: value ?? 0.0),
    ) as _TweenThatAcceptsNulls<double?>?;
    _moveByContainerWidth = visitor(
      _moveByContainerWidth,
      widget.moveByContainerWidth,
      (dynamic value) => _TweenThatAcceptsNulls<double>(begin: value ?? 0.0),
    ) as _TweenThatAcceptsNulls<double?>?;
    _moveByContainerHeight = visitor(
      _moveByContainerHeight,
      widget.moveByContainerHeight,
      (dynamic value) => _TweenThatAcceptsNulls<double>(begin: value ?? 0.0),
    ) as _TweenThatAcceptsNulls<double?>?;
    _moveVerticallyByChildWidth = visitor(
      _moveVerticallyByChildWidth,
      widget.moveVerticallyByChildWidth,
      (dynamic value) => _TweenThatAcceptsNulls<double>(begin: value ?? 0.0),
    ) as _TweenThatAcceptsNulls<double?>?;
    _moveHorizontallyByChildHeight = visitor(
      _moveHorizontallyByChildHeight,
      widget.moveHorizontallyByChildHeight,
      (dynamic value) => _TweenThatAcceptsNulls<double>(begin: value ?? 0.0),
    ) as _TweenThatAcceptsNulls<double?>?;
    _moveVerticallyByContainerWidth = visitor(
      _moveVerticallyByContainerWidth,
      widget.moveVerticallyByContainerWidth,
      (dynamic value) => _TweenThatAcceptsNulls<double>(begin: value ?? 0.0),
    ) as _TweenThatAcceptsNulls<double?>?;
    _moveHorizontallyByContainerHeight = visitor(
      _moveHorizontallyByContainerHeight,
      widget.moveHorizontallyByContainerHeight,
      (dynamic value) => _TweenThatAcceptsNulls<double>(begin: value ?? 0.0),
    ) as _TweenThatAcceptsNulls<double?>?;
    _childWidth = visitor(
      _childWidth,
      widget.childWidth,
      (dynamic value) => _TweenThatAcceptsNulls<double>(begin: value),
    ) as _TweenThatAcceptsNulls<double?>?;
    _childHeight = visitor(
      _childHeight,
      widget.childHeight,
      (dynamic value) => _TweenThatAcceptsNulls<double>(begin: value),
    ) as _TweenThatAcceptsNulls<double?>?;
    _minChildWidth = visitor(
      _minChildWidth,
      widget.minChildWidth,
      (dynamic value) => _TweenThatAcceptsNulls<double>(begin: value ?? 0.0),
    ) as _TweenThatAcceptsNulls<double?>?;
    _minChildHeight = visitor(
      _minChildHeight,
      widget.minChildHeight,
      (dynamic value) => _TweenThatAcceptsNulls<double>(begin: value ?? 0.0),
    ) as _TweenThatAcceptsNulls<double?>?;
    _maxChildWidth = visitor(
      _maxChildWidth,
      widget.maxChildWidth,
      (dynamic value) => _TweenThatAcceptsNulls<double>(begin: value ?? double.infinity),
    ) as _TweenThatAcceptsNulls<double?>?;
    _maxChildHeight = visitor(
      _maxChildHeight,
      widget.maxChildHeight,
      (dynamic value) => _TweenThatAcceptsNulls<double>(begin: value ?? double.infinity),
    ) as _TweenThatAcceptsNulls<double?>?;
    _childWidthRatio = visitor(
      _childWidthRatio,
      widget.childWidthRatio,
      (dynamic value) => _TweenThatAcceptsNulls<double>(begin: value),
    ) as _TweenThatAcceptsNulls<double?>?;
    _childHeightRatio = visitor(
      _childHeightRatio,
      widget.childHeightRatio,
      (dynamic value) => _TweenThatAcceptsNulls<double>(begin: value),
    ) as _TweenThatAcceptsNulls<double?>?;
    _minChildWidthRatio = visitor(
      _minChildWidthRatio,
      widget.minChildWidthRatio,
      (dynamic value) => _TweenThatAcceptsNulls<double>(begin: value ?? 0.0),
    ) as _TweenThatAcceptsNulls<double?>?;
    _minChildHeightRatio = visitor(
      _minChildHeightRatio,
      widget.minChildHeightRatio,
      (dynamic value) => _TweenThatAcceptsNulls<double>(begin: value ?? 0.0),
    ) as _TweenThatAcceptsNulls<double?>?;
    _maxChildWidthRatio = visitor(
      _maxChildWidthRatio,
      widget.maxChildWidthRatio,
      (dynamic value) => _TweenThatAcceptsNulls<double>(begin: value ?? double.infinity),
    ) as _TweenThatAcceptsNulls<double?>?;
    _maxChildHeightRatio = visitor(
      _maxChildHeightRatio,
      widget.maxChildHeightRatio,
      (dynamic value) => _TweenThatAcceptsNulls<double>(begin: value ?? double.infinity),
    ) as _TweenThatAcceptsNulls<double?>?;
    _rotateDegrees = visitor(
      _rotateDegrees,
      widget.rotateDegrees,
      (dynamic value) => _TweenThatAcceptsNulls<double>(begin: value ?? 0.0),
    ) as _TweenThatAcceptsNulls<double?>?;
    _matrix4Transform = visitor(
      _matrix4Transform,
      widget.matrix4Transform,
      (dynamic value) => Matrix4TransformTween(begin: value ?? Matrix4Transform()),
    ) as Matrix4TransformTween?;
  }

  @override
  Widget build(BuildContext context) {
    return AlignPositioned(
      child: widget.child,
      alignment: _alignment?.evaluate(animation) ?? Alignment.center,
      dx: _dx?.evaluate(animation) ?? 0.0,
      dy: _dy?.evaluate(animation) ?? 0.0,
      moveByChildWidth: _moveByChildWidth?.evaluate(animation) ?? 0.0,
      moveByChildHeight: _moveByChildHeight?.evaluate(animation) ?? 0.0,
      moveByContainerWidth: _moveByContainerWidth?.evaluate(animation) ?? 0.0,
      moveByContainerHeight: _moveByContainerHeight?.evaluate(animation) ?? 0.0,
      moveVerticallyByChildWidth: _moveVerticallyByChildWidth?.evaluate(animation) ?? 0.0,
      moveHorizontallyByChildHeight: _moveHorizontallyByChildHeight?.evaluate(animation) ?? 0.0,
      moveVerticallyByContainerWidth: _moveVerticallyByContainerWidth?.evaluate(animation) ?? 0.0,
      moveHorizontallyByContainerHeight:
          _moveHorizontallyByContainerHeight?.evaluate(animation) ?? 0.0,
      childWidth: _childWidth?.evaluate(animation),
      childHeight: _childHeight?.evaluate(animation),
      minChildWidth: _minChildWidth?.evaluate(animation),
      minChildHeight: _minChildHeight?.evaluate(animation),
      maxChildWidth: _maxChildWidth?.evaluate(animation),
      maxChildHeight: _maxChildHeight?.evaluate(animation),
      childWidthRatio: _childWidthRatio?.evaluate(animation),
      childHeightRatio: _childHeightRatio?.evaluate(animation),
      minChildWidthRatio: _minChildWidthRatio?.evaluate(animation),
      minChildHeightRatio: _minChildHeightRatio?.evaluate(animation),
      maxChildWidthRatio: _maxChildWidthRatio?.evaluate(animation),
      maxChildHeightRatio: _maxChildHeightRatio?.evaluate(animation),
      rotateDegrees: _rotateDegrees?.evaluate(animation),
      matrix4Transform: _matrix4Transform?.evaluate(animation),
      wins: widget.wins,
      touch: widget.touch,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder description) {
    super.debugFillProperties(description);
    description.add(DiagnosticsProperty<_TweenThatAcceptsNulls<double?>>(
      'dx',
      _dx,
      showName: false,
      defaultValue: null,
    ));
    description.add(DiagnosticsProperty<_TweenThatAcceptsNulls<double?>>(
      'dy',
      _dy,
      showName: false,
      defaultValue: null,
    ));
  }
}

// ////////////////////////////////////////////////////////////////////////////

class _TweenThatAcceptsNulls<T extends dynamic> extends Tween<T?> {
  _TweenThatAcceptsNulls({
    T? begin,
    T? end,
  }) : super(begin: begin, end: end);

  @override
  @protected
  T? lerp(double t) {
    if (begin == null) return end;
    if (end == null) return begin;
    return begin! + (end! - begin) * t as T?;
  }
}

// ////////////////////////////////////////////////////////////////////////////
