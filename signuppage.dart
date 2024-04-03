import 'package:eventzu/constants.dart';
import 'package:eventzu/screens/eventzulogin.dart';
import 'package:eventzu/screens/phone.dart';
import 'package:eventzu/services/auth.dart';
import 'package:eventzu/services/usermanagement.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class signuppage extends StatefulWidget {
  const signuppage({Key? key}) : super(key: key);

  @override
  State<signuppage> createState() => _signuppageState();
}

class _signuppageState extends State<signuppage> {
  bool isChecked = false;
  final _formkey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController emailController = new TextEditingController();
  TextEditingController PasswordController = new TextEditingController();
  String email = '';
  String Password = '';
  String uid = '';
  String error = '';
  @override
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return kbuttonbackcolor;
    }
    return kbuttonbackcolor;
  }

  Widget build(BuildContext context) {
    Color bordercolor = Colors.transparent;
    Color fliedcolor = kTextfbackgroundcolor;
    Color buttoncolor = kbuttonbackgroundcolor;
    return Scaffold(
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
              "Create New Account",
              style: TextStyle(
                fontFamily: "inter" "sans serif",
                fontWeight: FontWeight.w700,
                fontSize: 35.0,
                color: kTextcolor,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              margin: EdgeInsets.all(20.0),
              child: TextFormField(
                controller: emailController,
                onFieldSubmitted: (value) {},
                validator: (value) {
                  if (value!.isEmpty ||
                      !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                    return 'Enter a valid Email';
                  } else {
                    email = emailController.text.toString();
                    return null;
                  }
                },
                style: TextStyle(
                  color: kTextcolor,
                ),
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.email,
                    color: fliedcolor,
                  ),
                  hintText: "Email",
                  hintStyle: TextStyle(
                    color: fliedcolor,
                  ),
                  fillColor: buttoncolor,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                      width: 0.0,
                      color: Colors.transparent,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(20.0),
              child: TextFormField(
                controller: PasswordController,
                onFieldSubmitted: (value) {},
                validator: (value) {
                  if (value!.isEmpty || value.length < 6) {
                    return 'Enter a 6 character password';
                  } else {
                    Password = PasswordController.text.toString();
                    print("pass");
                    print(PasswordController.text.toString());
                    return null;
                  }
                },
                style: TextStyle(
                  color: kTextcolor,
                ),
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.lock,
                    color: fliedcolor,
                  ),
                  hintText: "Password",
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
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Checkbox(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  checkColor: Colors.white,
                  fillColor: MaterialStateProperty.resolveWith(getColor),
                  value: isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value!;
                    });
                  },
                ),
                Text(
                  "Remember me",
                  style: TextStyle(
                    fontFamily: "inter" "sans serif",
                    fontWeight: FontWeight.w300,
                    fontSize: 20.0,
                    color: kTextcolor,
                  ),
                ),
              ],
            ),
            TextButton(
              onPressed: () async {
                final isvalid = _formkey.currentState?.validate();
                if (!isvalid!)
                  return;
                else {
                  _formkey.currentState?.save();
                  try {
                    print("email=$email");
                    print("Password=$Password");
                    UserCredential result =
                        await _auth.createUserWithEmailAndPassword(
                            email: email, password: Password);
                    User? user = result.user;
                    if (user == null) {
                      setState(() {
                        error = 'Enter a valid E-mail';
                      });
                    } else {
                      uid = user.uid;
                      userdata()
                          .AddUseremail(email, "email", context, user.uid);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                phoneverification(uid: user.uid),
                          ));
                    }
                  } catch (e) {
                    print(e.toString());
                    if (e.toString() ==
                        '[firebase_auth/email-already-in-use] The email address is already in use by another account.') {
                      setState(() {
                        error = "Already registred";
                      });
                    }
                    return null;
                  }
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
                  "Sign up",
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
            SizedBox(
              height: 20.0,
              child: Text(
                '$error',
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(15.0),
                    child: Divider(
                      color: kdividercolor,
                      height: 60.0,
                      thickness: 2.0,
                    ),
                  ),
                ),
                Text(
                  "or continue with",
                  style: TextStyle(
                    fontFamily: "inter" "sans serif",
                    fontWeight: FontWeight.w400,
                    fontSize: 20.0,
                    color: kdividertextcolor,
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(15.0),
                    child: Divider(
                      color: kdividercolor,
                      height: 60.0,
                      thickness: 2.0,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(8.0),
                  height: 60.0,
                  width: 70.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: kbackgroundcolor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image(
                      image: AssetImage('images/facebook1.png'),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20.0,
                ),
                GestureDetector(
                  onTap: () async {
                    String login = await FirebaseMethods(FirebaseAuth.instance)
                        .googleLogin(context);
                    if (login == 'true') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => phoneverification(
                            uid: uid,
                          ),
                        ),
                      );
                    }
                  },
                  child: Container(
                    height: 60.0,
                    width: 70.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: kbackgroundcolor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Image(
                        image: AssetImage('images/google.png'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have account?",
                    style: TextStyle(
                      fontFamily: "inter" "sans serif",
                      fontWeight: FontWeight.w100,
                      fontSize: 15.0,
                      color: kdividertextcolor,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Signinpage(),
                          ));
                    },
                    child: Text(
                      "Sign in",
                      style: TextStyle(
                        fontFamily: "inter" "sans serif",
                        fontWeight: FontWeight.w400,
                        fontSize: 15.0,
                        color: kbuttonbackcolor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
