import 'package:flutter_test/flutter_test.dart';
import 'package:hdi_mini_test/app.dart';

void main() {
  testWidgets('App should render successfully', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const App());

    // Verify that our app shows the initial text.
    expect(find.text('HDI Member App Ready'), findsOneWidget);
  });
}
