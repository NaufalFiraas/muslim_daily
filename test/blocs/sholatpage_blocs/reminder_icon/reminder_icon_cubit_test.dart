import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:muslim_daily/blocs/sholatpage_blocs/reminder_icon/reminder_icon_cubit.dart';

void main() {
  late ReminderIconCubit reminderCubit;

  setUp(() {
    reminderCubit = ReminderIconCubit();
  });

  test('Initial state: ReminderIconState(false)', () {
    expect(reminderCubit.state, const ReminderIconState(false));
  });

  blocTest<ReminderIconCubit, ReminderIconState>(
    'Set reminder: ReminderIconState(true)',
    build: () => ReminderIconCubit(),
    act: (cubit) {
      cubit.setReminder(true);
    },
    expect: () => <ReminderIconState>[
      const ReminderIconState(true),
    ],
  );

  blocTest<ReminderIconCubit, ReminderIconState>(
    'Cancel reminder: ReminderIconState(false)',
    build: () => ReminderIconCubit(),
    act: (cubit) {
      cubit.setReminder(false);
    },
    expect: () => <ReminderIconState>[
      const ReminderIconState(false),
    ],
  );

  blocTest<ReminderIconCubit, ReminderIconState>(
    'Set, cancel reminder: ReminderIconState(true), ReminderIconState(false)',
    build: () => ReminderIconCubit(),
    act: (cubit) {
      cubit.setReminder(true);
      cubit.setReminder(false);
    },
    expect: () => <ReminderIconState>[
      const ReminderIconState(true),
      const ReminderIconState(false),
    ],
  );
}
