import 'package:eventzu/constants.dart';
import 'package:eventzu/my_flutter_app_icons.dart';
import 'package:flutter/material.dart';

class MYEvent extends StatefulWidget {
  const MYEvent({super.key});

  @override
  State<MYEvent> createState() => _MYEventState();
}

class _MYEventState extends State<MYEvent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        // ignore: prefer_const_constructors
        leading: BackButton(
          color: kTextcolor,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              size: 20.0,
              MyFlutterApp.event_svgrepo_com__1_,
              color: Color(0xFF222223),
            ),
            const SizedBox(width: 5.0,),
            Text(
              'My Events',
              style: TextStyle(
                  color: kTextcolor, fontFamily: 'sans-serif', fontSize: 20.0),
            ),
          ],
        ),
      ),
    );
  }
}
