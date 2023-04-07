import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:muslim_daily/data/models/sholat_reminder_model.dart';
import 'package:muslim_daily/data/repositories/sholat_reminder_repositories.dart';

part 'sholat_reminder_state.dart';

class SholatReminderCubit extends Cubit<SholatReminderState> {
  late final SholatReminderRepositories repo;
  late StreamSubscription repoSubscription;

  SholatReminderCubit([SholatReminderRepositories? optionalRepo]) : super(SholatReminderInitial()) {
    repo = optionalRepo ?? SholatReminderRepositories();
    repoSubscription = repo.onNotification.stream.listen((event) {
      onNotif(event);
    });
  }

  void setReminder(SholatReminderModel reminderModel) {
    repo.showScheduledNotification(reminderModel);
  }

  void cancelReminder(int id) {
    repo.cancelNotification(id);
  }

  void onNotif(String? payload) {
    emit(SholatReminderOnNotif(payload));
  }

  @override
  Future<void> close() {
    repoSubscription.cancel();
    return super.close();
  }
}
