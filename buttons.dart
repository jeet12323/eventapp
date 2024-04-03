import 'package:flutter/material.dart';

import '../constants.dart';

class buttons extends StatelessWidget {
  buttons({required this.image, required this.text});
  final String text;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: kbackgroundcolor,
        border: Border.all(
          color: kbuttonbordercolor,
          width: 2,
        ),
      ),
      child: Row(
        children: <Widget>[
          Image(
            image: AssetImage(image),
          ),
          Text(
            text,
            style: TextStyle(
              fontFamily: "inter" "sans serif",
              fontWeight: FontWeight.w100,
              fontSize: 12.0,
              color: kTextcolor,
            ),
          )
        ],
      ),
    );
  }
}
