import 'package:TimeTracker/components/customraised_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('On pressed callback', (WidgetTester tester) async {
    var pressed = false;
    await tester.pumpWidget(
      MaterialApp(
        home: CustomRaisedButton(
          child: Text('tap me'),
          onPressed: () => pressed = true,
        ),
      ),
    );
    final button = find.byType(RaisedButton);
    expect(button, findsOneWidget);
    expect(find.text('tap me'), findsOneWidget);

    expect(find.byType(FlatButton), findsNothing);

    await tester.tap(button);
    expect(pressed, true);
  });
}
