import 'dart:math';

import 'package:flutter/material.dart';
import '../../theme.dart';
import '../../util.dart';
import '../bezier/Wave.dart';
import '../latex_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taylor series',
      theme: getTheme(context),
      home: SwipeScreen(),
    );
  }
}

class SwipeScreen extends StatelessWidget {
  const SwipeScreen({super.key});

  static const maxWidthCard = 600.0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var colorScheme = Theme.of(context).colorScheme;
    final ellipseColor = buildSurfaceVariant(colorScheme);
    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: buildMainBody(size, ellipseColor, colorScheme, context),
    );
  }

  Stack buildMainBody(
    Size size,
    Color ellipseColor,
    ColorScheme colorScheme,
    BuildContext context,
  ) {
    return Stack(
      children: [
        // 1) giant ellipse
        buildGiantEllipse(size, ellipseColor),

        // 2) line
        buildBottomLine(colorScheme),

        // 3) main content
        buildMainContent(context, colorScheme),
      ],
    );
  }

  Widget buildGiantEllipse(Size size, Color ellipseColor) {
    return Positioned(
      top: -size.height * .8,
      left: size.width / 2 - maxWidthCard,
      child: Container(
        width: min(size.width, maxWidthCard) * 1.8,
        height: size.height * 1.5,
        decoration: BoxDecoration(
          color: ellipseColor,
          borderRadius: BorderRadius.circular(size.height),
        ),
      ),
    );
  }

  Positioned buildBottomLine(ColorScheme colorScheme) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(height: 3.5, color: colorScheme.onPrimaryContainer),
    );
  }

  Widget buildMainContent(BuildContext context, ColorScheme colorScheme) {
    return Center(
      child: Container(
        constraints: BoxConstraints(maxWidth: maxWidthCard),
        child: Column(
          children: [
            // a) header text
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 16,
              ),
              child: buildInstructions(context, colorScheme),
            ),

            // b) the card with LaTeX, now with horizontal padding
            buildLatexCard(),

            // c) buttons row
            buildButtons(colorScheme),

            // d) wave at very bottom
            SizedBox(height: 40, width: double.infinity, child: Wave()),
          ],
        ),
      ),
    );
  }

  Widget buildInstructions(BuildContext context, ColorScheme colorScheme) {
    return Text.rich(
      textAlign: TextAlign.center,
      TextSpan(
        children: [
          TextSpan(
            text: 'Find Your Math Level\n',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: colorScheme.onSurface),
          ),
          TextSpan(
            text: 'Swipe to show how comfortable you are with each problem.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLatexCard() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(40, 12, 40, 0),
        child: Center(
          child: LatexCard(
            expressions: [
              r'\displaystyle x = \frac{-b \pm \sqrt{b^2 - 4ac}}{2a}',
              r'\displaystyle y = mx + b',
              r'\displaystyle e^{i\pi} + 1 = 0',
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButtons(ColorScheme colorScheme) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 120, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 10,
            children: [
              // Too Hard button
              buildElevatedButton(
                colorScheme.tertiary,
                colorScheme.onTertiary,
                'Too hard',
                Icons.close,
              ),

              // Not sure button
              buildElevatedButton(
                colorScheme.secondary,
                colorScheme.onSecondary,
                'Not sure',
                Icons.remove,
              ),

              // Easy button
              buildElevatedButton(
                colorScheme.primary,
                colorScheme.onPrimary,
                'Easy',
                Icons.check,
              ),
            ],
          ),
        ),

        // back icon button
        buildBackButton(colorScheme),
      ],
    );
  }

  Widget buildElevatedButton(
    Color backgroundColor,
    Color foregroundColor,
    String data,
    IconData icon,
  ) {
    return Expanded(
      child: ElevatedButton.icon(
        icon: Icon(icon),
        label: Text(data),
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          elevation: 2,
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          padding: EdgeInsets.symmetric(vertical: 20),
        ),
      ),
    );
  }

  Positioned buildBackButton(ColorScheme colorScheme) {
    return Positioned(
      top: 5,
      left: 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 2,
          shape: CircleBorder(),
          side: BorderSide(color: colorScheme.outline, width: 1.0),
          padding: EdgeInsets.all(20.0),
          backgroundColor: colorScheme.surfaceContainerLow,
          foregroundColor: colorScheme.onSurfaceVariant, // optional fill
        ),
        onPressed: () {},
        child: Icon(Icons.undo),
      ),
    );
  }

}
