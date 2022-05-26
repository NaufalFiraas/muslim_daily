import 'package:equatable/equatable.dart';

class ArahKiblat extends Equatable {
  final int dynamicDirection;
  final int kiblatDirection;

  const ArahKiblat(this.dynamicDirection, this.kiblatDirection);

  @override
  List<Object?> get props => [dynamicDirection, kiblatDirection];
}
