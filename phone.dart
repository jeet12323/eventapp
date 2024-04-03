import 'package:eventzu/screens/otp.dart';
import 'package:eventzu/services/usermanagement.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:eventzu/constants.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class phoneverification extends StatefulWidget {
  @override
  phoneverification({required this.uid});
  String uid;
  State<phoneverification> createState() => _phoneverificationState();
}

class _phoneverificationState extends State<phoneverification> {
  @override
  final _formkey = GlobalKey<FormState>();
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  Color bordercolor = Colors.transparent;
  Color fliedcolor = kTextfbackgroundcolor;
  Color buttoncolor = kbuttonbackgroundcolor;
  TextEditingController phoneController = new TextEditingController();
  String phone = '+';
  String space = ' ';
  String countrycode = '+91 ';
  String error = '';
  String verificationid = '';
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundcolor,
      appBar: AppBar(
        elevation: 0.0,
        leading: BackButton(
          color: kTextcolor,
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Form(
        key: _formkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Mobile verification",
              style: TextStyle(
                fontFamily: "inter" "sans serif",
                fontWeight: FontWeight.w700,
                fontSize: 35.0,
                color: kTextcolor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IntlPhoneField(
                controller: phoneController,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.email,
                    color: fliedcolor,
                  ),
                  hintText: "Number",
                  hintStyle: TextStyle(
                    color: fliedcolor,
                  ),
                  fillColor: buttoncolor,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                      color: bordercolor,
                    ),
                  ),
                ),
                initialCountryCode: 'US',
                onCountryChanged: (country) {
                  countrycode = country.dialCode;
                  print("hii =${country.code}");
                },
              ),
            ),
            TextButton(
              onPressed: () async {
                print("hii");
                phone = '+';
                phone = phone +
                    countrycode +
                    space +
                    phoneController.text.toString();
                print("phone=$phone");
                await FirebaseAuth.instance.verifyPhoneNumber(
                  phoneNumber: phone,
                  verificationCompleted: (PhoneAuthCredential credential) {
                    print("phone=$phone");
                  },
                  verificationFailed: (FirebaseAuthException e) {
                    if (e.code == 'Invaid-phone-number ') {
                      error = 'Invalid number';
                    }
                  },
                  codeSent: (String verificationId, int? resendToken) async {
                    this.verificationid = verificationId;
                    userdata().AddUserData(
                        phone, "phone number", context, widget.uid);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => otppage(
                                  verificationid,
                                  phone,
                                  uid: widget.uid,
                                )));
                  },
                  codeAutoRetrievalTimeout: (String verificationId) {},
                );
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
                  "Send",
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
          ],
        ),
      ),
    );
  }
}
