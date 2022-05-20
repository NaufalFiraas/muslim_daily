import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'reminder_icon_state.dart';

class ReminderIconCubit extends Cubit<ReminderIconState> {
  ReminderIconCubit() : super(const ReminderIconState(false));

  void setReminder(bool value) {
    emit(ReminderIconState(value));
  }
}
