import 'package:equatable/equatable.dart';

class SholatpageModel extends Equatable {
  final String city;
  final String date;
  final Map<String, dynamic> sholatTime;

  const SholatpageModel({
    required this.city,
    required this.date,
    required this.sholatTime,
  });

  @override
  List<Object?> get props => [city, date, sholatTime];
}
