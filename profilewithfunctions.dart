import 'package:eventzu/constants.dart';
import 'package:eventzu/customwidget/profilecontainer.dart';
import 'package:eventzu/screens/eventzulogin.dart';
import 'package:eventzu/screens/profileinputpage.dart';
import 'package:eventzu/screens/signuppage.dart';
import 'package:eventzu/services/auth.dart';
import 'package:eventzu/services/usermanagement.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Profilepagewithfunctons extends StatefulWidget {
  const Profilepagewithfunctons({Key? key}) : super(key: key);

  @override
  State<Profilepagewithfunctons> createState() =>
      _ProfilepagewithfunctonsState();
}

class _ProfilepagewithfunctonsState extends State<Profilepagewithfunctons> {
  @override
  var height;
  var width;
  static String profile = '';
  @override
  Future<void> getimage() async {
    final image = await userdata().GetUserImage();
    setState(() {
      profile = image;
    });
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    if (profile == '') {
      getimage();
    }
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          title: Text(
            'Profile',
            style: TextStyle(color: kTextcolor),
          ),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0.0, 0, 10),
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(profile),
                  backgroundColor: Colors.transparent,
                ),
              ),
              Text(
                'Username',
                style: TextStyle(
                    fontFamily: 'sans-serif',
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                    color: kTextcolor),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: 54,
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Icon(
                          Icons.person_outline,
                          color: kTextcolor,
                          size: 27,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 90),
                        child: SizedBox(
                            width: 200,
                            child: Text('Profile',
                                style: TextStyle(
                                    fontFamily: 'sans-serif',
                                    fontSize: 15.0,
                                    color: kTextcolor))),
                      ),
                      Icon(
                        Icons.navigate_next,
                        color: kTextcolor,
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: 54,
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Icon(
                          Icons.notifications_outlined,
                          color: kTextcolor,
                          size: 27,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 90),
                        child: SizedBox(
                            width: 200,
                            child: Text('Notification',
                                style: TextStyle(
                                    fontFamily: 'sans-serif',
                                    fontSize: 15.0,
                                    color: kTextcolor))),
                      ),
                      Icon(
                        Icons.navigate_next,
                        color: kTextcolor,
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: 54,
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Icon(
                          Icons.payment_outlined,
                          color: kTextcolor,
                          size: 27,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 90),
                        child: SizedBox(
                            width: 200,
                            child: Text('Payments',
                                style: TextStyle(
                                    fontFamily: 'sans-serif',
                                    fontSize: 15.0,
                                    color: kTextcolor))),
                      ),
                      Icon(
                        Icons.navigate_next,
                        color: kTextcolor,
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: 54,
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Icon(
                          Icons.link,
                          color: kTextcolor,
                          size: 27,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 90),
                        child: SizedBox(
                            width: 200,
                            child: Text('Linked Accounts',
                                style: TextStyle(
                                    fontFamily: 'sans-serif',
                                    fontSize: 15.0,
                                    color: kTextcolor))),
                      ),
                      Icon(
                        Icons.navigate_next,
                        color: kTextcolor,
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: 54,
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Icon(
                          Icons.confirmation_number_outlined,
                          color: kTextcolor,
                          size: 27,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 90),
                        child: SizedBox(
                            width: 200,
                            child: Text('Tickets',
                                style: TextStyle(
                                    fontFamily: 'sans-serif',
                                    fontSize: 15.0,
                                    color: kTextcolor))),
                      ),
                      Icon(
                        Icons.navigate_next,
                        color: kTextcolor,
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: 54,
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Icon(
                          Icons.security_outlined,
                          color: kTextcolor,
                          size: 27,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 90),
                        child: SizedBox(
                            width: 200,
                            child: Text('Security',
                                style: TextStyle(
                                    fontFamily: 'sans-serif',
                                    fontSize: 15.0,
                                    color: kTextcolor))),
                      ),
                      Icon(
                        Icons.navigate_next,
                        color: kTextcolor,
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: 54,
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Icon(
                          Icons.info_outline,
                          color: kTextcolor,
                          size: 27,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 90),
                        child: SizedBox(
                            width: 200,
                            child: Text('Help',
                                style: TextStyle(
                                    fontFamily: 'sans-serif',
                                    fontSize: 15.0,
                                    color: kTextcolor))),
                      ),
                      Icon(
                        Icons.navigate_next,
                        color: kTextcolor,
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: 54,
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Icon(
                          Icons.group_outlined,
                          color: kTextcolor,
                          size: 27,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 90),
                        child: SizedBox(
                            width: 200,
                            child: Text('Invite',
                                style: TextStyle(
                                    fontFamily: 'sans-serif',
                                    fontSize: 15.0,
                                    color: kTextcolor))),
                      ),
                      Icon(
                        Icons.navigate_next,
                        color: kTextcolor,
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: 54,
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Icon(
                          Icons.star,
                          color: kTextcolor,
                          size: 27,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 90),
                        child: SizedBox(
                            width: 200,
                            child: Text('Rate us',
                                style: TextStyle(
                                    fontFamily: 'sans-serif',
                                    fontSize: 15.0,
                                    color: kTextcolor))),
                      ),
                      Icon(
                        Icons.navigate_next,
                        color: kTextcolor,
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  showDialog(
                      context: context,
                      builder: (context) {
                        height = MediaQuery.of(context).size.height;
                        width = MediaQuery.of(context).size.width;
                        return Padding(
                          padding: const EdgeInsets.all(100.0),
                          child: Dialog(
                            backgroundColor: Colors.black26,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            child: Container(
                              width: width - 360,
                              height: height - 700,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SpinKitCircle(
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                  Future.delayed(Duration(seconds: 1), () async {
                    final status = await FirebaseMethods(FirebaseAuth.instance)
                        .googlestatus(context);
                    print('status===>$status');
                    if (status == true) {
                      final singout =
                          await FirebaseMethods(FirebaseAuth.instance)
                              .googleSingout();
                      print('singout===>$singout');
                      if (singout == 'true') {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Signinpage()),
                            (route) => false);
                      }
                    } else {
                      final Singedout =
                          await FirebaseMethods(FirebaseAuth.instance)
                              .Singout();
                      if (Singedout == 'true') {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/second', (Route<dynamic> route) => false);
                      }
                    }
                  });
                },
                child: Container(
                  height: 54,
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Icon(
                          Icons.logout,
                          color: Colors.red,
                          size: 27,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 90),
                        child: SizedBox(
                            width: 200,
                            child: Text('Logout',
                                style: TextStyle(
                                  fontFamily: 'sans-serif',
                                  fontSize: 15.0,
                                  color: Colors.red,
                                ))),
                      ),
                      Icon(
                        Icons.navigate_next,
                        color: kTextcolor,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
