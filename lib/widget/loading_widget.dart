import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:user_profile_shared_preferences_example/constants/colors.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Center(child: LoadingBouncingGrid.square(
        size: 80,backgroundColor: KMainColor,)),
    );
  }
}
