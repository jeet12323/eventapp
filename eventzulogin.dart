import 'package:eventzu/screens/Forgetpasssword.dart';
import 'package:eventzu/screens/Mainpage.dart';
import 'package:eventzu/screens/phone.dart';
import 'package:eventzu/screens/profileinputpage.dart';
import 'package:eventzu/screens/resetpass.dart';
import 'package:eventzu/screens/signuppage.dart';
import 'package:eventzu/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../constants.dart';
import '../services/usermanagement.dart';

class Signinpage extends StatefulWidget {
  const Signinpage({Key? key}) : super(key: key);

  @override
  State<Signinpage> createState() => _SigninpageState();
}

class _SigninpageState extends State<Signinpage> {
  bool isChecked = false;
  final _formkey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController emailController = new TextEditingController();
  TextEditingController PasswordController = new TextEditingController();
  String email = '';
  String Password = '';
  bool loginerror = false;
  String error = ' ';
  // String sigin = "Sign in";
  bool Sigin = false;
  @override
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
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Login to Your Account",
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
                AutofillGroup(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(20.0),
                        child: TextFormField(
                          controller: emailController,
                          textInputAction: TextInputAction.next,
                          autofillHints: const [AutofillHints.email],
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
                                color: bordercolor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(20.0),
                        child: TextFormField(
                          controller: PasswordController,
                          obscureText: true,
                          onFieldSubmitted: (value) {},
                          autofillHints: const [AutofillHints.password],
                          validator: (value) {
                            if (value!.isEmpty || value.length < 6) {
                              return 'Enter a 6 character password';
                            } else {
                              Password = PasswordController.text.toString();
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
                    ],
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
                    setState(() {
                      Sigin = true;
                    });
                    await Future.delayed(Duration(seconds: 2));
                    setState(() {
                      Sigin = false;
                    });

                    final isvalid = _formkey.currentState?.validate();
                    if (!isvalid!)
                      return;
                    else {
                      _formkey.currentState?.save();
                      String login =
                          await FirebaseMethods(FirebaseAuth.instance)
                              .Siginwithemail(context, email, Password);

                      if (login == 'true') {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Mainpage()));
                      } else {
                        setState(() {
                          error = login;
                        });
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
                    child: Sigin == false
                        ? Text(
                            "Sign in",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "inter" "sans serif",
                              fontWeight: FontWeight.w400,
                              fontSize: 20.0,
                              color: kbackgroundcolor,
                            ),
                          )
                        : SpinKitThreeBounce(
                            color: Colors.white,
                          ),
                  ),
                ),
                SizedBox(
                  height: 14.0,
                  child: Text(
                    '$error',
                    style: TextStyle(color: Colors.red, fontSize: 14.0),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    final Map<String, String> data1 = await userdata()
                        .GetUserData(FirebaseAuth.instance.currentUser!.uid);
                    print(data1);
                    Map<String, String> data = {};
                    print('data==>$data');
                    data.addAll(data1);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Forgetpassword(),
                        // Resetpass(
                        //   email: '${data['email']}',
                        //   phonenumber: '${data['phone number']}',
                        // ),
                      ),
                    );
                  },
                  child: Text(
                    "Forgot the Password?",
                    style: TextStyle(
                      fontFamily: "inter" "sans serif",
                      fontWeight: FontWeight.w400,
                      fontSize: 20.0,
                      color: kbuttonbackcolor,
                    ),
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
                    GestureDetector(
                      onTap: () async {
                        setState(() {});

                        dynamic login =
                            await FirebaseMethods(FirebaseAuth.instance)
                                .googleLogin(context);
                        if (login != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Mainpage(),
                            ),
                          );
                        }
                      },
                      child: Container(
                        height: 60.0,
                        width: 200.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: kbackgroundcolor,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 20, bottom: 20, right: 10.0),
                              child: Image(
                                image: AssetImage('images/google.png'),
                              ),
                            ),
                            Text(
                              'Google',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: 'sans-serif',
                                  fontWeight: FontWeight.w500,
                                  color: kTextcolor),
                            )
                          ],
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
                        "Don't have account?",
                        style: TextStyle(
                          fontFamily: "inter" "sans-serif",
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
                                builder: (context) => signuppage(),
                              ));
                        },
                        child: Text(
                          "Sign up",
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
        ),
      ),
    );
  }
}
