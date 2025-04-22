import 'package:flutter_test/flutter_test.dart';
import 'package:paper_cutting_optimization/domain/entities/cutting_solution.dart';
import 'package:paper_cutting_optimization/domain/usecases/calculate_optimal_cutting.dart';

class DummyCalculator implements CalculateOptimalCutting {
  @override
  Future<CuttingSolution> execute(CuttingParams params) {
    // Return an empty solution as placeholder
    return Future.value(CuttingSolution([]));
  }
}

void main() {
  test('CalculateOptimalCutting interface returns a CuttingSolution', () async {
    final calc = DummyCalculator();
    final sol = await calc.execute(CuttingParams(rectangles: []));
    expect(sol, isNotNull);
    expect(sol.pageCount, equals(0));
  });
}
