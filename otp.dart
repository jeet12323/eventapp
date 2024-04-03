import 'dart:async';

import 'package:eventzu/constants.dart';
import 'package:eventzu/screens/profileinputpage.dart';
import 'package:eventzu/services/usermanagement.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class otppage extends StatefulWidget {
  otppage(this.verificationid, this.phone, {required this.uid});
  final String verificationid;
  final String phone;
  final String uid;

  @override
  State<otppage> createState() => _otppageState();
}

class _otppageState extends State<otppage> {
  @override
  inistate() {
    startTimer();
  }

  Duration myDuration = Duration(seconds: 60);
  Timer? countdownTimer;
  void startTimer() {
    countdownTimer =
        Timer.periodic(Duration(seconds: 60), (_) => setCountDown());
  }

  void setCountDown() {
    final reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
      } else {
        myDuration = Duration(seconds: seconds);
        setState(() {
          this.myDuration = myDuration;
        });
      }
    });
  }

  String otp = '';
  String error = '';
  FirebaseAuth _auth = FirebaseAuth.instance;

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundcolor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "OTP Code Verification",
          style: TextStyle(
            fontFamily: "inter" "sans serif",
            fontWeight: FontWeight.w700,
            fontSize: 15.0,
            color: kTextcolor,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Code has been send to ${widget.phone}'),
          OTPTextField(
            length: 6,
            width: MediaQuery.of(context).size.width,
            fieldWidth: 40,
            style: TextStyle(
              fontSize: 17,
              color: kTextcolor,
              fontFamily: "inter" "sans srif",
            ),
            textFieldAlignment: MainAxisAlignment.spaceAround,
            fieldStyle: FieldStyle.box,
            onCompleted: (pin) {
              otp = pin;
            },
          ),
          TextButton(
            onPressed: () async {
              print(otp);
              PhoneAuthCredential credential = PhoneAuthProvider.credential(
                  verificationId: widget.verificationid, smsCode: otp);
              try {
                final result = await _auth.signInWithCredential(credential);
                if (result.user != null) {
                  final Map<String, String> data =
                      await userdata().GetUserData(widget.uid);
                  String? image = '';
                  if (data['image'] == null) {
                    image = '';
                  } else {
                    image = data['image'];
                  }
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfilePage(
                                image!,
                                widget.uid,
                              )));
                }
              } catch (e) {
                error = e.toString();
              }
            },
            child: Container(
              padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.all(10.0),
              height: 50.0,
              width: 300.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                color: kbuttonbackcolor,
              ),
              child: Text(
                "verify",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "inter" "sans serif",
                  fontWeight: FontWeight.w400,
                  fontSize: 20.0,
                  color: kbackgroundcolor,
                ),
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Text(
                'Resend code in',
                style: TextStyle(fontSize: 12.0, color: kTextcolor),
              ),
              Text(
                '$myDuration',
                style: TextStyle(fontSize: 12.0, color: Colors.red),
              ),
              Text(
                'sec',
                style: TextStyle(fontSize: 12.0, color: kTextcolor),
              )
            ],
          ),
          SizedBox(
            height: 20.0,
            child: Text(
              '$error',
              style: TextStyle(
                  color: Colors.red,
                  fontFamily: "inter" "sans serif",
                  fontSize: 17.0),
            ),
          ),
        ],
      ),
    );
  }
}
