part of 'sholat_reminder_bloc.dart';

class SholatReminderState extends Equatable {
  const SholatReminderState();
}

class SholatReminderOff extends SholatReminderState {
  @override
  List<Object> get props => [];
}

class SholatReminderOn extends SholatReminderState {
  final String sholatName;

  const SholatReminderOn(this.sholatName);

  @override
  List<Object?> get props => [sholatName];
}
