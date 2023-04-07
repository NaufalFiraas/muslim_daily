import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:muslim_daily/blocs/sholatpage_blocs/add_sholat_time/add_sholat_time_bloc.dart';
import 'package:muslim_daily/data/models/sholatpage_model.dart';
import 'package:muslim_daily/data/repositories/sholatpage_repositories.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeSholatpageRepo extends Mock implements SholatpageRepositories {}

void main() {
  late SholatpageRepositories fakeRepo;
  late AddSholatTimeBloc addSholatTimeBloc;
  late SholatpageModel sholatModel;

  setUp(() {
    fakeRepo = FakeSholatpageRepo();
    addSholatTimeBloc = AddSholatTimeBloc(fakeRepo);
    sholatModel = const SholatpageModel(
      city: 'Malang',
      date: 'Rabu, 23/06/2021',
      sholatTime: {
        'Imsak': '04:13',
        'Shubuh': '04:23',
        'Syuruk': '05:41',
        'Dhuhur': '11:38',
        'Ashar': '14:57',
        'Maghrib': '17:27',
        "Isya'": '18:42',
      },
    );
  });

  tearDown(() {
    addSholatTimeBloc.close();
  });

  test('Initial state: AddSholatTimeLoading()', () {
    expect(addSholatTimeBloc.state, AddSholatTimeLoading());
  });

  blocTest<AddSholatTimeBloc, AddSholatTimeState>(
    'Failed case: AddSholatTimeFailed()',
    build: () => AddSholatTimeBloc(fakeRepo),
    act: (bloc) {
      when(() => fakeRepo.getSholatData()).thenAnswer(
        (_) => Future.value(null),
      );
      bloc.add(const AddSholatTimeEvent());
    },
    expect: () => <AddSholatTimeState>[
      AddSholatTimeLoading(),
      AddSholatTimeFailed(),
    ],
  );

  blocTest<AddSholatTimeBloc, AddSholatTimeState>(
    'Success case: AddSholatTimeSuccess(SholatPageModel())',
    build: () => AddSholatTimeBloc(fakeRepo),
    act: (bloc) {
      when(() => fakeRepo.getSholatData()).thenAnswer(
        (invocation) => Future.value(sholatModel),
      );
      bloc.add(const AddSholatTimeEvent());
    },
    expect: () => <AddSholatTimeState>[
      AddSholatTimeLoading(),
      AddSholatTimeSuccess(sholatModel),
    ],
  );
}
