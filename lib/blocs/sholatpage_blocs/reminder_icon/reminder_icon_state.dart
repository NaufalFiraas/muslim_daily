part of 'reminder_icon_cubit.dart';

class ReminderIconState extends Equatable {
  final bool isReminderOn;

  const ReminderIconState(this.isReminderOn);

  Map<String, dynamic> toMap() {
    return {
      'isReminderOn': isReminderOn,
    };
  }

  @override
  List<Object?> get props => [isReminderOn];
}
