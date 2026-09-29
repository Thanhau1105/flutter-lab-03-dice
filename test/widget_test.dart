import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab_03/main.dart';

void main() {
  testWidgets('Dice screen shows two valid dice and updates on roll', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const DiceApp());

    expect(find.text('Dice'), findsOneWidget);
    expect(find.text('Tổng điểm: 3'), findsOneWidget);
    expect(find.text('Lần lắc: 0'), findsOneWidget);

    await tester.tap(find.byKey(const Key('roll-button')));
    await tester.pump();

    expect(find.text('Lần lắc: 1'), findsOneWidget);

    for (final key in ['left-die', 'right-die']) {
      final die = tester.widget<Image>(find.byKey(Key(key)));
      final asset = die.image as AssetImage;
      expect(asset.assetName, matches(RegExp(r'^assets/dice_[1-6]\.png$')));
    }
  });
}
