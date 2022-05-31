part of 'arah_kiblat_cubit.dart';

abstract class ArahKiblatState extends Equatable {
  const ArahKiblatState();
}

class ArahKiblatLoading extends ArahKiblatState {
  @override
  List<Object> get props => [];
}

class ArahKiblatError extends ArahKiblatState {
  final String message;

  const ArahKiblatError(this.message);

  @override
  List<Object?> get props => [message];
}

class ArahKiblatLoaded extends ArahKiblatState {
  final ArahKiblat arahKiblat;

  const ArahKiblatLoaded(this.arahKiblat);

  @override
  List<Object?> get props => [arahKiblat];
}
