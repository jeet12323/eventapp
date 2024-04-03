import 'package:eventzu/constants.dart';
import 'package:eventzu/customwidget/shmmerforclublist.dart';
import 'package:eventzu/screens/memberlist.dart';
import 'package:eventzu/screens/tagbutton.dart';
import 'package:eventzu/services/usermanagement.dart';
import 'package:flutter/material.dart';

import 'clubscontainer.dart';

class ClubList extends StatefulWidget {
  ClubList(this.clubdetails, {required this.loading});
  final List<Map<String, String>> clubdetails;
  final bool loading;

  @override
  State<ClubList> createState() => _ClubListState();
}

class _ClubListState extends State<ClubList> {
  @override
  var x;
  List progressreport = [];
  void getprogress() async {
    for (var i = 0; i < widget.clubdetails.length; i++) {
      progressreport.add(false);
    }
  }

  @override
  void initState() {
    getprogress();
  }

  var orientation, size, height, width;
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: BackButton(
          color: kTextcolor,
        ),
        backgroundColor: Colors.transparent,
        title: Text(
          'Clubs List',
          style: TextStyle(
              fontSize: 22.0, fontFamily: "sans-serif", color: kTextcolor),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: widget.loading == false
            ? ListView.builder(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: widget.clubdetails.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () async {
                      setState(() {
                        progressreport[index] = true;
                      });
                      Future.delayed(Duration(seconds: 2));
                      final Map<String, String> membernames = await userdata()
                          .Getclubsmemberdata(
                              '${widget.clubdetails[index]['clubname']}');
                      if (membernames != null) {
                        setState(() {
                          progressreport[index] = false;
                        });
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Memberlist(
                            memberlist: membernames,
                          ),
                        ),
                      );
                    },
                    child: ClubsContainer(
                      onTap: progressreport[index],
                      clublogo: '${widget.clubdetails[index]['clublogo']}',
                      clubname: '${widget.clubdetails[index]['clubname']}',
                      departmentname:
                          '${widget.clubdetails[index]['clubdepartmentname']}',
                      location: '${widget.clubdetails[index]['clubinfo']}',
                    ),
                  );
                },
              )
            : ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return ShimmerClubsContainer();
                }),
      ),
    );
  }
}
