import 'package:equatable/equatable.dart';

class ArahKiblat extends Equatable {
  final String cityName;
  final double kiblatDirection;

  const ArahKiblat(this.cityName, this.kiblatDirection);

  @override
  List<Object?> get props => [cityName, kiblatDirection];
}
