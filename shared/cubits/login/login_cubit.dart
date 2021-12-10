import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medtient/models/save_user_data_model.dart';
import 'login_states.dart';

class LogInCubit extends Cubit<LoginStates> {
  static LogInCubit get(context) => BlocProvider.of(context);

  LogInCubit() : super(initialState());
  UserDataModel userDataModel;

  bool isAppear = true;
  IconData Icon = FontAwesomeIcons.eye;

  void isShown() {
    isAppear = !isAppear;
    isAppear ? Icon = FontAwesomeIcons.eye : Icon = FontAwesomeIcons.eyeSlash;
    emit(isAppearState());
  }

  dynamic radioValues;
  var disController = TextEditingController();

  // GoogleSignInAccount get user => _user;
  //
  // final googleSignIn = GoogleSignIn();
  //
  // GoogleSignInAccount? _user;
  //
  // Future googleLogin() async
  // {
  //   // get user && user data
  //   final googleUser = await googleSignIn.signIn();
  //   // if his data is null or not
  //   if (googleUser == null) {
  //     return null;
  //   }
  //   else {
  //     _user = googleUser;
  //   }
  //   final googleAuth = await googleUser.authentication;
  //   final credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken
  //   );
  //   await FirebaseAuth.instance.signInWithCredential(credential);
  //   emit(GoogleAuthState());
  // }
  String dropdownValue;
  void saveDrop(String value)
  {
    dropdownValue = value;
    emit(DropState());
  }

  void LogIn({
    @required String email,
    @required String password,

  }) async
  {
    emit(LogInAuthStateLoading());
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
    ).then((value) {
      emit(LogInAuthStateSuccess(value));
    }).catchError((onError) {
      emit(LogInAuthStateError(onError));
    });
  }

  void logOut() {
    FirebaseAuth.instance.signOut();
    emit(LogOutAuthStateSuccess());
  }

  void getData(uId) async
  {
    await FirebaseFirestore.instance.collection('users').doc(uId).get().then((
        value) {
      userDataModel = UserDataModel.fromJson(value.data());
      print('userDataModel  ${value.data()}');
      print(uId);
      emit(GetDataSuccessState());
    }).catchError((onError) {
      print('Errrrrror UserDataModel $onError');
      emit(GetDataErrorState());
    });
  }
  void saveSignData({
     name,
     email,
     String uId,
     String phone,
     String password,
     String type ,
      String section,
     String dis_mas,
  }) {
    userDataModel = UserDataModel(
        name: name,
        email: email,
        phone: phone,
        password: password,
        uid: uId,
        type: type,
        section: section,
        dis_mas: dis_mas,
      image:'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
    );
    FirebaseFirestore.instance.collection('users').doc(uId).set(
        userDataModel.toMap()).then((value) {
      emit(SaveDataStateSuccess(uId));
    }).catchError((onError) {
      emit(SaveDataStateError());
    });
  }
   String uId;
  void signUp({
    @required String name,
    @required String email,
    @required String phone,
    @required String password,
  }) async
  {
    emit(SignUpAuthStateLoading());
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email, password: password).then((value) {
       uId = value.user.uid;
      saveSignData(
        email: email,
        name: name,
        dis_mas: disController.text,
        type: radioValues,
        phone: phone,
        password: password,
        section: dropdownValue,
        uId: value.user.uid,
      );
    }).catchError((onError) {
      emit(SignUpAuthStateError(onError));
    });
  }

  // void updateData({
  //   @required String phone,
  //   @required String email,
  //   @required String name,
  //   @required String password,
  //   @required String type,
  //    @required String dis_mas,
  //   context,
  // }) {
  //   userDataModel = UserDataModel(phone: phone,
  //       email: email,
  //       name: name,
  //       password: password,
  //       uid: uId,
  //       type: type,
  //       dis_mas: dis_mas,
  //     image: 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'
  //   );
  //   FirebaseFirestore.instance.collection('users').doc(uId).set(userDataModel.toMap()).then((value) {
  //   emit(UpdateDataSuccess());
  //   }).catchError((onError){
  //     emit(UpdateDataError());
  //   });
  // }
}