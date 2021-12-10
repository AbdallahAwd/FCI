abstract class HomeStates {}
class initialState extends HomeStates {}
class NavChange extends HomeStates {}
class DropState extends HomeStates {}
class CancelImage extends HomeStates {}
class LogOutAuthStateSuccess extends HomeStates {}
class orderSaveSuccess extends HomeStates {}

///get stack
class GetStackSuccess extends HomeStates {}
class GetStackSuccess2 extends HomeStates {}
class GetDataSuccess extends HomeStates {}
class GetDataErrorState extends HomeStates {}

///update data
class UpdateDataErrorState extends HomeStates {}
class UpdateDataSuccessState extends HomeStates {}
class UpdateDataLoadingState extends HomeStates {}

///reset pass
class ResetDataSuccess extends HomeStates {}
class ResetDataLoading extends HomeStates {}
class ResetDataError extends HomeStates {}
///image
class GetImageProductLoadingState extends HomeStates {}
class GetImageProductSuccessState extends HomeStates {}
class GetImageProductErrorState extends HomeStates {}
///prof image
class UploadProfileImageLoading extends HomeStates {}
class UploadProfileImageError extends HomeStates {}
class UploadProfileImageSuccess extends HomeStates {}

///send message
class SendMessageSuccess extends HomeStates {}
class SendMessageLoading extends HomeStates {}
class SendMessageError extends HomeStates {}
///listen to chat
class ListenMessageSuccess extends HomeStates {}
///getmessage
class GetNameSuccess extends HomeStates {}
class GetNameError extends HomeStates {}
///delete message
class DeleteMessageSuccess extends HomeStates{}
class DeleteMessageError extends HomeStates{}
///Edit message
class EditMessageSuccess extends HomeStates{}
class EditMessageError extends HomeStates{}
///get File
class GetFileSuccess extends HomeStates{}
class UploadFileSuccess extends HomeStates{}
class UploadFileLoading extends HomeStates{}
class UploadFileError extends HomeStates{}

///open file chat
class OpenFileLoadingState extends HomeStates {}
class OpenFileSuccessState extends HomeStates {}




