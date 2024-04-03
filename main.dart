import 'package:eventzu/screens/Mainpage.dart';
import 'package:eventzu/screens/eventzulogin.dart';
import 'package:eventzu/screens/profileinputpage.dart';
import 'package:eventzu/screens/signuppage.dart';
import 'package:eventzu/screens/temparyfile.dart';
import 'package:eventzu/screens/welcomepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:eventzu/constants.dart';

void main() async {
  bool logined = true;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyCFgQsZYZC663aR_9yzcRzvPatfK3epZuo",
        appId: "1:276946863429:android:5551008a242780aebf2a2c",
        messagingSenderId: "276946863429",
        projectId: "eventzu"),
  );
  if (FirebaseAuth.instance.currentUser != null) {
    logined = false;
  }
  runApp(
    MaterialApp(
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/second': (context) => const Signinpage(),
        // When navigating to the "/second" route, build the SecondScreen widget.
      },
      theme: ThemeData(
        primaryColor: kbackgroundcolor,
      ),
      home: page(),
      //logined == true ? welcomepage() : Mainpage(),
      // welcomepage(),
    ),
  );
}
