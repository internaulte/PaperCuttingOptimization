import 'package:flutter_test/flutter_test.dart';
import 'package:paper_cutting_optimization/data/repositories_impl/calculate_optimal_cutting_impl.dart';
import 'package:paper_cutting_optimization/domain/entities/rectangle.dart';
import 'package:paper_cutting_optimization/domain/usecases/calculate_optimal_cutting.dart';

void main() {
  test('Simple rectangles fit into one page', () async {
    final impl = CalculateOptimalCuttingImpl();
    final params = CuttingParams(
      rectangles: [
        const Rectangle(width: 100, height: 100),
        const Rectangle(width: 100, height: 100),
      ],
      margin: 0,
      gap: 0,
      allowRotation: false,
    );
    final solution = await impl.execute(params);
    expect(solution.pageCount, equals(1));
    expect(solution.pages.first.placements.length, equals(2));
  });

  test('Too many large rectangles spill to next pages', () async {
    final impl = CalculateOptimalCuttingImpl();
    final params = CuttingParams(
      rectangles: List.generate(
        10,
        (_) => const Rectangle(width: 150, height: 150),
      ),
      margin: 0,
      gap: 0,
      allowRotation: false,
    );
    final solution = await impl.execute(params);
    expect(solution.pageCount, 10);
  });
}
