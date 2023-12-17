import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/home/views/home_view.dart';
import 'package:flutter_test/flutter_test.dart';
import 'login.dart';

void main() {
  testWidgets('LoginPage UI Test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: LoginPage1()));

    // Find widgets in the LoginPage
    expect(find.text('Login'), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(2));
    expect(find.byType(ElevatedButton), findsOneWidget);
  });

  /*testWidgets('LoginPage Button Test', (WidgetTester tester) async {
    // Pump the LoginPage1 widget
    await tester.pumpWidget(MaterialApp(home: LoginPage1()));

    // Build the LoginPage1 widget
    await tester.pumpAndSettle();

    // Find and interact with the Email and Password fields
    await tester.enterText(find.byKey(Key('emailField')), 'user@example.com');
    await tester.enterText(find.byKey(Key('passwordField')), 'password123');

    // Tap the login button
    await tester.tap(find.byKey(Key('loginButton')));

    // Wait for the UI to update after the tap action
    await tester.pumpAndSettle();

    // Check if navigation to HomeView occurs after successful login
    // Replace HomeView with the appropriate widget class for your home screen
    expect(find.byType(HomeView), findsOneWidget);
  });*/
}
