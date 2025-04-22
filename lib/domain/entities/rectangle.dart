import 'package:equatable/equatable.dart';

class Rectangle extends Equatable {
  /// Width in millimeters
  final double width;

  /// Height in millimeters
  final double height;

  /// Allow this rectangle to be rotated
  final bool canRotate;

  const Rectangle({
    required this.width,
    required this.height,
    this.canRotate = true,
  });

  @override
  List<Object?> get props => [width, height, canRotate];
}
