import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'reminder_icon_state.dart';

class ReminderIconCubit extends HydratedCubit<ReminderIconState> {
  List<bool> reminderValues;

  ReminderIconCubit(this.reminderValues)
      : super(ReminderIconOff(reminderValues));

  void setReminder(int index, bool value) {
    state.isReminderOn[index] = value;
    value
        ? emit(ReminderIconOff(state.isReminderOn))
        : emit(ReminderIconOn(state.isReminderOn));
  }

  @override
  ReminderIconState? fromJson(Map<String, dynamic> json) {
    return ReminderIconState(json['isReminderOn']);
  }

  @override
  Map<String, dynamic>? toJson(ReminderIconState state) {
    return state.toMap();
  }
}
