import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_profile_shared_preferences_example/constants/colors.dart';

import '../cash_helper.dart';
import 'splash_screen.dart';




class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final int _numPages = 5;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive
            ?Colors.white
            : Colors.white.withOpacity(0.2),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            // stops: [0.1, 0.5],
            colors: [
              Color(0xFF100F2E),
              Color(0xFF100F1E),

            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                alignment: Alignment.centerRight,
                margin: const EdgeInsets.only(right: 10.0, top: 15.0),
                child: InkWell(
                  onTap: () {
                    _pageController.jumpToPage(2); // for regular jump
                    _pageController.animateToPage(2,
                        curve: Curves.decelerate,
                        duration: const Duration(milliseconds: 300));
                  },
                  child:  Text("Skip",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.zero,
                height: MediaQuery.of(context).size.height*0.7,
                child: PageView(
                  physics: const ClampingScrollPhysics(),
                  controller: _pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // ignore: prefer_const_literals_to_create_immutables
                          Center(
                              child: Container(
                                decoration: const BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                    color: Colors.white12),
                                child:  Image(
                                  image: const AssetImage(
                                    'assets/images/icon0_prev_ui.png',
                                  ),
                                  height: MediaQuery.of(context).size.height*0.3,
                                  width: 400.0,
                                ),
                              )),
                          const SizedBox(height: 30.0),
                          Text(
                            "Drug disease interaction",
                            style:  GoogleFonts.oswald(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 24),
                          ),
                          const SizedBox(height: 15.0),
                          Text(
                            "Take the drug name to compare it with the existing medical record of the patient to show the interaction if it is harmful or not",
                            style:  GoogleFonts.oswald(
                                color: Colors.white, fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Center(
                              child: Container(
                                decoration: const BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                    color: Colors.white12),
                                child:  Image(
                                  image: const AssetImage(
                                    'assets/images/icon1_prev_ui.png',
                                  ),
                                  height: MediaQuery.of(context).size.height*0.3,
                                  width: 400.0,
                                ),
                              )),
                          const SizedBox(height: 30.0),
                          Text(
                            "Medical Record",
                            style:  GoogleFonts.oswald(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 24),
                          ),
                          const SizedBox(height: 15.0),
                          Text("patient is able to fill his personal data and his previous medical recordEven he has any chronic diseases or any allergies to compare it with the interred drug to make a result",
                            style: GoogleFonts.oswald(
                                color: Colors.white, fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Center(
                              child: Container(
                                decoration: const BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                    color: Colors.white12),
                                child:  Image(
                                  image: const AssetImage(
                                    'assets/images/icon2_prev_ui.png',
                                  ),
                                  height: MediaQuery.of(context).size.height*0.3,
                                  width: 400.0,
                                ),
                              )),
                          const SizedBox(height: 30.0),
                          Text(
                           "Map",
                            style:  GoogleFonts.oswald(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 24),
                          ),
                          const SizedBox(height: 15.0),
                          Text(
                            "The user can ask about the nearest pharmacy according to his current location",
                            style:  GoogleFonts.oswald(
                                color: Colors.white, fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Center(
                              child: Container(
                                decoration: const BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                    color: Colors.white12),
                                child:  Image(
                                  image: const AssetImage(
                                    'assets/images/icon3_prev_ui.png',
                                  ),
                                  height: MediaQuery.of(context).size.height*0.3,
                                  width: 400.0,
                                ),
                              )),
                          const SizedBox(height: 30.0),
                          Text(
                            "Tips",
                            style:  GoogleFonts.oswald(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 24),
                          ),
                          const SizedBox(height: 15.0),
                          Text(
                            "The user is provided by useful information and food advices according to selected disease.",
                            style:  GoogleFonts.oswald(
                                color: Colors.white, fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Center(
                              child: Container(
                                decoration: const BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                    color: Colors.white12),
                                child:  Image(
                                  image: const AssetImage(
                                    'assets/images/icon4_prev_ui.png',
                                  ),
                                  height: MediaQuery.of(context).size.height*0.3,
                                  width: 400.0,
                                ),
                              )),
                          const SizedBox(height: 30.0),
                          Text(
                            "Alarm",
                            style:  GoogleFonts.oswald(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 24),
                          ),
                          const SizedBox(height: 15.0),
                          Text(
                            "User can set alarm by notification to his drugs (type, period, time..)",
                            style:  GoogleFonts.oswald(
                                color: Colors.white, fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildPageIndicator(),
              ),
              _currentPage != _numPages - 1
                  ? Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomRight,
                  child: InkWell(
                      onTap: () {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                      },
                      child: Container(
                        margin:
                        const EdgeInsets.only(right: 10.0, top: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children:  <Widget>[
                            Text(
                              "Next",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22.0,
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            const Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 30.0,
                            ),
                          ],
                        ),
                      )),
                ),
              )
                  : const Text(''),
            ],
          ),
        ),

      ),
      bottomSheet: _currentPage == _numPages - 1
          ? GestureDetector(
        onTap: () {
          CashHelper.saveData(key: "firstOpen", value: true);
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>
              Splash()), (route) => false);
        },
        child: Container(
          height: MediaQuery.of(context).size.height*0.08,
          width: double.infinity,
          color: Colors.white,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10.0, top: 10.0),
              child: Text(
                "Get Started",
                style: GoogleFonts.oswald(
                  color: Colors.black,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      )
          : const Text(''),
    );
  }
}
