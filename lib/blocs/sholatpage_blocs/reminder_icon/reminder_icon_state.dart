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

// class ReminderIconState extends Equatable {
//   final List<bool> isReminderOn;
//
//   const ReminderIconState(this.isReminderOn);
//
//   Map<String, dynamic> toMap() {
//     return {
//       'isReminderOn': isReminderOn,
//     };
//   }
//
//   @override
//   List<Object?> get props => [isReminderOn];
// }
//
// class ReminderIconOn extends ReminderIconState {
//   const ReminderIconOn(List<bool> isReminderOn) : super(isReminderOn);
// }
//
// class ReminderIconOff extends ReminderIconState {
//   const ReminderIconOff(List<bool> isReminderOn) : super(isReminderOn);
// }
