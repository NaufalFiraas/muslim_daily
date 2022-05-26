import 'package:equatable/equatable.dart';

class ArahKiblat extends Equatable {
  final double dynamicDirection;
  final double kiblatDirection;

  const ArahKiblat(this.dynamicDirection, this.kiblatDirection);

  @override
  List<Object?> get props => [dynamicDirection, kiblatDirection];
}
