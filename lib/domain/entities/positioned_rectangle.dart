import 'package:equatable/equatable.dart';

import 'rectangle.dart';

class PositionedRectangle extends Equatable {
  final Rectangle rect;

  /// X-offset from the top‑left of the page, in mm
  final double x;

  /// Y-offset from the top‑left of the page, in mm
  final double y;

  /// Whether the rectangle has been rotated (swap width/height)
  final bool rotated;

  const PositionedRectangle({
    required this.rect,
    required this.x,
    required this.y,
    this.rotated = false,
  });

  @override
  List<Object?> get props => [rect, x, y, rotated];
}
