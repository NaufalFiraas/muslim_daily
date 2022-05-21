part of 'sholat_reminder_bloc.dart';

abstract class SholatReminderEvent extends Equatable {
  const SholatReminderEvent();
}

class SholatReminderSetFromView extends SholatReminderEvent {
  final SholatReminderModel reminderModel;

  const SholatReminderSetFromView(this.reminderModel);

  @override
  List<Object?> get props => [reminderModel];
}

class SholatReminderCancelFromView extends SholatReminderEvent {
  final int id;

  const SholatReminderCancelFromView(this.id);

  @override
  List<Object?> get props => [id];
}