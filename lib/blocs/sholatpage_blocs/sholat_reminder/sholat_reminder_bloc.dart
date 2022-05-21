import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:muslim_daily/data/models/sholat_reminder_model.dart';
import 'package:muslim_daily/data/repositories/sholat_reminder_repositories.dart';

part 'sholat_reminder_event.dart';

part 'sholat_reminder_state.dart';

class SholatReminderBloc
    extends Bloc<SholatReminderEvent, SholatReminderState> {
  final SholatReminderRepositories repo;

  SholatReminderBloc(this.repo) : super(SholatReminderOff()) {
    on<SholatReminderSetFromView>((event, emit) => _setFromView(event, emit));
    on<SholatReminderCancelFromView>(
        (event, emit) => _cancelReminder(event, emit));
  }

  void _setFromView(
      SholatReminderSetFromView event, Emitter<SholatReminderState> emit) {
    repo.showScheduledNotification(event.reminderModel);
  }

  void _cancelReminder(
      SholatReminderCancelFromView event, Emitter<SholatReminderState> emit) {
    repo.cancelNotification(event.id);

  }
}
