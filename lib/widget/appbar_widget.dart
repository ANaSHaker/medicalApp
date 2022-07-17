import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user_profile_shared_preferences_example/themes.dart';
import 'package:user_profile_shared_preferences_example/utils/user_preferences.dart';

import '../appOpening/login_screens/login.dart';

AppBar buildAppBar(BuildContext context) {
  final user = UserPreferences.getUser();
  final isDarkMode = user.isDarkMode;
  final icon = isDarkMode! ? CupertinoIcons.sun_max : CupertinoIcons.moon_stars;
  FirebaseAuth _auth = FirebaseAuth.instance;

  return AppBar(
    leading: IconButton(
      onPressed: (){
        _auth.signOut();
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => Login()));
      },
      icon: Icon(Icons.logout),
    ),
    backgroundColor: Colors.transparent,
    elevation: 0,
    actions: [
      ThemeSwitcher(
        builder: (context) => IconButton(
          icon: Icon(icon),
          onPressed: () {
            final theme = isDarkMode ? MyThemes.lightTheme : MyThemes.darkTheme;

            final switcher = ThemeSwitcher.of(context);
            switcher.changeTheme(theme: theme);

            final newUser = user.copy(isDarkMode: !isDarkMode);
            UserPreferences.setUser(newUser);
          },
        ),
      ),
    ],
  );
}
