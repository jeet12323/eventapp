import 'package:eventzu/constants.dart';
import 'package:eventzu/customwidget/clubmembercontainer.dart';
import 'package:flutter/material.dart';

class Memberlist extends StatefulWidget {
  Memberlist({required this.memberlist});
  final Map<String, String> memberlist;

  @override
  State<Memberlist> createState() => _MemberlistState();
}

class _MemberlistState extends State<Memberlist> {
  @override
  initState() {
    int index = 0;
    print("memberlist===>${widget.memberlist}");
    print("membername===>${widget.memberlist['membername$index']}");
  }

  var orientation, size, height, width;
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Club Members',
          style: TextStyle(
              fontSize: 22.0, fontFamily: "sans-serif", color: kTextcolor),
        ),
      ),
      body: Container(
        width: width,
        height: height * 0.95,
        child: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              return ClubmemberContainer(
                membername: '${widget.memberlist['membername$index']}',
                memberpost: '${widget.memberlist['memberpost$index']}',
              );
            }),
      ),
    );
  }
}
