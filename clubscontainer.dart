import 'dart:io';

import 'package:eventzu/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ClubsContainer extends StatefulWidget {
  @override
  ClubsContainer({
    required this.onTap,
    required this.clublogo,
    required this.clubname,
    required this.departmentname,
    required this.location,
  });
  final String clubname;
  final String departmentname;
  final String location;
  final bool onTap;
  final String clublogo;
  State<ClubsContainer> createState() => _ClubsContainerState();
}

class _ClubsContainerState extends State<ClubsContainer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: widget.onTap == false
          ? Container(
              width: double.infinity,
              height: 150.0,
              decoration: BoxDecoration(
                color: kbackgroundcolor,
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(width: 0.0, color: Colors.transparent),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: 110.0,
                      height: 90.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage('${widget.clublogo}'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(width: 0.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${widget.clubname}',
                        style: TextStyle(
                            fontFamily: "sans-serif",
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                            color: kTextcolor),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "${widget.departmentname}",
                        style: TextStyle(
                            fontFamily: "sans-serif",
                            fontSize: 15.0,
                            color: kbuttonbackcolor),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.location_on,
                            color: kbuttonbackcolor,
                          ),
                          Text(
                            "${widget.location}",
                            style: TextStyle(
                                fontFamily: "sans-serif",
                                fontSize: 15.0,
                                color: kTextcolor),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            )
          : SizedBox(
              width: double.infinity,
              height: 150,
              child: SpinKitFadingCircle(
                color: kbuttonbackcolor,
              ),
            ),
    );
  }
}
