import 'dart:core';
import 'package:eventzu/screens/clubscontainer.dart';
import 'package:eventzu/screens/tagbutton.dart';
import 'package:flutter/material.dart';
import 'package:eventzu/constants.dart';

class Clubspage extends StatefulWidget {
  const Clubspage({Key? key}) : super(key: key);

  @override
  State<Clubspage> createState() => _ClubspageState();
}

class _ClubspageState extends State<Clubspage> {
  @override
  Map<String, String> clubsname = {
    '0': 'no data',
  };
  Map<String, String> departmentname = {
    '0': 'no data',
  };
  Map<String, String> clubimage = {
    '0': 'no data',
  };
  Map<String, String> clubsinfo = {
    '0': 'no data',
  };
  var orientation, size, height, width;
  List<String> tagname = [
    'All',
    'Music',
    'Workshop',
    'Art',
    'All',
    'Music',
    'Workshop',
    'Art',
  ];
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xbe5e5e5),
        appBar: AppBar(
          elevation: 0.0,
          leading: BackButton(
            color: kTextcolor,
          ),
          title: Text(
            'Clubs',
            style: TextStyle(
                fontSize: 22.0, fontFamily: "sans-serif", color: kTextcolor),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Icon(
                Icons.search,
                color: kdividertextcolor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 0.0, right: 20.0, top: 20.0, bottom: 20.0),
              child: Icon(
                Icons.filter_alt,
                color: kdividertextcolor,
              ),
            )
          ],
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: height * 0.06,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  itemCount: tagname.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        TagButton(tagname: tagname[index]),
                      ],
                    );
                  },
                ),
              ),
              Flexible(
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: clubsname.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ClubsContainer(
                        onTap: false,
                        clubname: '${clubsname['$index']}',
                        departmentname: '${departmentname['$index']}',
                        location: '${clubsinfo['$index']}',
                        clublogo: '${clubimage['$index']}');
                  },
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: "home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "home",
            ),
          ],
          selectedItemColor: kbuttonbackcolor,
        ),
      ),
    );
  }
}
