abstract class SubStates {}
class initialState extends SubStates{}
class Toggle extends SubStates{}
class GetORSuccess extends SubStates{}
class GetSheetsSuccess extends SubStates{}
class GetExamsSuccess extends SubStates{}
class GetFileSuccess extends SubStates{}
class OpenFileLoadingState extends SubStates{}
///Update to visited
class SaveSuccessState extends SubStates{}
class SaveErrorState extends SubStates{}

///image loading
class GetImageProductLoading extends SubStates{}
class GetImageProductSuccess extends SubStates{}
class GetImageProductError extends SubStates{}
///add share
class AddShareSuccess extends SubStates{}
class UploadingImage extends SubStates{}
class AddShareError extends SubStates{}
///listen file
class GetFiles extends SubStates{}
