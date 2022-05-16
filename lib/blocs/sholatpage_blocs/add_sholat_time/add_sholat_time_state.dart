part of 'add_sholat_time_bloc.dart';

abstract class AddSholatTimeState extends Equatable {
  const AddSholatTimeState();
}

//  Loading
class AddSholatTimeLoading extends AddSholatTimeState {
  @override
  List<Object> get props => [];
}

//  Success
class AddSholatTimeSuccess extends AddSholatTimeState {
  final SholatpageModel sholatpageModel;

  const AddSholatTimeSuccess(this.sholatpageModel);

  @override
  List<Object?> get props => [sholatpageModel];
}

//  Failed
class AddSholatTimeFailed extends AddSholatTimeState {
  @override
  List<Object?> get props => [];
}
