import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:muslim_daily/blocs/sholatpage_blocs/reminder_icon/reminder_icon_cubit.dart';

void main() {
  late ReminderIconCubit reminderCubit;
  late List<bool> isReminderOn;

  setUp(() {
    isReminderOn = List.generate(7, (index) => false);
    reminderCubit = ReminderIconCubit(isReminderOn);
  });

  test('Initial state: ReminderIconState(false)', () {
    expect(reminderCubit.state, ReminderIconState(isReminderOn));
  });

  blocTest<ReminderIconCubit, ReminderIconState>(
    'Set reminder to true',
    build: () => ReminderIconCubit(isReminderOn),
    act: (cubit) {
      cubit.setReminder(1, true);
    },
    expect: () => <ReminderIconState>[
      const ReminderIconState([false, true, false, false, false, false, false]),
    ],
  );

  blocTest<ReminderIconCubit, ReminderIconState>(
    'Cancel reminder to true then false',
    build: () => ReminderIconCubit(isReminderOn),
    act: (cubit) {
      cubit.setReminder(2, true);
      cubit.setReminder(2, false);
    },
    expect: () => <ReminderIconState>[
      const ReminderIconState([false, false, true, false, false, false, false]),
      const ReminderIconState([false, false, false, false, false, false, false])
    ],
  );
}
