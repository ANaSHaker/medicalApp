import 'dart:io';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:user_profile_shared_preferences_example/Bloc/AppCubit/cubit.dart';
import 'package:user_profile_shared_preferences_example/Bloc/AppStates/states.dart';
import 'package:user_profile_shared_preferences_example/constants/colors.dart';
import 'package:user_profile_shared_preferences_example/model/User_Model/user_model.dart';
import 'package:user_profile_shared_preferences_example/model/user.dart';
import 'package:user_profile_shared_preferences_example/utils/user_preferences.dart';
import 'package:user_profile_shared_preferences_example/widget/appbar_widget.dart';
import 'package:user_profile_shared_preferences_example/widget/button_widget.dart';
import 'package:user_profile_shared_preferences_example/widget/profile_widget.dart';

import 'package:path/path.dart';
import 'package:user_profile_shared_preferences_example/model/notification_setting.dart';

class EditProfilePage extends StatefulWidget {
  final String title;
  const EditProfilePage({
    required this.title,
  });
  @override
  _EditProfilePageState createState() => _EditProfilePageState();

}

class _EditProfilePageState extends State<EditProfilePage> {
  var nameController=TextEditingController();
  var ageController=TextEditingController();
  var aboutController=TextEditingController();
  var phoneController=TextEditingController();
  var emailController=TextEditingController();

  @override
  void initState() {
    super.initState();
    user = UserPreferences.getUser();

  }

  @override
  // void dispose() {
  //   controller.dispose();
  //
  //   super.dispose();
  // }

  late User user;


  final allDiseases = Diseases(title: 'All Diseases');

  final diseases = [
    Diseases(title: 'Diabetes Mellitus'),
    Diseases(title: 'Asthma'),
    Diseases(title: 'CADASIL'),
    Diseases(title: 'Breast Neoplasms'),
    Diseases(title: 'Diabetes Mellitus'),
    Diseases(title: 'Paraplegia'),
    Diseases(title: 'Rodrigues Blindness'),
    Diseases(title: 'Hypertension, Diastolic, Resistance To'),
    Diseases(title: 'Renal Failure, Progressive, With Hypertension'),
    Diseases(title: 'Hyperthermia, Cutaneous, With Headaches And Nausea'),
    Diseases(title: 'Insensitivity To Pain With Hyperplastic Myelinopathy'),
    Diseases(title: 'Migraine With Or Without Aura, Susceptibility To, 1'),
  ];

