import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:interesting/backend/screen/card_manager.dart';
import 'package:interesting/screen/swipe_screen.dart';
import 'package:provider/provider.dart'; // 2. Import the provider package



void main() {
  // A helper function to create the widget with all its dependencies
  Widget createSwipeScreen() {
    return ChangeNotifierProvider(
      create: (context) => CardManager(),
      child: const MaterialApp(
        home: SwipeScreen(),
      ),
    );
  }

  testWidgets('SwipeScreen has a title, a message and 3 buttons', (tester) async {
    // Pump the widget with the provider
    await tester.pumpWidget(createSwipeScreen());

    // Your finders might need to be adjusted depending on what 'T' and 'M' are
    // For example, if they are part of a larger string, use find.textContaining
    final titleFinder = find.text("Let's Find Your Math Level");
    final messageFinder = find.text(instructions);

    final yesButton = find.text("Yes");
    final noButton = find.text("No");
    final maybeButton = find.text("Maybe");

    expect(titleFinder, findsOneWidget);
    expect(messageFinder, findsOneWidget);
    expect(yesButton, findsOneWidget);
    expect(noButton, findsOneWidget);
    expect(maybeButton, findsOneWidget);
  });

  testWidgets('Test button yes', (tester) async {
      await testButton(tester, createSwipeScreen, "Yes");
  });

  testWidgets('Test button no', (tester) async {
    await testButton(tester, createSwipeScreen, "No");
  });

  testWidgets('Test button maybe', (tester) async {
    await testButton(tester, createSwipeScreen, "Maybe");
  });
}

Future<void> testButton(WidgetTester tester, Widget Function() createSwipeScreen, String textButton) async {
  await tester.pumpWidget(createSwipeScreen());
  await tester.pumpAndSettle();
  
  final button = find.text(textButton);
  
  var messageFinder = find.text(instructions);
  expect(messageFinder, findsOne);
  
  await tester.tap(button);
  
  // Trigger a frame.
  await tester.pumpAndSettle();
  
  
  messageFinder = find.text(instructions);
  expect(messageFinder, findsNothing);
}

//debugDumpApp();
var instructions = '''
You’ll see a series of math problems. No need to solve them. 
Just answer: Can you solve this one?

Swipe right for Yes, left for No, up for Maybe.
Ready? Swipe anywhere to start.

Prefer tapping? Use the buttons below.
''';