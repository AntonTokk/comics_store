import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:comics_store/main.dart';

void main() {
  testWidgets('Comics Store smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(ComicsStoreApp());

    // Verify that the app bar title is correct.
    expect(find.text('Comics Store'), findsOneWidget);

    // Verify that the first comic item is displayed.
    expect(find.text('Spider-Man: Blue'), findsOneWidget);
    expect(find.text('Jeph Loeb'), findsOneWidget);
    expect(find.text('\$14.99'), findsOneWidget);

    // Tap the info icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.info).first);
    await tester.pumpAndSettle();

    // Verify that the comic details screen is displayed.
    expect(find.text('Spider-Man: Blue'), findsOneWidget);
    expect(find.text('Автор: Jeph Loeb'), findsOneWidget);
    expect(find.text('Цена: \$14.99'), findsOneWidget);
    expect(find.text('Описание:'), findsOneWidget);
    expect(find.text('Осталось экземпляров: 5'), findsOneWidget);

    // Go back to the home screen
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    // Verify that the home screen is displayed again
    expect(find.text('Comics Store'), findsOneWidget);

    // Verify that the second comic item is displayed.
    expect(find.text('Spider-Man: Kraven\'s Last Hunt'), findsOneWidget);
    expect(find.text('J.M. DeMatteis'), findsOneWidget);
    expect(find.text('\$17.99'), findsOneWidget);

    // Tap the favorite icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.favorite_border).first);
    await tester.pumpAndSettle();

    // Verify that the favorite icon is now filled.
    expect(find.byIcon(Icons.favorite).first, findsOneWidget);

    // Tap the favorite icon again to remove from favorites.
    await tester.tap(find.byIcon(Icons.favorite).first);
    await tester.pumpAndSettle();

    // Verify that the favorite icon is now outlined again.
    expect(find.byIcon(Icons.favorite_border).first, findsOneWidget);

    // Tap the "Add to Cart" button and verify the snackbar message
    await tester.tap(find.byIcon(Icons.info).first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Добавить в корзину'));
    await tester.pumpAndSettle();
    expect(find.text('Добавлено в корзину'), findsOneWidget);
  });
}