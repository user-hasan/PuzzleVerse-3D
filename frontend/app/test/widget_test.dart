import 'package:flutter_test/flutter_test.dart';
import 'package:puzzleverse_3d/main.dart';

void main() {
  testWidgets('renders the Arabic PuzzleVerse cube practice screen', (
    tester,
  ) async {
    await tester.pumpWidget(const PuzzleVerseApp());
    expect(find.text('PuzzleVerse'), findsOneWidget);
    expect(find.text('مكعب روبيك'), findsOneWidget);
    expect(find.text('نسخة تجريبية ٠.١'), findsOneWidget);
    await tester.scrollUntilVisible(find.text('خلط'), 250);
    await tester.pumpAndSettle();
    expect(find.text('خلط'), findsOneWidget);
  });
}
