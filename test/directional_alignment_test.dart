import 'package:align_positioned/align_positioned.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const childKey = Key('child');

  Widget build(TextDirection direction, AlignmentGeometry alignment, {bool animated = false}) {
    const child = SizedBox(key: childKey, width: 100, height: 50);
    return Directionality(
      textDirection: direction,
      child: Center(
        child: SizedBox(
          width: 400,
          height: 300,
          child: animated
              ? AnimatedAlignPositioned(alignment: alignment, dx: 10, child: child)
              : AlignPositioned(alignment: alignment, dx: 10, child: child),
        ),
      ),
    );
  }

  Offset childTopLeft(WidgetTester tester) =>
      tester.getTopLeft(find.byKey(childKey)) - tester.getTopLeft(find.byType(SizedBox).first);

  testWidgets('Alignment ignores the text direction', (tester) async {
    await tester.pumpWidget(build(TextDirection.ltr, Alignment.topLeft));
    expect(childTopLeft(tester), const Offset(10, 0));

    await tester.pumpWidget(build(TextDirection.rtl, Alignment.topLeft));
    expect(childTopLeft(tester), const Offset(10, 0));
  });

  testWidgets('AlignmentDirectional follows the text direction', (tester) async {
    await tester.pumpWidget(build(TextDirection.ltr, AlignmentDirectional.topStart));
    expect(childTopLeft(tester), const Offset(10, 0));

    // In RTL, topStart is topRight. The dx is NOT flipped.
    await tester.pumpWidget(build(TextDirection.rtl, AlignmentDirectional.topStart));
    expect(childTopLeft(tester), const Offset(400 - 100 + 10, 0));
  });

  testWidgets('AnimatedAlignPositioned accepts AlignmentDirectional', (tester) async {
    await tester.pumpWidget(
        build(TextDirection.rtl, AlignmentDirectional.topStart, animated: true));
    expect(childTopLeft(tester), const Offset(310, 0));

    // Animates from a directional to a non-directional alignment.
    await tester.pumpWidget(build(TextDirection.rtl, Alignment.topLeft, animated: true));
    await tester.pumpAndSettle();
    expect(childTopLeft(tester), const Offset(10, 0));
  });
}
