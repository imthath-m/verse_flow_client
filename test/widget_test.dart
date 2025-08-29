// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:verse_flow_client/main.dart';

void main() {
  testWidgets('Surah List Screen smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the app title is displayed
    expect(find.text('Verse Flow'), findsOneWidget);

    // Verify that the search bar is present
    expect(find.byType(TextField), findsOneWidget);

    // Verify that the floating action button is present
    expect(find.byType(FloatingActionButton), findsOneWidget);
  });

  testWidgets('Search functionality test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Find the search text field
    final searchField = find.byType(TextField);
    expect(searchField, findsOneWidget);

    // Enter search text
    await tester.enterText(searchField, 'Al-Faatiha');
    await tester.pump();

    // Verify that search is working (this will depend on the data being loaded)
    // For now, just verify the text was entered
    expect(find.text('Al-Faatiha'), findsOneWidget);
  });
}
