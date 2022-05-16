import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:muslim_daily/data/models/sholatpage_model.dart';
import 'package:muslim_daily/data/repositories/sholatpage_repositories.dart';

part 'add_sholat_time_event.dart';

part 'add_sholat_time_state.dart';

class AddSholatTimeBloc extends Bloc<AddSholatTimeEvent, AddSholatTimeState> {
  final SholatpageRepositories sholatpageRepositories;

  AddSholatTimeBloc(this.sholatpageRepositories)
      : super(AddSholatTimeLoading()) {
    on<AddSholatTimeEvent>((event, emit) => _addSholatTime(event, emit));
  }

  void _addSholatTime(
      AddSholatTimeEvent event, Emitter<AddSholatTimeState> emit) async {
    emit(AddSholatTimeLoading());
    SholatpageModel? sholatpageModel =
        await sholatpageRepositories.getSholatData();
    sholatpageModel == null
        ? emit(AddSholatTimeFailed())
        : emit(
            AddSholatTimeSuccess(sholatpageModel),
          );
  }
}
