import 'package:eventzu/constants.dart';
import 'package:eventzu/screens/Mainpage.dart';
import 'package:eventzu/screens/eventzulogin.dart';
import 'package:eventzu/services/usermanagement.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class welcomepage extends StatefulWidget {
  const welcomepage({Key? key}) : super(key: key);

  State<welcomepage> createState() => _welcomepageState();
}

class _welcomepageState extends State<welcomepage> {
  @override
  bool logined = false;
  void initState() {
    // TODO: implement initState
    super.initState();
    if (userdata.showed == false) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        userdata.showed = true;
      });
    }
    print('swelcomevaule====>${userdata.showed}');
    if (FirebaseAuth.instance.currentUser != null) {
      logined = true;
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundcolor,
      body: userdata.showed == false
          ? Center(
              child: Container(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Signinpage()));
                  },
                  child: Text("NEXT"),
                ),
              ),
            )
          : (logined == true ? Mainpage() : Signinpage()),
    );
  }
}
