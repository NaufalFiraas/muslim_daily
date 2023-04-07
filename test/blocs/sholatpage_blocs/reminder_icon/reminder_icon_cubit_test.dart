import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:muslim_daily/blocs/sholatpage_blocs/reminder_icon/reminder_icon_cubit.dart';
import 'package:muslim_daily/data/repositories/sholatpage_repositories.dart';

class FakeRepo extends Mock implements SholatpageRepositories {}

void main() {
  late SholatpageRepositories fakeRepo;
  late ReminderIconCubit reminderIconCubit;

  setUp(() {
    fakeRepo = FakeRepo();
    reminderIconCubit = ReminderIconCubit(fakeRepo);
  });

  test('Initial state: IconSholatReminderChange()', () {
    expect(reminderIconCubit.state, const IconSholatReminderChange());
  });

  group('Icon state tests: ', () {
    blocTest<ReminderIconCubit, IconSholatReminderState>(
      'set to true case: ',
      build: () => ReminderIconCubit(fakeRepo),
      act: (cubit) {
        cubit.setIconReminderValue(true);
      },
      expect: () => [const IconSholatReminderChange(true)],
    );

    blocTest<ReminderIconCubit, IconSholatReminderState>(
      'set to false case: ',
      build: () => ReminderIconCubit(fakeRepo),
      act: (cubit) {
        cubit.setIconReminderValue(false);
      },
      expect: () => [const IconSholatReminderChange(false)],
    );
  });

  group('Get and set value case: ', () {
    blocTest<ReminderIconCubit, IconSholatReminderState>(
      'Save case: ',
      build: () => ReminderIconCubit(fakeRepo),
      act: (cubit) {
        when(() => fakeRepo.saveIconStatusToProvider(1, false))
            .thenAnswer((_) => Future.value());
        cubit.saveStatusToPref(1, false);
      },
      expect: () => [],
    );
    blocTest<ReminderIconCubit, IconSholatReminderState>(
      'Get null value case: ',
      build: () => ReminderIconCubit(fakeRepo),
      act: (cubit) {
        when(() => fakeRepo.getIconStatusFromProvider(1))
            .thenAnswer((_) => Future.value());
        cubit.getStatusFromPref(1);
      },
      expect: () => [const IconSholatReminderChange(false)],
    );
    blocTest<ReminderIconCubit, IconSholatReminderState>(
      'Get true value case: ',
      build: () => ReminderIconCubit(fakeRepo),
      act: (cubit) {
        when(() => fakeRepo.getIconStatusFromProvider(1))
            .thenAnswer((_) => Future.value(true));
        cubit.getStatusFromPref(1);
      },
      expect: () => [const IconSholatReminderChange(true)],
    );
  });
}
