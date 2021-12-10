import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medtient/models/get_subjects.dart';
import 'package:medtient/shared/compnents/component.dart';
import 'package:medtient/shared/cubits/subjects/subjects_states.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SubCubit extends Cubit<SubStates>
{
  SubCubit() : super(initialState());

  static SubCubit get(context) => BlocProvider.of(context);

  Future <void> delay(int miliseconds) async
  {
    await Future.delayed(Duration(milliseconds: miliseconds));
  }
  List<GetSubjects> or = [];
  List<GetSubjects> multi = [];
  List<GetSubjects> ds = [];
  List<GetSubjects> oop = [];
  List<GetSubjects> webDev = [];
  List<GetSubjects> sysA = [];
  GetSubjects subjects;
 void getSubjectLec(String collectionName)
 {
   FirebaseFirestore.instance.collection('subjects').doc(collectionName).collection(collectionName).orderBy('name').snapshots().listen((event) {
     or = [];
     multi = [];
     ds = [];
     oop = [];
     webDev = [];
     sysA = [];
     for(var element in event.docs)
       {
         or.add(GetSubjects.fromJson(element.data()));
         multi.add(GetSubjects.fromJson(element.data()));
         ds.add(GetSubjects.fromJson(element.data()));
         oop.add(GetSubjects.fromJson(element.data()));
         webDev.add(GetSubjects.fromJson(element.data()));
         sysA.add(GetSubjects.fromJson(element.data()));
       }
     emit(GetORSuccess());
   });
 }


  List<GetSubjects> orSheet =[];
  List<GetSubjects> multiSheet =[];
  List<GetSubjects> DSSheet =[];
  List<GetSubjects> sysASheet =[];
  List<GetSubjects> oopSheet =[];
  List<GetSubjects> webDevSheet =[];
 void getSheets(String subjectName)
 {
   FirebaseFirestore.instance.collection('subjects').doc(subjectName).collection('sheets').orderBy('name').snapshots().listen((event) {
     orSheet =[];
     multiSheet =[];
     DSSheet =[];
     sysASheet =[];
     oopSheet =[];
     webDevSheet =[];
     for(var element in event.docs)
       {
         orSheet.add(GetSubjects.fromJson(element.data()));
         multiSheet.add(GetSubjects.fromJson(element.data()));
         DSSheet.add(GetSubjects.fromJson(element.data()));
         sysASheet.add(GetSubjects.fromJson(element.data()));
         oopSheet.add(GetSubjects.fromJson(element.data()));
         webDevSheet.add(GetSubjects.fromJson(element.data()));
       }
     emit(GetSheetsSuccess());
   });
 }
 List<GetSubjects> orExam =[];
 List<GetSubjects> multiExam =[];
 List<GetSubjects> DSExam =[];
 List<GetSubjects> sysAExam =[];
 List<GetSubjects> oopExam =[];
 List<GetSubjects> webDevExam =[];
 void getExam(String subjectName)
 {
   FirebaseFirestore.instance.collection('subjects').doc(subjectName).collection('exams').orderBy('name').snapshots().listen((event) {
     orExam =[];
     multiExam =[];
     DSExam =[];
     sysAExam =[];
     oopExam =[];
     webDevExam =[];
     for(var element in event.docs)
       {
         orExam.add(GetSubjects.fromJson(element.data()));
         multiExam.add(GetSubjects.fromJson(element.data()));
         DSExam.add(GetSubjects.fromJson(element.data()));
         sysAExam.add(GetSubjects.fromJson(element.data()));
         oopExam.add(GetSubjects.fromJson(element.data()));
         webDevExam.add(GetSubjects.fromJson(element.data()));
       }
     emit(GetExamsSuccess());
   });
 }

  File file;
  String fileName;
  void getFileLocally() async
  {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false , type: FileType.custom,allowedExtensions: ['pdf' , 'doc' ,'xml' , 'docx' , 'xlsx']);
    if(result == null) return;
    final String path = result.files.single.path;
    fileName = result.files.last.name;
    file = File(path);
    emit(GetFileSuccess());
  }

  File image;
  var pickerImage = ImagePicker();

  Future<void> getImage() async
  {
    emit(GetImageProductLoading());
    final imagePicker =
    await pickerImage.pickImage(source: ImageSource.gallery);
    if (imagePicker != null) {
      image = File(imagePicker.path);
      emit(GetImageProductSuccess());
    }
    else
      {
      emit(GetImageProductError());
      }
  }

  void uploadImage({
    @required String name,
    @required String collectionNameImage
  })
  {
    if(image != null) {
      emit(UploadingImage());
      firebase_storage.FirebaseStorage.instance.ref().child('share/${Uri.file(image.path).pathSegments.last}').putFile(image).then((p0) {
      p0.ref.getDownloadURL().then((value) {
        shareAddImage(
        url:value,
        collectionNameImage: collectionNameImage,
        name: name
        );
      }).catchError((onError)
      {

      });
    }).catchError((onError)
    {

    });
    }
    else
      {
        toast(text: 'Add something please');

      }
  }
  void shareAddImage({
  @required String url,
  @required String collectionNameImage,
   String name,
  })
  {
    subjects = GetSubjects(
      url: url,
      name: name,
    );
    FirebaseFirestore.instance.collection('shares').doc('shares').collection(collectionNameImage).add(subjects.toMap()).then((value) {
      emit(AddShareSuccess());
    }).catchError((onError)
    {
      emit(AddShareError());
    });
  }

  List<GetSubjects> orSharesImage =[];
  List<GetSubjects> multiSharesImage =[];
  List<GetSubjects> oopSharesImage =[];
  List<GetSubjects> webDevSharesImage =[];
  List<GetSubjects> dsSharesImage =[];
  List<GetSubjects> sysASharesImage =[];
  void getShareImage(String collectionNameImage)
  {
    FirebaseFirestore.instance.collection('shares').doc('shares').collection(collectionNameImage).snapshots().listen((event) {
      orSharesImage =[];
      multiSharesImage =[];
      oopSharesImage =[];
      webDevSharesImage =[];
      dsSharesImage =[];
      sysASharesImage =[];
      for(var element in event.docs)
        {
          orSharesImage.add(GetSubjects.fromJson(element.data()));
          multiSharesImage.add(GetSubjects.fromJson(element.data()));
          oopSharesImage.add(GetSubjects.fromJson(element.data()));
          webDevSharesImage.add(GetSubjects.fromJson(element.data()));
          dsSharesImage.add(GetSubjects.fromJson(element.data()));
          sysASharesImage.add(GetSubjects.fromJson(element.data()));
        }
      emit(GetFiles());
    });
  }
  void uploadFile(String collectionName)
  {
    if(file != null) {
      emit(UploadingImage());
      firebase_storage.FirebaseStorage.instance.ref().child('share/${Uri.file(file.path).pathSegments.last}').putFile(file).then((p0) {
        p0.ref.getDownloadURL().then((value) {
          shareAddFile(
              url:value,
              collectionNameFile: collectionName,
              name: fileName
          );
        }).catchError((onError)
        {

        });
      }).catchError((onError)
      {

      });
    }
    else
    {
      toast(text: 'Add something please');
    }
  }
  void shareAddFile({
    @required String url,
    @required String collectionNameFile,
    String name,
  })
  {
    subjects = GetSubjects(
      url: url,
      name: name,
    );
    FirebaseFirestore.instance.collection('shares').doc('shares').collection(collectionNameFile).add(subjects.toMap()).then((value) {
      emit(AddShareSuccess());
    }).catchError((onError)
    {
      emit(AddShareError());
    });
  }

  List<GetSubjects> orShareFiles =[];
  List<GetSubjects> multiShareFiles =[];
  List<GetSubjects> oopShareFiles =[];
  List<GetSubjects> webDevShareFiles =[];
  List<GetSubjects> dsShareFiles =[];
  List<GetSubjects> sysAShareFiles =[];
  void getShareFiles(String collectionNameFile)
  {
    FirebaseFirestore.instance.collection('shares').doc('shares').collection(collectionNameFile).snapshots().listen((event) {
      orShareFiles =[];
      multiShareFiles =[];
      oopShareFiles =[];
      webDevShareFiles =[];
      dsShareFiles =[];
      sysAShareFiles =[];
      for(var element in event.docs)
      {
        orShareFiles.add(GetSubjects.fromJson(element.data()));
        multiShareFiles.add(GetSubjects.fromJson(element.data()));
        oopShareFiles.add(GetSubjects.fromJson(element.data()));
        webDevShareFiles.add(GetSubjects.fromJson(element.data()));
        dsShareFiles.add(GetSubjects.fromJson(element.data()));
        sysAShareFiles.add(GetSubjects.fromJson(element.data()));
      }
      emit(GetFiles());
    });
  }
}