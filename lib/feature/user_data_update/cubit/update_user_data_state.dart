part of 'update_user_data_cubit.dart';

@immutable
abstract class UpdateUserDataState extends Equatable{
  @override
  List<Object?> get props => [];
}

class UpdateUserDataInitial extends UpdateUserDataState {}

class ErrorWhenUpdateState extends UpdateUserDataState {
  final String error;

  ErrorWhenUpdateState(this.error);
}

class SuccessUpdatedUserDataState extends UpdateUserDataState {}

class CommonUpdateUserDataState extends UpdateUserDataState {
  final bool isLoading;
  final bool isMale;
  final String? fnError;
  final String? lnError;
  final String? bdError;

  CommonUpdateUserDataState({
    required this.isLoading,
    required this.isMale,
    this.fnError,
    this.lnError,
    this.bdError,
  });

  CommonUpdateUserDataState copyWith({
    bool? isLoading,
    final bool? isMale,
    final String? fnError,
    final String? lnError,
    final String? bdError,
  }) =>
      CommonUpdateUserDataState(
        isMale: isMale ?? this.isMale,
        fnError: fnError ?? this.fnError,
        lnError: lnError ?? this.lnError,
        bdError: bdError ?? this.bdError,
        isLoading: isLoading ?? this.isLoading,
      );

  @override
  List<Object?> get props => [
    isLoading,
    isMale,
    fnError ?? 0,
    lnError ?? 0,
    bdError ?? 0,
  ];
}
