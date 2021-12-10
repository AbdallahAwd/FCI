import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginStates{}

class initialState extends LoginStates{}
class isAppearState extends LoginStates{}
class isChooseState extends LoginStates{}
class DropState extends LoginStates{}

///Log in
class GoogleAuthState extends LoginStates{}
class LogInAuthStateSuccess extends LoginStates
{
  final UserCredential uidValue;

  LogInAuthStateSuccess(this.uidValue);

}
class LogInAuthStateLoading extends LoginStates{}
class LogInAuthStateError extends LoginStates{
  final onError;

  LogInAuthStateError(this.onError);
}
class LogOutAuthStateSuccess extends LoginStates{}

///sign up
class SignUpAuthStateSuccess extends LoginStates{}
class SignUpAuthStateLoading extends LoginStates{}
class SignUpAuthStateError extends LoginStates{
  final onError;

  SignUpAuthStateError(this.onError);
}

///save data
class SaveDataStateSuccess extends LoginStates{
  final uId;

  SaveDataStateSuccess(this.uId);
}
class SaveDataStateError extends LoginStates{}
///get data
class GetDataSuccessState extends LoginStates{}
class GetDataErrorState extends LoginStates{}
///update data
class UpdateDataSuccess extends LoginStates{}
class UpdateDataError extends LoginStates{}