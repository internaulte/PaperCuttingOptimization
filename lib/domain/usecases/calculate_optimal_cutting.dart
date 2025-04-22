import '../entities/cutting_solution.dart';
import '../entities/rectangle.dart';

/// Parameters for the cutting problem
class CuttingParams {
  final List<Rectangle> rectangles;
  final double margin; // margin around edges, in mm
  final double gap; // spacing between pieces, in mm
  final bool allowRotation; // rotate pieces if beneficial

  CuttingParams({
    required this.rectangles,
    this.margin = 0,
    this.gap = 0,
    this.allowRotation = true,
  });
}

/// Abstract definition of the use case
abstract class CalculateOptimalCutting {
  /// Computes the minimal-page solution for the given rectangles & params
  Future<CuttingSolution> execute(CuttingParams params);
}
