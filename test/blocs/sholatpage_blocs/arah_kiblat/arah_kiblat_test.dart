import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:muslim_daily/blocs/sholatpage_blocs/arah_kiblat/arah_kiblat_cubit.dart';
import 'package:muslim_daily/data/models/arah_kiblat.dart';
import 'package:muslim_daily/data/repositories/sholatpage_repositories.dart';

class MockRepo extends Mock implements SholatpageRepositories {}

void main() {
  late ArahKiblatCubit arahKiblatCubit;
  late SholatpageRepositories repo;

  setUp(() {
    repo = MockRepo();
    arahKiblatCubit = ArahKiblatCubit(repo);
  });

  test('Initial condition: ArahKiblatLoading()', () {
    expect(arahKiblatCubit.state, equals(ArahKiblatLoading()));
  });

  blocTest<ArahKiblatCubit, ArahKiblatState>(
    'Failed Case: ArahKiblatError()',
    build: () => ArahKiblatCubit(repo),
    act: (cubit) {
      when(() => repo.getKiblatDirection())
          .thenAnswer((_) => Future.value(null));
      cubit.getArahKiblat();
    },
    expect: () => <ArahKiblatState>[
      ArahKiblatLoading(),
      const ArahKiblatError('Gagal mendapatkan arah kiblat'),
    ],
  );

  blocTest<ArahKiblatCubit, ArahKiblatState>(
    'Success Case: ArahKiblatLoaded()',
    build: () => ArahKiblatCubit(repo),
    act: (cubit) {
      when(() => repo.getKiblatDirection()).thenAnswer(
        (_) => Future.value(
          const ArahKiblat('Malang', 294.2),
        ),
      );
      cubit.getArahKiblat();
    },
    expect: () => <ArahKiblatState>[
      ArahKiblatLoading(),
      const ArahKiblatLoaded(ArahKiblat('Malang', 294.2)),
    ],
  );
}
