// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sharechat_clone/main.dart';

void main() {
  testWidgets('Home feed shows creator names and social usernames', (WidgetTester tester) async {
    await tester.pumpWidget(const ShareChatCloneApp());

    expect(find.text('ShareChat'), findsOneWidget);
    expect(find.text('Taylor Swift'), findsOneWidget);
    expect(find.textContaining('@taylorswift'), findsOneWidget);

    await tester.tap(find.text('मराठी'));
    await tester.pump();
    expect(find.text('आयुष्यात आनंद देणाऱ्या गोष्टींसाठी थोडी जागा ठेवा.'), findsOneWidget);
  });

  testWidgets('Trending topic opens celebrity posts', (WidgetTester tester) async {
    await tester.pumpWidget(const ShareChatCloneApp());

    await tester.tap(find.byIcon(Icons.local_fire_department).last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('#Mumbai'));
    await tester.pumpAndSettle();

    expect(find.text('#Mumbai posts'), findsOneWidget);
    expect(find.textContaining('shared a mumbai update'), findsWidgets);
  });
}
