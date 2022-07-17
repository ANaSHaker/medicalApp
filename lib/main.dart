import 'package:animated_theme_switcher/animated_theme_switcher.dart';
// @dart=2.9

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_profile_shared_preferences_example/Bloc/AppCubit/cubit.dart';
import 'package:user_profile_shared_preferences_example/Bloc/AppStates/states.dart';
import 'package:user_profile_shared_preferences_example/appOpening/splash_screen.dart';
import 'package:user_profile_shared_preferences_example/cash_helper.dart';
import 'package:user_profile_shared_preferences_example/dio_helper/dio_helper.dart';

import 'package:user_profile_shared_preferences_example/themes.dart';
import 'package:user_profile_shared_preferences_example/utils/user_preferences.dart';

import 'add_new_medicine/add_new_medicine.dart';
import 'appOpening/onboarding_screen.dart';
import 'constants/colors.dart';
import 'home/alarm_page.dart';
import 'navigationBarPages/first_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await DioHelper.init();
  await CashHelper.init();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await UserPreferences.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'User Profile';

  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.getUser();

    return MultiBlocProvider(
    providers: [
    BlocProvider(create:(context)=>    AppCubit()..getProfile(context)..getUserDiseases(),),


    ],
    child: ThemeProvider(

            initTheme: user.isDarkMode! ? MyThemes.darkTheme : MyThemes.lightTheme,
            child: Builder(
              builder: (context) => MaterialApp(
                  theme: ThemeData(
                      fontFamily: "Popins",
                      //primaryColor: Color.fromRGBO(7, 190, 200, 1),
                      primaryColor: KMainColor,
                      textTheme: TextTheme(
                          headline1: ThemeData.light().textTheme.headline1!.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 38.0,
                            fontFamily: "Popins",
                          ),
                          headline5: ThemeData.light().textTheme.headline1!.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 17.0,
                            fontFamily: "Popins",
                          ),
                          headline3: ThemeData.light().textTheme.headline3!.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 20.0,
                            fontFamily: "Popins",
                          ))),
                initialRoute: CashHelper.getData(key: "firstOpen") == null ? "first" : "/",
                routes: {
                  "/": (context) => Splash(),
                  "/home": (context) => Alarm(),
                  "/add_new_medicine": (context) => AddNewMedicine(),
                  "first": (context)=> WelcomeScreen(),
                },
                  debugShowCheckedModeBanner: false,
                  title: title,

              ),
            ),
          )
    );
  }
}
