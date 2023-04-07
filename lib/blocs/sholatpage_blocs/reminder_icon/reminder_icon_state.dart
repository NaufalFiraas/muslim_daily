part of 'reminder_icon_cubit.dart';

abstract class IconSholatReminderState extends Equatable {
  final bool status;

  const IconSholatReminderState(this.status);
}

class IconSholatReminderChange extends IconSholatReminderState {
  const IconSholatReminderChange([bool status = false]) : super(status);

  @override
  List<Object?> get props => [status];
}