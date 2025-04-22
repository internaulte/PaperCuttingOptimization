import 'dart:math';

import 'package:paper_cutting_optimization/domain/entities/cutting_solution.dart';
import 'package:paper_cutting_optimization/domain/entities/page_layout.dart';
import 'package:paper_cutting_optimization/domain/entities/positioned_rectangle.dart';
import 'package:paper_cutting_optimization/domain/entities/rectangle.dart';
import 'package:paper_cutting_optimization/domain/usecases/calculate_optimal_cutting.dart';

const double _a4Width = 210.0; // mm
const double _a4Height = 297.0; // mm

class CalculateOptimalCuttingImpl implements CalculateOptimalCutting {
  @override
  Future<CuttingSolution> execute(CuttingParams params) async {
    // Make a mutable copy of the input rectangles
    final rects = List<Rectangle>.from(params.rectangles);
    final pages = <PageLayout>[];
    var pageIndex = 1;

    // Generate pages until all rectangles are placed
    while (rects.isNotEmpty) {
      final placements = _packRowsIntoPage(rects, params);
      pages.add(PageLayout(pageNumber: pageIndex++, placements: placements));
    }

    return CuttingSolution(pages);
  }

  /// Packs as many rows as will fit on one A4 page, returns all placements.
  List<PositionedRectangle> _packRowsIntoPage(
    List<Rectangle> rects,
    CuttingParams params,
  ) {
    final placements = <PositionedRectangle>[];
    double cursorY = params.margin;

    // Keep filling rows until no further rows will fit
    while (_canStartNewRow(cursorY, params.margin)) {
      final rowResult = _packSingleRow(rects, cursorY, params);
      if (rowResult == null) break; // no rectangles fit in a new row
      placements.addAll(rowResult.placements);
      cursorY += rowResult.height + params.gap;
    }

    return placements;
  }

  /// Returns true if there's room to start a row at vertical offset [cursorY].
  bool _canStartNewRow(double cursorY, double margin) =>
      cursorY + margin < _a4Height;

  /// Attempts to fill one horizontal row at [cursorY]; returns the placements and row height,
  /// or null if no rectangle fits in that row.
  _RowResult? _packSingleRow(
    List<Rectangle> rects,
    double cursorY,
    CuttingParams params,
  ) {
    double cursorX = params.margin;
    double rowHeight = 0;
    final rowPlacements = <PositionedRectangle>[];

    // Iterate over the list, trying to place each rectangle in turn
    for (var i = 0; i < rects.length; i++) {
      final r = rects[i];
      final placement = _tryPlaceRectangle(r, cursorX, cursorY, params);

      if (placement != null) {
        // Place it
        rowPlacements.add(placement);

        // Advance cursorX and update rowHeight
        final placedWidth = placement.rotated ? r.height : r.width;
        final placedHeight = placement.rotated ? r.width : r.height;
        cursorX += placedWidth + params.gap;
        rowHeight = max(rowHeight, placedHeight);

        // Remove from pending list
        rects.removeAt(i);
        i--;
      }
    }

    if (rowPlacements.isEmpty) return null;
    return _RowResult(placements: rowPlacements, height: rowHeight);
  }

  /// Tries to fit [r] at ([cursorX], [cursorY]); returns a PositionedRectangle if it fits,
  /// or null otherwise.
  PositionedRectangle? _tryPlaceRectangle(
    Rectangle r,
    double cursorX,
    double cursorY,
    CuttingParams params,
  ) {
    // Check no-rotation fit
    final fitsNoRotate =
        cursorX + r.width + params.margin <= _a4Width &&
        cursorY + r.height + params.margin <= _a4Height;

    // Check rotated fit
    final fitsRotated =
        params.allowRotation &&
        cursorX + r.height + params.margin <= _a4Width &&
        cursorY + r.width + params.margin <= _a4Height;

    if (!fitsNoRotate && !fitsRotated) return null;

    // Decide if we actually rotate
    final rotated = fitsRotated && (!fitsNoRotate || r.height < r.width);

    return PositionedRectangle(
      rect: r,
      x: cursorX,
      y: cursorY,
      rotated: rotated,
    );
  }
}

/// Simple container for a row’s placements and its height.
class _RowResult {
  final List<PositionedRectangle> placements;
  final double height;

  _RowResult({required this.placements, required this.height});
}
