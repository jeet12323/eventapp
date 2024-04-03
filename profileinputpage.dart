import 'package:eventzu/constants.dart';
import 'package:eventzu/customwidget/textfieldwithouticon.dart';
import 'package:eventzu/customwidget/textfieldwithsuffixicon.dart';
import 'package:eventzu/services/usermanagement.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage(this.image2, this.uid);
  final String uid;
  String image2;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    // TODO: implement initState
    buttonsate();
    getdata();
    print("widget.image2------${widget.image2}");
  }

  FocusNode _textFieldFocus = FocusNode();
  Color _color = kbuttonbackgroundcolor;
  Color _coloricon = kbuttonbackgroundcolor;
  void buttonsate() {
    _textFieldFocus.addListener(() {
      if (_textFieldFocus.hasFocus) {
        setState(() {
          _color = Color(0xFFf2f1ff);
          _coloricon = Color(0xFF584cf4);
        });
      } else {
        setState(() {
          _color = kbuttonbackgroundcolor;
          _coloricon = kTextfbackgroundcolor;
        });
      }
    });
  }

  Color bordercolor = Colors.transparent;
  Color fliedcolor = kTextfbackgroundcolor;
  Color buttoncolor = kbuttonbackgroundcolor;
  TextEditingController phoneController = new TextEditingController();
  String image =
      'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png';
  bool loading = false;
  String countrycode = '+91 ';
  void getdata() async {
    print("result----$image");
    final image4 = await userdata().GetUserImage();
    if (image4 != ' ') {
      print("result====${image4}");
      setState(() {
        image = image4;
      });
      print("result----$image");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundcolor,
      appBar: AppBar(
        elevation: 0.0,
        leading: BackButton(
          color: kTextcolor,
        ),
        title: Text(
          'Fill Your Profile',
          style: TextStyle(
              fontSize: 22.0, fontFamily: "sans-serif", color: kTextcolor),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Container(
              height: 130.0,
              width: 130.0,
              child: Stack(
                alignment: Alignment.bottomRight,
                children: <Widget>[
                  CircleAvatar(
                    radius: 80.0,
                    backgroundImage: NetworkImage(image),
                    backgroundColor: Colors.transparent,
                  ),
                  Positioned(
                    right: 5,
                    bottom: 2,
                    child: Container(
                      width: 30.0,
                      height: 30.0,
                      decoration: BoxDecoration(
                        color: kbuttonbackcolor,
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: GestureDetector(
                        onTap: () async {
                          if (loading == false) {
                            setState(() {
                              loading = true;
                            });
                          }
                          final url =
                              await userdata().pickuploadimage(widget.uid);
                          if (url == 'null') {
                            setState(() {
                              loading = false;
                            });
                          } else {
                            setState(() {
                              image = url;
                            });
                            setState(() {
                              if (image == url) {
                                loading = false;
                              }
                            });
                          }
                        },
                        child: Icon(
                          Icons.edit,
                          color: kbackgroundcolor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          loading == true
              ? Container(
                  // color: Colors.grey,
                  width: 200.0,
                  height: 40.0,
                  child: Row(
                    children: [
                      SpinKitRing(color: kTextfbackgroundcolor2),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        "LOADING",
                        style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: "sans-serif",
                            color: kTextcolor),
                      ),
                    ],
                  ),
                )
              : SizedBox(),
          Textfieldwithouticon("Full name"),
          Textwithsuffixicon("Email", Icons.email_rounded),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IntlPhoneField(
              focusNode: _textFieldFocus,
              controller: phoneController,
              decoration: InputDecoration(
                hintText: "Number",
                hintStyle: TextStyle(
                  fontFamily: "inter" "sans-serif",
                  color: kdividertextcolor,
                  fontSize: 14.0,
                ),
                fillColor: _color,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide(
                    width: 2.0,
                    color: Color(0xFF7b72f7),
                  ),
                ),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide.none,
                ),
              ),
              initialCountryCode: 'US',
              onCountryChanged: (country) {
                countrycode = country.dialCode;
                print("hii =${country.code}");
              },
            ),
          ),
        ],
      ),
    );
  }
}
