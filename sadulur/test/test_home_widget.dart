import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sadulur/presentations/home/home_page.dart';
// ignore: unused_import
import 'package:sadulur/presentations/home/widget/store_card.dart';

void main() {
  testWidgets('HomePage Widget Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(home: HomePage()));

    // Verify that the app title is displayed
    expect(find.text('Sadulur'), findsWidgets);
    // expect(find.text('UMKM Dashboard'), findsOneWidget);

    // // Tap on the search bar
    // await tester.enterText(find.byType(TextField), 'Search Query');
    // await tester.pump();

    // // Verify that the search query is entered
    // expect(find.text('Search Query'), findsOneWidget);

    // // Tap on the dropdown and select a level
    // await tester.tap(find.byType(DropdownButton));
    // await tester.pumpAndSettle();
    // await tester.tap(find.text('micro').last);
    // await tester.pumpAndSettle();

    // // Verify that the level is selected and the filtered stores are displayed
    // expect(find.text('micro'), findsOneWidget);
    // expect(find.byType(UMKMStoreCard), findsNWidgets(1));
  });
}
