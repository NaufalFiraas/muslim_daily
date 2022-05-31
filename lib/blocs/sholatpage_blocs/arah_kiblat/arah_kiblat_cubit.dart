import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:muslim_daily/data/models/arah_kiblat.dart';
import 'package:muslim_daily/data/repositories/sholatpage_repositories.dart';

part 'arah_kiblat_state.dart';

class ArahKiblatCubit extends Cubit<ArahKiblatState> {
  final SholatpageRepositories repo;

  ArahKiblatCubit(this.repo) : super(ArahKiblatLoading());

  void getArahKiblat() async {
    emit(ArahKiblatLoading());
    ArahKiblat? result = await repo.getKiblatDirection();
    if (result == null) {
      emit(const ArahKiblatError('Gagal mendapatkan arah kiblat'));
    } else {
      emit(ArahKiblatLoaded(result));
    }
  }
}
