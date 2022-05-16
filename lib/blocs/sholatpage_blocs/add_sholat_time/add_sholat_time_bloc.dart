import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:muslim_daily/data/models/sholatpage_model.dart';

part 'add_sholat_time_event.dart';
part 'add_sholat_time_state.dart';

class AddSholatTimeBloc extends Bloc<AddSholatTimeEvent, AddSholatTimeState> {
  AddSholatTimeBloc() : super(AddSholatTimeInitial()) {
    on<AddSholatTimeEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
