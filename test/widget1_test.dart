import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/home/views/home_view.dart';
import 'package:flutter_application_1/app/modules/home/views/todos_page.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('CoffeeFile Widget Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: CoffeeFile(
          coffeeImage: 'images/latte.jpg',
          coffeeName: 'Cappuccino',
          coffeePrice: 'Rp.50.000',
          coffeeDesk: 'with chocolate',
        ),
      ),
    );

    // Verify if the coffee name is present
    expect(find.text('Cappuccino'), findsOneWidget);

    // Verify if the coffee desk is present
    expect(find.text('with chocolate'), findsOneWidget);

    // Verify if the coffee price is present
    expect(find.text('Rp.50.000'), findsOneWidget);

    // Verify if the coffee image is present
    expect(find.byType(Image), findsOneWidget);

    // You can add more test cases based on your widget's structure and behavior
  });
}
