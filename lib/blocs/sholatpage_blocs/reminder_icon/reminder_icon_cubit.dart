import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:muslim_daily/data/repositories/sholatpage_repositories.dart';

part 'reminder_icon_state.dart';

class ReminderIconCubit extends Cubit<IconSholatReminderState> {
  late final SholatpageRepositories repo;

  ReminderIconCubit([SholatpageRepositories? optionalRepo])
      : super(const IconSholatReminderChange()) {
    repo = optionalRepo ?? SholatpageRepositories();
  }

  void setIconReminderValue(bool value) {
    emit(IconSholatReminderChange(value));
  }

  void saveStatusToPref(int index, bool value) async {
    await repo.saveIconStatusToProvider(index, value);
  }

  void getStatusFromPref(int index) async {
    bool? result = await repo.getIconStatusFromProvider(index);
    emit(IconSholatReminderChange(result ?? false));
  }
}
