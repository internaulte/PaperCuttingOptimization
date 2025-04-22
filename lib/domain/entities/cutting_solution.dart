import 'package:equatable/equatable.dart';

import 'page_layout.dart';

class CuttingSolution extends Equatable {
  /// Layouts, one entry per A4 page used
  final List<PageLayout> pages;

  const CuttingSolution(this.pages);

  /// Total number of A4 pages
  int get pageCount => pages.length;

  @override
  List<Object?> get props => [pages];
}
