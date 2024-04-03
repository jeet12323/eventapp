import 'package:carousel_slider/carousel_slider.dart';
import 'package:eventzu/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'googlemap.dart';

class page extends StatefulWidget {
  const page({Key? key}) : super(key: key);

  @override
  State<page> createState() => _pageState();
}

class _pageState extends State<page> {
  int currentindex = 0;
  int? Lines = 3;
  TextStyle defaultStyle = TextStyle(color: kTextcolor, fontSize: 20.0);
  TextStyle linkStyle = TextStyle(color: kbuttonbackcolor);
  String status = "Read more";
  final images = [
    "https://images.unsplash.com/photo-1667420137384-8e7c17369e0e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyNHx8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60",
    'https://images.unsplash.com/photo-1664574653790-cee0e10a4242?ixlib=rb-4.0.3&ixid=MnwxMjA3fDF8MHxlZGl0b3JpYWwtZmVlZHw0NXx8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60',
    'https://images.unsplash.com/photo-1667487766434-87a9e2ad4b47?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw0NHx8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60',
  ];
  String eventname = "Event Name";
  String date = "Monday, December 24,2022";
  String time = "18.00-23.00 PM";
  String location = "Charusat University";
  String location2 = " Chandubhai S Patel,Charusat";
  String price = "100 rs per person";
  String quote = "Non refundable ";
  Widget buildImage(String img, int index) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 00),
      child: Container(
        width: 500,
        height: 10,
        //height: 100,
        color: Colors.white,
        child: Image(
          image: NetworkImage(
            img.toString(),
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget buildIndicator() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: AnimatedSmoothIndicator(
        activeIndex: currentindex,
        count: images.length,
        effect: ExpandingDotsEffect(
          dotHeight: 10,
          dotWidth: 10,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  CarouselSlider.builder(
                    options: CarouselOptions(
                        //    enableInfiniteScroll: false,
                        viewportFraction: 1,
                        height: 350.0,
                        autoPlay: false,
                        autoPlayInterval: Duration(seconds: 5),
                        onPageChanged: (index, reason) {
                          setState(() {
                            currentindex = index;
                          });
                        }),
                    itemCount: images.length,
                    itemBuilder: (context, index, realIndex) {
                      final img = images[index];
                      return buildImage(img, index);
                    },
                  ),
                  buildIndicator(),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  eventname,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: kbuttonbackgroundcolorbc1,
                      child: Icon(
                        Icons.calendar_month_outlined,
                        color: kbuttonbackcolor,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            date,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            time,
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: kbuttonbackgroundcolorbc1,
                      child: Icon(
                        Icons.location_on,
                        color: kbuttonbackcolor,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            location,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            location2,
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5),
                child: Padding(
                  padding: EdgeInsets.only(left: 65, right: 45),
                  child: GestureDetector(
                    onTap: () {
                      MapUtils.openMap("charusat");
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: kbuttonbackcolor,
                          borderRadius: BorderRadius.circular(15)),
                      //color: Colors.blue,
                      height: 28,
                      width: 500,
                      child: Center(
                        child: Text(
                          "See location on map",
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: kbuttonbackgroundcolorbc1,
                      child: Icon(
                        Icons.confirmation_num,
                        color: kbuttonbackcolor,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            price,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            quote,
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Padding(
                  padding: EdgeInsets.only(right: 180),
                  child: Text(
                    "About Event",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: SingleChildScrollView(
                  child: Container(
                    height: 300,
                    width: double.infinity,
                    child: Column(
                      children: [
                        ReadMoreText(
                          "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).",
                          trimLines: 3,
                          textAlign: TextAlign.justify,
                          trimMode: TrimMode.Line,
                          trimCollapsedText: "Read more",
                          trimExpandedText: "Read less",
                          moreStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: kbuttonbackcolor,
                              fontFamily: "sans-serif"),
                          lessStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: kbuttonbackcolor,
                              fontFamily: "sans-serif"),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Padding(
                            padding: EdgeInsets.only(left: 65, right: 45),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: kbuttonbackcolor,
                                  borderRadius: BorderRadius.circular(15)),
                              //color: Colors.blue,
                              height: 50,
                              width: 500,
                              child: Center(
                                child: Text(
                                  "iRegister in this event",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
