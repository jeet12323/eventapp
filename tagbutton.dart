import 'package:eventzu/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class TagButton extends StatefulWidget {
  TagButton({required this.tagname});
  final String tagname;

  @override
  State<TagButton> createState() => _TagButtonState();
}


class _TagButtonState extends State<TagButton> {
  @override
  bool _enabled = false;
  Color _tagcolor = Colors.transparent;
  Color _tagnamecolor = kbuttonbackcolor;
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        if (_enabled == false) {
          setState(() {
            _enabled = true;
            _tagcolor = kbuttonbackcolor;
            _tagnamecolor = kbackgroundcolor;
          });
        } else {
          setState(() {
            _enabled = false;
            _tagcolor = Colors.transparent;
            _tagnamecolor = kbuttonbackcolor;
          });
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(color: kbuttonbackcolor, width: 2.0),
          color: _tagcolor,
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              top: 6.5, bottom: 6.5, left: 15.0, right: 15.0),
          child: Text(
            '${widget.tagname}',
            style: TextStyle(
                fontSize: 12.0, fontFamily: "sans-serif", color: _tagnamecolor),
          ),
        ),
      ),
    );
  }
}
