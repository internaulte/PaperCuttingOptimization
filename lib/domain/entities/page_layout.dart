import 'package:equatable/equatable.dart';

import 'positioned_rectangle.dart';

class PageLayout extends Equatable {
  /// One-based page index
  final int pageNumber;

  /// Rectangles placed on this page
  final List<PositionedRectangle> placements;

  const PageLayout({required this.pageNumber, required this.placements});

  @override
  List<Object?> get props => [pageNumber, placements];
}
