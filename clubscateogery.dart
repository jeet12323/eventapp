import 'package:eventzu/constants.dart';
import 'package:eventzu/customwidget/clubscateogerycontainer.dart';
import 'package:eventzu/screens/Mainpage.dart';
import 'package:eventzu/screens/Clublist.dart';
import 'package:eventzu/services/clubmanagement.dart';
import 'package:eventzu/services/usermanagement.dart';
import 'package:flutter/material.dart';

import '../my_flutter_app_icons.dart';

class Clubscategory extends StatefulWidget {
  const Clubscategory({Key? key}) : super(key: key);
  @override
  State<Clubscategory> createState() => _ClubscategoryState();
}

class _ClubscategoryState extends State<Clubscategory> {
  @override
  List<String> category = [
    'Development club',
    'Medical Activity Clubs',
    'Sports Clubs',
  ];
  List<String> categorynames = [
    'DevelopmentandSoftwareclubs',
    'Medical',
    'sportsclub',
  ];
  // String name = 'Clubs';
  List webprogress = [false, false, false];

  var orientation, size, height, width;
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        // ignore: prefer_const_constructors
        leading: BackButton(
          color: kTextcolor,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(
              size: 40.0,
              MyFlutterApp.club_house__2_,
              color: Color(0xFF222223),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Text(
              'Clubs',
              style: TextStyle(
                  color: kTextcolor, fontFamily: 'sans-serif', fontSize: 30.0),
            ),
          ],
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Mainpage()),
            (route) => false,
          );
          return true;
        },
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          itemCount: categorynames.length,
          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () async {
                  if (webprogress.contains(true)) return;
                  setState(() {
                    webprogress[index] = true;
                  });
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ClubList([], loading: webprogress[index])));
                  final List<Map<String, String>> details =
                      await Clubmanagement().Clubdetails(categorynames[index]);
                  Navigator.pop(context);
                  setState(() {
                    webprogress[index] = false;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ClubList(
                              loading: false,
                              details,
                            )),
                  );
                },
                child: ClubscateContainer(
                  Cateogeryname: category[index],
                  ontap: webprogress[index],
                ));
          },
        ),
      ),
    );
  }
}
