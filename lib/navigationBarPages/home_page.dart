
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_profile_shared_preferences_example/Bloc/AppCubit/cubit.dart';
import 'package:user_profile_shared_preferences_example/Bloc/AppStates/states.dart';
import 'package:user_profile_shared_preferences_example/cash_helper.dart';
import 'package:user_profile_shared_preferences_example/dio_helper/dio_helper.dart';
import 'package:user_profile_shared_preferences_example/dioalog_helper.dart';
import '../constants/colors.dart';
String interaction='';

class HomePage extends StatelessWidget {

  var diseaseController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){

      },
      builder: (context,state){
        return Scaffold(
          // resizeToAvoidBottomInset: false,
          backgroundColor: backgrouColor,
          body: ListView(
                  children:[
                    Padding(
                      //
                      padding: const EdgeInsets.only(top: 40.0),
                      child: CarouselSlider(
                          items: [
                            Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20), image: DecorationImage(image: AssetImage('assets/images/1.jpg'), fit: BoxFit.cover,)),),
                                Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.pink.withOpacity(.3),),)],),
                            Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(image: AssetImage('assets/images/2.jpg'), fit: BoxFit.cover,)),),
                                Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.pink.withOpacity(.3),),)],),
                            Stack(
                              children: [Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                      image: AssetImage('assets/images/3.jpg'),
                                      fit: BoxFit.cover,
                                    )),
                              ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.pink.withOpacity(.3),
                                  ),
                                )
                              ],
                            ),
                            Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                        image: AssetImage('assets/images/4.jpg'),
                                        fit: BoxFit.cover,
                                      )),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.pink.withOpacity(.3),
                                  ),
                                )
                              ],
                            ),
                          ],
                          options: CarouselOptions(
                            height: 170,
                            aspectRatio: 16 / 9,
                            enlargeCenterPage: true,
                            autoPlay: true,
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enableInfiniteScroll: true,
                            autoPlayAnimationDuration: Duration(milliseconds: 800),
                            viewportFraction: .8,
                          )),
                    ),
                    SizedBox(height: 40,),
                    Container(
                        child: Padding(
                          padding: const EdgeInsets.only(top:20.0,bottom: 20, left: 20, right: 20),
                          child: TextFormField(
                              maxLines: 7,
                              controller: diseaseController,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                              decoration: InputDecoration(
                                fillColor: Colors.pink.withOpacity(0.3),

                                filled: true,
                                hintText: "Enter Drug Name",
                                hintStyle: TextStyle(
                                    color: Colors.white
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: BorderSide(
                                    // color: Colors.pink,

                                  ),),)),
                        )),

                    // {'interaction rate ': array([[0.9999207]], dtype=float32)}, {'Interaction is ': 'Diffuse Cerebral Sclerosis of Schilder'})
                    Container(
                      margin: EdgeInsets.fromLTRB(80, 10, 80, 10),
                      child: MaterialButton(

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                        ),
                        padding: EdgeInsets.fromLTRB(50, 20, 50, 20),
                        color: Color(0xFFA50F59),
                        onPressed: (){
                           test(disease: diseaseController.text).then((value) {
                             Navigator.push(context, MaterialPageRoute(builder: (_){

                               return DialogHelper();

                             }));

                           });

                        },
                        child: Text('Result',style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w500
                        ),),
                      ),
                    )
                  ]

              ),


        );
      },
    );
  }
}


Future <void> test({
  required String disease
})async{
  DioHelper.postDate(url: '',
      data: {
        "path": disease
      }).then((value) {
    print('///////////////////////////Result form machine ///////////////////////////////////////////////////////');
    interaction=value.data;
    CashHelper.saveData(key: 'to',value: value.data);
    print(interaction);
    print('///////////////////////////Result form machine ///////////////////////////////////////////////////////');

    print(value.data['Interaction is ']);

    interaction=value.data()['Interaction is '];

    print('///////////////////////////Result form machine ///////////////////////////////////////////////////////');

  }).catchError((error){
    print('/////////////////////////////////');
    print(error.toString());

  });
}