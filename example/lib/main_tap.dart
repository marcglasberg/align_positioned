import 'package:align_positioned/align_positioned.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() async => runApp(MaterialApp(home: Demo()));

/// Displays a checkmark.
class Demo extends StatefulWidget {
  //
  static const angle = 135.0;

  // Thickness in relation to the height.
  // Change this from 0.0 (thin) to 0.35 (thick).
  static const thickness = 0.15;

  @override
  _DemoState createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tap outside of widget area')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('The circle below is half outside the AlignPositioned area (in red), '
                'but it feels the tap both inside and outside of that area. '
                'Tap it to see a color change.'
                '\n\n'
                'This is possible because the AlignPosition widget has a special hitText method '
                'which does not cull the tap position.'
                '\n\n'
                'However, all native Flutter widgets cull the tap position. If an AlignPosition '
                'is inside a native Flutter widget parent, that parent will cull the tap position, '
                'rendering the AlignPosition larger area useless. For more information, see:'
                '\n\n'
                '* https://github.com/flutter/flutter/issues/75747'
                '\n'
                '* https://github.com/flutter/flutter/issues/19445'),
          ),
          Expanded(
            child: Container(
              color: Colors.yellow,
              child: AlignPositioned(
                childWidthRatio: 0.6,
                childHeightRatio: 0.4,
                moveByContainerWidth: -0.08,
                child: ColoredBox(
                  color: Colors.red,
                  child: AlignPositioned(
                    childWidthRatio: 0.7,
                    childHeightRatio: 0.7,
                    moveByContainerWidth: 0.5,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          index++;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: (index % 2 == 0 ? Colors.blue : Colors.green).withOpacity(0.9),
                          border: Border.all(width: 1.0, color: Colors.black),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget rectangle({
    Color color = Colors.red,
    Widget? child,
    bool round = false,
    VoidCallback? onTap,
  }) {
    Widget widget = ColoredBox(
      color: color.withOpacity(0.7),
      child: child,
    );

    if (onTap != null) widget = GestureDetector(onTap: onTap, child: widget);

    return widget;
    // }
    // Widget rectangle({
    //   Color color = Colors.red,
    //   Widget? child,
    //   bool round = false,
    //   VoidCallback? onTap,
    // }) {
    //   Widget widget = ColoredBox(
    //     decoration: BoxDecoration(
    //       color: color.withOpacity(0.7),
    //       border: Border.all(width: 1.0, color: Colors.black),
    //       shape: round ? BoxShape.circle : BoxShape.rectangle,
    //     ),
    //     child: child,
    //   );
    //
    //   if (!round) widget = child ?? SizedBox();
    //
    //   if (onTap != null) widget = GestureDetector(onTap: onTap, child: widget);
    //
    //   return widget;
    // }
  }
}

/// A widget that paints its area with a specified [Color] and then draws its
/// child on top of that color.
class ColoredBox extends SingleChildRenderObjectWidget {
  /// Creates a widget that paints its area with the specified [Color].
  ///
  /// The [color] parameter must not be null.
  const ColoredBox({required this.color, Widget? child, Key? key})
      : assert(color != null),
        super(key: key, child: child);

  /// The color to paint the background area with.
  final Color color;

  @override
  _RenderColoredBox createRenderObject(BuildContext context) {
    return _RenderColoredBox(color: color);
  }

  @override
  void updateRenderObject(BuildContext context, _RenderColoredBox renderObject) {
    renderObject.color = color;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Color>('color', color));
  }
}

class _RenderColoredBox extends RenderProxyBoxWithHitTestBehavior {
  _RenderColoredBox({required Color color})
      : _color = color,
        super(behavior: HitTestBehavior.opaque);

  /// The fill color for this render object.
  ///
  /// This parameter must not be null.
  Color get color => _color;
  Color _color;

  set color(Color value) {
    assert(value != null);
    if (value == _color) {
      return;
    }
    _color = value;
    markNeedsPaint();
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (size > Size.zero) {
      context.canvas.drawRect(offset & size, Paint()..color = color);
    }
    if (child != null) {
      context.paintChild(child!, offset);
    }
  }

  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    if (hitTestChildren(result, position: position) || hitTestSelf(position)) {
      result.add(BoxHitTestEntry(this, position));
      return true;
    }
    return false;
  }
}
