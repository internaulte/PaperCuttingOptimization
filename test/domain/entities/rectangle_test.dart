import 'package:flutter_test/flutter_test.dart';
import 'package:paper_cutting_optimization/domain/entities/rectangle.dart';

void main() {
  test('Rectangle equality and props', () {
    final r1 = Rectangle(width: 50, height: 100);
    final r2 = Rectangle(width: 50, height: 100);
    expect(r1, equals(r2));
  });
}
