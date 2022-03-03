part of 'register_cubit.dart';

@freezed
class RegisterState with _$RegisterState {
  const factory RegisterState({
    @Default(false) bool isRegisterBtnEnabled,
  }) = _RegisterState;
}