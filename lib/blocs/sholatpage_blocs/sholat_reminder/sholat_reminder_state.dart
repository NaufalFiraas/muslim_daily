part of 'sholat_reminder_cubit.dart';

abstract class SholatReminderState extends Equatable {
  const SholatReminderState();
}

class SholatReminderInitial extends SholatReminderState {
  @override
  List<Object> get props => [];
}

class SholatReminderOnNotif extends SholatReminderState {
  final String? payload;

  const SholatReminderOnNotif(this.payload);

  @override
  List<Object?> get props => [payload];
}
