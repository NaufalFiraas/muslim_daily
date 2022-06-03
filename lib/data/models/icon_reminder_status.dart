import 'package:equatable/equatable.dart';

class IconReminderStatus extends Equatable {
  final int index;
  final bool status;

  const IconReminderStatus(this.index, this.status);

  @override
  List<Object?> get props => [index, status];
}