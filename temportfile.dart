import 'package:eventzu/constants.dart';
import 'package:flutter/material.dart';

class HomecontainerTrends1 extends StatefulWidget {
  const HomecontainerTrends1({Key? key}) : super(key: key);

  @override
  State<HomecontainerTrends1> createState() => _HomecontainerTrends1State();
}

class _HomecontainerTrends1State extends State<HomecontainerTrends1> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Container(
        width: 600.0,
        height: 300.0,
        decoration: BoxDecoration(
          color: kbackgroundcolor,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(width: 0.0, color: Colors.transparent),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 200.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://images.unsplash.com/photo-1657299156537-2fd96dc2446e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDF8MHxlZGl0b3JpYWwtZmVlZHwzNnx8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(width: 0.0),
                ),
              ),
              SizedBox(
                width: 5.0,
              ),
              Text(
                'Hii Hello',
                style: TextStyle(
                    fontFamily: "sans-serif",
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                    color: kTextcolor),
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "IT",
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
                    "New York",
                    style: TextStyle(
                        fontFamily: "sans-serif",
                        fontSize: 15.0,
                        color: kTextcolor),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
