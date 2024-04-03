import 'package:eventzu/constants.dart';
import 'package:eventzu/services/usermanagement.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Forgetpassword extends StatefulWidget {
  @override
  State<Forgetpassword> createState() => _ForgetpasswordState();
}

class _ForgetpasswordState extends State<Forgetpassword> {
  @override
  String email = '';
  bool send = true;
  bool ontap = false;
  TextEditingController emailcontroller = TextEditingController();

  double Widthbox1 = 0;
  Color boxcolorbox1 = Colors.transparent;
  double Widthbox2 = 0;
  Color boxcolorbox2 = Colors.transparent;

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
            Container(
              margin: EdgeInsets.all(20.0),
              child: TextFormField(
                controller: emailcontroller,
                onChanged: (value) {},
                onFieldSubmitted: (value) {},
                validator: (value) {
                  if (value!.isEmpty ||
                      !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                    return 'Enter a valid Email';
                  } else {
                    print('********************>${emailcontroller.text}');
                    email = emailcontroller.text.toString();
                  }
                },
                style: TextStyle(
                  color: kTextcolor,
                ),
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.email,
                    color: kbuttonbackcolor,
                  ),
                  hintText: "Enter your email",
                  hintStyle: TextStyle(
                    color: kdividertextcolor,
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                      color: kbuttonbackcolor,
                    ),
                  ),
                ),
              ),
            ),
            TextButton(
                onPressed: () async {
                  final isvalid = _formkey.currentState?.validate();
                  if (!isvalid!)
                    return;
                  else {
                    _formkey.currentState?.save();
                    await FirebaseAuth.instance
                        .sendPasswordResetEmail(email: email);
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              content: Text(
                                  'Password reset Link has been set to your email! check your email'),
                            ));
                    setState(() {
                      send = false;
                    });
                  }
                },
                child: Container(
                  margin: EdgeInsets.all(5.0),
                  width: 300.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: kbuttonbackcolor),
                  child: Center(
                    child: Text(
                      'send',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontFamily: 'sans-serif',
                          color: Colors.white,
                          fontSize: 20.0),
                    ),
                  ),
                )),
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
