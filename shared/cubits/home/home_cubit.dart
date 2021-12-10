import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:medtient/models/get_stack_data.dart';
import 'package:medtient/models/message.dart';
import 'package:medtient/models/save_user_data_model.dart';
import 'package:medtient/modules/chats/chats.dart';
import 'package:medtient/modules/home/home.dart';
import 'package:medtient/modules/user/user.dart';
import 'package:medtient/shared/cubits/home/home_states.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(initialState());

  static HomeCubit get(context) => BlocProvider.of(context);
  int indexC = 1;

  void onChanged(index)
  {

    indexC = index;
    emit(NavChange());
  }

  List<GButton> items = const [
    GButton(
      icon: FontAwesomeIcons.user,
      text: 'Profile',
    ),
    GButton(
      icon: FontAwesomeIcons.home,
      text: 'Home',
    ),
    GButton(
      icon: Icons.chat,
      text: 'Pchat',
    ),
  ];
  List<String> title =
  [
    'Profile',
    'Home',
    'Pchat'
  ];
  List<Widget> screens =
  [
    Users(),
    Home(),
    Chats(),
  ];

  List <GetStack> stackItems = [];
  void getStackData()
  {
    FirebaseFirestore.instance.collection('FCIM2').orderBy('term',descending: false ).snapshots().listen((value)
    {
      stackItems = [];
      for(var element in value.docs)
        {
          stackItems.add(GetStack.fromJson(element.data()));
        }
      emit(GetStackSuccess());
    });
  }
  List <GetStack> sheetsItem = [];
  List <String> sheetsItemId = [];
  void getSheets()
  {
    FirebaseFirestore.instance.collection('sheets2').snapshots().listen((value) {
      sheetsItem = [];
      sheetsItemId = [];
      for(var element in value.docs)
        {
          sheetsItemId.add(element.id);
          sheetsItem.add(GetStack.fromJson(element.data()));
        }
      emit(GetStackSuccess2());
    });
  }
  UserDataModel userDataModel2;
  void getData(uId) async
  {
    await FirebaseFirestore.instance.collection('users').doc(uId).get().then((
        value) {
      userDataModel2 = UserDataModel.fromJson(value.data());
      print('userDataModel 2 ${value.data()}');
      print(uId);
      // emit(GetDataSuccessState());
      emit(GetDataSuccess());
    }).catchError((onError) {
      print('Errrrrror UserDataModel2 $onError');
      emit(GetDataErrorState());
    });
  }

  void updateData({
    @required String name,
    @required String phone,
     String image,
  })
  {
    emit(UpdateDataLoadingState());
    userDataModel2 = UserDataModel(
      dis_mas: userDataModel2.dis_mas,
      name: name,
      phone: phone,
      password: userDataModel2.password,
      type: userDataModel2.type,
      email: userDataModel2.email,
      uid: userDataModel2.uid,
      image: image,
    );
    FirebaseFirestore.instance.collection('users').doc(userDataModel2.uid).update(userDataModel2.toMap()).then((value) {
      emit(UpdateDataSuccessState());
    }).catchError((onError){
      emit(UpdateDataErrorState());
    });
  }

  void resetPassword(email)
  {
    emit(ResetDataLoading());
    FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((value) {
      emit(ResetDataSuccess());
    }).catchError((onError){
      print('Errorrrrr : $onError');
      emit(ResetDataError());
    });
  }

   File profileImage;

  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    emit(GetImageProductLoadingState());
    final profileImagePicker =
    await picker.pickImage(source: ImageSource.gallery);
    if (profileImagePicker != null) {
      profileImage = File(profileImagePicker.path);
      emit(GetImageProductSuccessState());
    } else {
      emit(GetImageProductErrorState());
    }
  }

  void updateImage({
  @required String phone,
  @required String name,

  }) {
    emit(UploadProfileImageLoading());
    if(profileImage != null) {
      firebase_storage.FirebaseStorage.instance
          .ref()
          .child('profile/${Uri.file(profileImage.path).pathSegments.last}')
          .putFile(profileImage as File)
          .then((p0) {
        p0.ref.getDownloadURL().then((value) {
          updateData(
            phone: phone,
            name: name,
            image: value,
          );
          emit(UploadProfileImageSuccess());
        }).catchError((onError) {
          emit(UploadProfileImageError());
        });
      }).catchError((onError) {
        emit(UploadProfileImageError());
      });
    }
    else
      {
        updateData(phone: phone , name: name ,image: userDataModel2.image??'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',);
      }
    }
  Message message;

  void sendMessage({
    @required String text,
     String image,
    String fileUrl,
    String fileName
  })
  {
    emit(SendMessageLoading());
    message = Message(
      text: text,
      profileImage: userDataModel2.image,
      senderId: userDataModel2.uid,
      image: image,
      dateTime: DateFormat.jm().format(DateTime.now()),
      time: DateTime.now().toString(),
      name: userDataModel2.name,
      fileUrl: fileUrl,
      fileName:fileName,
    );
    FirebaseFirestore.instance.collection('chat').add(message.toMap()).then((value) {
      emit(SendMessageSuccess());
    }).catchError((onError)
    {
      emit(SendMessageError());
    });
  }
  List <Message> messages = [];
  List <String> messageId = [];
  void getMessage()
  {
    FirebaseFirestore.instance.collection('chat').orderBy('time' , descending: true).snapshots().listen((event) {
      messages = [];
      messageId = [];
      for(var element in event.docs)
        {
          messageId.add(element.id);
          messages.add(Message.fromJson(element.data()));
        }
      emit(ListenMessageSuccess());
    });
  }

  void deleteMessage(String docId)
  {
    FirebaseFirestore.instance.collection('chat').doc(docId).delete().then((value) {
      emit(DeleteMessageSuccess());
    }).catchError((onError){
      emit(DeleteMessageError());
    });
  }
  void editMessage({
  @required String text,
  @required String index,
})
  {
    message = Message(
      name: userDataModel2.name,
      senderId: userDataModel2.uid,
      time: DateFormat.jms().format(DateTime.now()),
      dateTime: DateFormat.jm().format(DateTime.now()),
      text: text,
      profileImage: userDataModel2.image,
    );
    FirebaseFirestore.instance.collection('chat').doc(index).update(message.toMap()).then((value) {
      emit(EditMessageSuccess());
    }).catchError((onError){
      emit(EditMessageError());
    });
  }


  File image;

  var pickerImage = ImagePicker();

  Future<void> getImage() async
  {
    emit(GetImageProductLoadingState());
    final imagePicker =
    await pickerImage.pickImage(source: ImageSource.gallery);
    if (imagePicker != null) {
      image = File(imagePicker.path);
      emit(GetImageProductSuccessState());
    } else {
      emit(GetImageProductErrorState());
    }
  }

  void cancelImage()
  {
    image = null;
    file = null;

    emit(CancelImage());
  }
  void sendImage({
    @required String text,
  }) {
    emit(UploadProfileImageLoading());
    if(image != null) {
      firebase_storage.FirebaseStorage.instance
          .ref()
          .child('chat/${Uri.file(image.path).pathSegments.last}')
          .putFile(image)
          .then((p0) {
        p0.ref.getDownloadURL().then((value) {
          sendMessage(
            text: text,
            image: value,

          );
          emit(UploadProfileImageSuccess());
        }).catchError((onError) {
          emit(UploadProfileImageError());
        });
      }).catchError((onError) {
        emit(UploadProfileImageError());
      });
    }
    else
    {
      sendMessage(
        text: text,
      );
    }
  }
  File file;
  String fileName;
  void getFileLocally() async
  {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false , type: FileType.custom,allowedExtensions: ['pdf' , 'doc' ,'xml' , 'docx' , 'xlsx']);
    if(result == null) return;
    final path = result.files.single.path;
    fileName = result.files.last.name;
    file = File(path);
    emit(GetFileSuccess());
  }
  var ref;
  void sendFile({
  String text,
})
  {

    emit(UploadFileLoading());
    if(file != null) {
      ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('file/${Uri.file(file.path).pathSegments.last}');
          ref.putFile(file)
          .then((p0) {
        p0.ref.getDownloadURL().then((value) {
          sendMessage(
            text: text,
            fileUrl: value,
            fileName: fileName
          );

              emit(UploadFileSuccess());
        }).catchError((onError) {
          emit(UploadFileError());
        });
      }).catchError((onError) {
        emit(UploadFileError());
      });
    }
    else
    {
      sendMessage(
        text: text,
      );
    }
  }


  Future openFile (String url , String fileName) async
  {
    final file = await downloadFile(url , fileName);
    if(file == null) return;
    print('Path: ${file.path}');
    OpenFile.open(file.path);
  }
  Future<File> downloadFile(String url , String fileName)async
  {
    final appStorage = await getApplicationDocumentsDirectory();
    final file = File('/${appStorage.path}/$fileName');
    emit(OpenFileLoadingState());
    try
    {
      final response = await Dio().get(
        url,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          receiveTimeout: 0,
        ),
      );
      emit(OpenFileSuccessState());

      final raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();
      return file;
    } catch (e){
      return null;
    }
  }
}
