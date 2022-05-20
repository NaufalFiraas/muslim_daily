import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'reminder_icon_state.dart';

class ReminderIconCubit extends HydratedCubit<ReminderIconState> {
  ReminderIconCubit() : super(const ReminderIconState(false));

  void setReminder(bool value) {
    emit(ReminderIconState(value));
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