  @override
  Widget build(BuildContext context) =>BlocConsumer<AppCubit,AppStates>(
    listener: (context,state){},
    builder: (context,state){
      nameController.text= AppCubit.get(context).userModel!.fullName ?? "" ;
       ageController.text= AppCubit.get(context).userModel!.age ?? "";
      phoneController.text= AppCubit.get(context).userModel!.phoneNumber ?? "";
      emailController.text= AppCubit.get(context).userModel!.email ?? "";
       aboutController.text= AppCubit.get(context).userModel!.bio ?? "";
      return ThemeSwitchingArea(

      child: Scaffold(
        backgroundColor: Color(0xFF100F1E),
        body: Builder(

          builder: (context) => Scaffold(
            appBar: buildAppBar(context),
            backgroundColor: backgrouColor,
            body: ListView(

              padding: EdgeInsets.symmetric(horizontal: 32),
              physics: BouncingScrollPhysics(),
              children: [
                ProfileWidget(
                  imagePath: (user.imagePath)! ,
                  isEdit: true,
                  onClicked: () async {
                    final image = await ImagePicker()
                        .getImage(source: ImageSource.gallery);

                    if (image == null) return;

                    final directory = await getApplicationDocumentsDirectory();
                    final name = basename(image.path);
                    final imageFile = File('${directory.path}/$name');
                    final newImage =
                    await File(image.path).copy(imageFile.path);
                    // AppCubit.get(context).getProfileImage();

                    setState(() => user = user.copy(imagePath:newImage.path));
                  },
                ),
                const SizedBox(height: 24),
                TextFormField(
                  validator: (value){
                    if (value!.isEmpty)
                    {
                      return('Name is empty');
                    }
                  },
                  style: TextStyle(color: Colors.white),
                  cursorColor: KMainColor,
                  cursorHeight: 25,
                    controller: nameController,
                  //text: AppCubit.get(context).userModel!.fullName!,
                  onChanged: (name) => user = user.copy(name: name),
                  decoration: InputDecoration(
                      //prefixIcon: Icon(Icons.email_outlined,
                        //color: KMainColor,),
                      labelText: 'Full Name',
                      labelStyle: TextStyle(
                          color: KMainColor),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: KMainColor,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: KMainColor,),
                        borderRadius: BorderRadius.circular(20),
                      )
                  ),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  validator: (value){
                    if (value!.isEmpty)
                    {
                      return('Age is empty');
                    }
                  },
                  style: TextStyle(color: Colors.white),
                  cursorColor: KMainColor,
                  cursorHeight: 25,
                  controller: ageController,
                  //text:  AppCubit.get(context).userModel!.age!,
                  onChanged: (age) => user = user.copy(age: age),
                  decoration: InputDecoration(
                      //prefixIcon: Icon(Icons.email_outlined,
                        //color: KMainColor,),
                      labelText: 'Age',
                      labelStyle: TextStyle(
                          color: KMainColor),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: KMainColor,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: KMainColor,),
                        borderRadius: BorderRadius.circular(20),
                      )
                  ),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  validator: (value){
                    if (value!.isEmpty)
                    {
                      return('Phone is empty');
                    }
                  },
                  style: TextStyle(color: Colors.white),
                  cursorColor: KMainColor,
                  cursorHeight: 25,
                  controller: phoneController,
                  //text:  AppCubit.get(context).userModel!.phoneNumber!,
                  onChanged: (phoneNumber) => user = user.copy(phoneNumber: phoneNumber),
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone,
                        color: KMainColor,),
                      labelText: 'Phone Number',
                      labelStyle: TextStyle(
                          color: KMainColor),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: KMainColor,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: KMainColor,),
                        borderRadius: BorderRadius.circular(20),
                      )
                  ),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  validator: (value){
                    if (value!.isEmpty)
                    {
                      return('Email is empty');
                    }
                  },
                  style: TextStyle(color: Colors.white),
                  cursorColor: KMainColor,
                  cursorHeight: 25,
                  //text:  AppCubit.get(context).userModel!.email!,
                  controller: emailController,
                  onChanged: (email) => user = user.copy(email: email),
                  decoration: InputDecoration(

                      prefixIcon: Icon(Icons.email_outlined,
                        color: KMainColor,),
                      labelText: 'Email adress',
                      labelStyle: TextStyle(
                          color: KMainColor),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: KMainColor,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: KMainColor,),
                        borderRadius: BorderRadius.circular(20),
                      )
                  ),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  validator: (value){

                    if (value!.isEmpty)
                    {

                      return('About is empty');
                    }
                  },
                  style: TextStyle(color: Colors.white),
                  cursorColor: KMainColor,
                  cursorHeight: 25,
                  controller: aboutController,

                  maxLines: 5,
                  onChanged: (about) => user = user.copy(about: about),
                  decoration: InputDecoration(
                      //prefixIcon: Icon(Icons.email_outlined,
                        //color: KMainColor,),
                      labelText: 'About',
                      labelStyle: TextStyle(
                          color: KMainColor),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: KMainColor,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: KMainColor,),
                        borderRadius: BorderRadius.circular(20),
                      )
                  ),
                ),
                const SizedBox(height: 24),
                buildToggleCheckbox(allDiseases),
                Divider(),
                Container(
                  height: MediaQuery.of(context).size.height*.5,

                  child: ListView.separated(

                    itemCount: diseases.length,
                    itemBuilder: (context,index){
                      // print(diseases[index].value);
                      // if(diseases[index].value==true){
                      //   AppCubit.get(context).userDiseases.add(diseases[index].title);
                      // }
                      // print(AppCubit.get(context).userDiseases);
                      return buildSingleCheckbox(diseases[index]);
                    },
                    separatorBuilder: (context,index){
                      return
                        SizedBox(height: 10,);
                    },

                  ),
                ),
                 SizedBox(height: 10,),
                ButtonWidget(
                  text: 'Save',
                  onClicked: () {
                    UserPreferences.setUser(user);
                    Navigator.of(context).pop();
                    print(user.email);
                    AppCubit.get(context).userDiseases==[];
                    diseases.map((e) {
                      if(e.value==false || AppCubit.get(context).userDiseases.contains(e.title)){
                        // print(e.value);
                        // print(e.title);
                      }
                      else{
                        print(e.value);
                        print(e.title);
                        AppCubit.get(context).userDiseases.add(e.title);
                      }

                    }).toList();
                     print(AppCubit.get(context).userDiseases);

                    AppCubit.get(context).uploadProfile(
                        name: nameController.text,
                        age: ageController.text,
                        phoneNumber: phoneController.text,
                        email: emailController.text,
                        about: aboutController.text,
                        imagePath: user.imagePath
                    );
                    AppCubit.get(context).uploadUserDiseases();

                    // AppCubit.get(context).uploadUserImage().then((value) {
                    //
                    // });

                  },
                ),
                SizedBox(height: 10,),
              ],
            ),
          ),

        ),
      ),
    );
    },
  );
  Widget buildToggleCheckbox(Diseases disease) => buildCheckbox(
      disease: disease,
      onClicked: () {
        final newValue = !disease.value;

        setState(() {
          allDiseases.value = newValue;
          diseases.forEach((notification) {
            notification.value = newValue;
          });
        });
      });

  Widget buildSingleCheckbox(Diseases disease) => buildCheckbox(
    disease: disease,
    onClicked: () {
      setState(() {
        final newValue = !disease.value;
        disease.value = newValue;

        if (!newValue) {
          allDiseases.value = false;
        } else {
          final allow =
          diseases.every((disease) => disease.value);
          allDiseases.value = allow;
        }
      });
    },
  );

  Widget buildCheckbox({
    required Diseases disease,
    required VoidCallback onClicked,

  }) =>
      ListTile(
        onTap: onClicked,
        leading: Checkbox(
          checkColor: Color(0xFFa50f59),
          activeColor: Color(0xFFa50f59),
          hoverColor: Colors.white24,
          side: BorderSide(
            color: Color(0xFFa50f59), //your desire colour here
            width: 1.5,
          ),

          value: disease.value,
          onChanged: (value) => onClicked(),
        ),
        title: Text(
          disease.title,
          style: TextStyle(fontSize: 15,

              fontWeight: FontWeight.bold),
        ),
      );
}

