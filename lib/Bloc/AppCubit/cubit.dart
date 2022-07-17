//import 'dart:ffi';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:user_profile_shared_preferences_example/Bloc/AppStates/states.dart';
import 'package:user_profile_shared_preferences_example/dio_helper/dio_helper.dart';
//import 'package:user_profile_shared_preferences_example/page/edit_profile_page.dart';
import 'dart:convert' as convert ;

import '../../model/User_Model/user_model.dart';


class AppCubit extends Cubit<AppStates>{

  AppCubit() : super(InitialState());


  static AppCubit get(context) => BlocProvider.of(context);
  UserModel ?userModel;


   Future <void> getInteraction({
    required String diseaseName
   })async{

    DioHelper.postDate(url: '',
        data: {
          "path": "$diseaseName"
        }).then((value) {
      print('///////////////////////////Result form machine ///////////////////////////////////////////////////////');
      print(value.data);
      print('///////////////////////////Result form machine ///////////////////////////////////////////////////////');
      emit(GetInteractionSuccessState());

    }).catchError((error){
         print('/////////////////////////////////');
         print(error.toString());

         emit(GetInteractionErrorState());
    });


  }

  void uploadProfile({

    String? name,
    String? about,
    String? email,
    String? imagePath,
    String? uId,
    String? age,
    String? phoneNumber,


  }){

    UserModel userModel= UserModel(
        fullName: name,
        bio: about,
        email: email,
        uId: uId,
        image: imagePath,
        age: age,
        phoneNumber: phoneNumber
    );

    FirebaseFirestore.instance.collection('users').doc(currentUser.uid).update(
        userModel.toMap()
    ).then((value) {
      print('Upload Success');
      emit(UploadProfileSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(UploadProfileErrorState());

    });
  }
  FirebaseAuth? _firebaseAuth;


  FirebaseAuth get firebaseAuth {
    if (_firebaseAuth == null) {
      _firebaseAuth = FirebaseAuth.instance;
    }
    return _firebaseAuth!;
  }

  Stream<User?> get userChanges => firebaseAuth.userChanges();
  User get currentUser {
    return firebaseAuth.currentUser!;
  }
  Future<void> getProfile(context) async{
    emit(GetProfileLoadingState());
      FirebaseFirestore.instance.collection('users').doc(currentUser.uid).get().then((value) {

        userModel=UserModel.formJson(value.data()!);

        print('Get Success');
        print(userModel!.phoneNumber);

        emit(GetProfileSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(GetProfileErrorState());
      });
  }


  File? profileImage;

  ImageProvider profile = const AssetImage('assets/images/profile.png');

  var picker = ImagePicker();
  File ?newImage;
  File ?imageFile;
  Future<void> getProfileImage() async {
    final image = await ImagePicker()
        .getImage(source: ImageSource.gallery);

    if (image == null) return;

    final directory = await getApplicationDocumentsDirectory();
    final name = basename(image.path);
    imageFile = File('${directory.path}/$name');
    newImage =
    await File(image.path).copy(imageFile!.path);
    emit(UploadProfileSuccessState());

  }

  String ?imageValue;

  Future uploadUserImage(){

    return firebase_storage.FirebaseStorage.instance.ref()
        .child('users/${Uri.file(imageFile!.path).pathSegments.last}')
        .putFile(imageFile!).then((value) {

      value.ref.getDownloadURL().then((value) {

        print('Upload Success');
        print(value);
        imageValue=value;

        emit(UploadProfileImageSuccessState());

      }).catchError((error){

        print('Error in Upload profileImage ${error.toString()}');
        emit(UploadUserProfileImageErrorState());

      });

    }).catchError((error){

      print('Error in Upload profileImage ${error.toString()}');
      emit(UploadUserProfileImageErrorState());
    });


  }

  List userDiseases =[];

  void uploadUserDiseases(){

    FirebaseFirestore.instance.collection('users').doc(currentUser.uid).update(
        {
          'Diseases': userDiseases.toList()
        }
    ).then((value) {
      emit( UploadDiseasesSuccessState());
    }).catchError((error){
      print ('Error is ${error.toString()}');
      emit( UploadDiseasesErrorState());
    });

  }
  List getDiseases=[] ;

  Future<void> getUserDiseases() async {

    getDiseases = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .get()
        .then((value) {
      emit(GetDiseasesSuccessState());
      return value.data()!['Diseases']; // Access your after your get the data
    }).catchError((error){

      print('Error is ${error.toString()}');
      emit(GetDiseasesErrorState());


    });
/*
    FirebaseFirestore.instance
        .collection('userDiseases').doc('2DnzlDTaYfMqrUX5vQKq')
        .get().then((value) {



      print(getDiseases.length);
      print('sssssssssssssssssssssssssssssssssssssss');
      print(getDiseases[0].toString().length);
      print('sssssssssssssssssssssssssssssssssssssss');

      emit(GetDiseasesSuccessState());


    }).catchError((error){

      print('Error is ${error.toString()}');
      emit(GetDiseasesErrorState());


    });*/


  }


}