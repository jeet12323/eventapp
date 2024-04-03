import 'package:eventzu/constants.dart';
import 'package:eventzu/services/usermanagement.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Resetpass extends StatefulWidget {
  Resetpass({required this.email, required this.phonenumber});
  final String email;
  final String phonenumber;

  @override
  State<Resetpass> createState() => _ResetpassState();
}

class _ResetpassState extends State<Resetpass> {
  @override
  String email = '';
  static String char = '';
  static int n = 0;
  static int i = 0;
  String phonenumber = '';
  String email1 = '';
  String phonenumber1 = '';
  bool send = true;
  bool ontap = false;

  double Widthbox1 = 0;
  Color boxcolorbox1 = Colors.transparent;
  double Widthbox2 = 0;
  Color boxcolorbox2 = Colors.transparent;
  void initState() {
    // TODO: implement initState
    String email3 = '';
    String phonenumber3 = '';
    final email2 = widget.email;
    final phonenumber2 = widget.phonenumber;
    super.initState();
    setState(() {
      email = email2;
      phonenumber = phonenumber2;
    });
    email.runes.forEach((int rune) {
      i++;
      if (i <= 2 || n > 0) {
        email3 += new String.fromCharCode(rune);
        print('email1inside--->$email1');
      } else {
        char = new String.fromCharCode(rune);
        print(char);
        if (char == '@') {
          n = i;
          email3 += '@';
        } else {
          email3 += '*';
          print('email1inside--->$email1');
        }
      }
    });
    i = 0;
    phonenumber.runes.forEach((int rune) {
      i++;
      if (i <= 3 || i > phonenumber.length - 2) {
        phonenumber3 += new String.fromCharCode(rune);
        print('email1inside--->$email1');
      } else {
        phonenumber3 += '*';
      }
    });
    setState(() {
      email1 = email3;
      phonenumber1 = phonenumber3;
    });
    print('ph----->$email1');
    print('ph----->$email');
  }

  final _formkey = GlobalKey<FormState>();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: BackButton(
          color: kTextcolor,
        ),
      ),
      body: Form(
        key: _formkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Reset Password',
              style: TextStyle(
                fontFamily: "inter" "sans serif",
                fontWeight: FontWeight.w700,
                fontSize: 35.0,
                color: kTextcolor,
              ),
            ),
            TextButton(
              onPressed: () async {
                setState(() {
                  Widthbox1 = 0.0;
                  boxcolorbox1 = Colors.transparent;
                  Widthbox2 = 2.0;
                  boxcolorbox2 = kbuttonbackcolor;
                });
                await FirebaseAuth.instance
                    .sendPasswordResetEmail(email: widget.email);
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          content: Text(
                              'Password reset Link has been set to your email! check your email'),
                        ));
                setState(() {
                  send = false;
                });
              },
              child: Container(
                margin: EdgeInsets.all(5.0),
                width: double.infinity,
                height: 130.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40.0),
                    border: Border.all(width: Widthbox2, color: boxcolorbox2),
                    color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        child: Icon(
                          Icons.email_rounded,
                          color: kbuttonbackcolor,
                        ),
                        radius: 30.0,
                        backgroundColor: kbuttonbackgroundcolor,
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        '$email1',
                        style:
                            TextStyle(fontSize: 20.0, color: kdividertextcolor),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            TextButton(
                onPressed: send == true
                    ? null
                    : () {
                        setState(() {
                          ontap = true;
                        });
                        Future.delayed(Duration(seconds: 3));
                        setState(() {
                          ontap = false;
                        });
                        Navigator.pop(context);
                      },
                child: Container(
                  margin: EdgeInsets.all(5.0),
                  width: 300.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: send == true ? Colors.black26 : kbuttonbackcolor),
                  child: Center(
                    child: ontap == false
                        ? Text(
                            'Sigin in',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontFamily: 'sans-serif',
                                color: send == true
                                    ? Colors.grey[200]
                                    : Colors.white,
                                fontSize: 20.0),
                          )
                        : SpinKitThreeBounce(
                            color: Colors.white,
                          ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
