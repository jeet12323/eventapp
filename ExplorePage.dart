import 'package:eventzu/constants.dart';
import 'package:eventzu/customwidget/Textfieldwithprefixicon.dart';
import 'package:eventzu/customwidget/explorecontaner.dart';
import 'package:eventzu/customwidget/shmmerforclublist.dart';
import 'package:eventzu/my_flutter_app_icons.dart';
import 'package:eventzu/services/clubmanagement.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  @override
  Map<String, String> eventname = {};
  List<Map<String, String>> Eventdata = [];
  List<Map<String, String>> EventdataMain = [];
  bool loading = true;
  void getdata() async {
    Future.delayed(const Duration(seconds: 2));
    Map<String, String> eventname1 = await Clubmanagement().Eventname();
    setState(() {
      eventname.addAll(eventname1);
    });
    for (var i = 0; i < eventname.length; i++) {
      // print('iiiiii=>$i');
      Map<String, String> eventdata1 =
          await Clubmanagement().Eventdata('${eventname['$i']}');
      print("Eventdata1=====>$eventdata1");
      Eventdata.add(eventdata1);
      EventdataMain.add(eventdata1);
    }
    print('EventdataMain====>$EventdataMain');
    print('Eventdata====>$Eventdata');
    setState(() {
      loading = false;
    });
  }

  TextEditingController searchcontroller = TextEditingController();
  FocusNode _textFieldFocus = FocusNode();
  Color _color = kbuttonbackgroundcolor;
  Color _coloricon = Color(0xFF5e5e63);
  void initState() {
    _textFieldFocus.addListener(() {
      if (_textFieldFocus.hasFocus) {
        setState(() {
          _color = Color(0xFFf2f1ff);
          _coloricon = Color(0xFF584cf4);
        });
      } else {
        setState(() {
          _color = kbuttonbackgroundcolor;
          _coloricon = Color(0xFF5e5e63);
        });
      }
    });
    super.initState();
    getdata();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: BackButton(
          color: kTextcolor,
        ),
        title: Text(
          'Events',
          style: TextStyle(
              fontFamily: 'sans-serif', color: kTextcolor, fontSize: 20.0),
          textAlign: TextAlign.center,
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: searchcontroller,
                  onChanged: (value) {
                    print("vaule===>$value");
                    if (value == ' ') {
                      setState(() {
                        Eventdata = EventdataMain;
                      });
                    }

                    final serach = value.toLowerCase();
                    List<Map<String, String>> searchitem = [];
                    final serachelement = EventdataMain.forEach((element) {
                      if (element['clubname']!.toLowerCase().contains(value)) {
                        searchitem.add(element);
                      } else {
                        if (element['type']!.toLowerCase().contains(value)) {
                          searchitem.add(element);
                        } else {
                          if (element['eventname']!
                              .toLowerCase()
                              .contains(serach)) {
                            searchitem.add(element);
                          }
                        }
                      }
                      // if (element['clubname']!.contains(value) ||
                      //     element['type']!.contains(value) ||
                      //     element['eventname']!.contains(serach)) {
                      //   searchitem.add(element);
                      // }
                    });
                    // print('serachitem===>$searchitem');
                    setState(() {
                      Eventdata = searchitem;
                    });
                    print('searchitem===>$searchitem');
                  },
                  focusNode: _textFieldFocus,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      FontAwesomeIcons.search,
                      color: _coloricon,
                    ),
                    suffixIcon: Icon(
                      MyFlutterApp.sliders_horizontal_thin_svgrepo_com,
                      color: _coloricon,
                    ),
                    fillColor: _color,
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        width: 2.0,
                        color: Color(0xFF7b72f7),
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'What event are you looking for',
                    hintStyle: TextStyle(
                      fontFamily: "inter" "sans-serif",
                      color: kdividertextcolor,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
            ),
            loading == false
                ? ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: Eventdata.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ExpolerContainer(
                        onTap: false,
                        Eventype: '${Eventdata[index]['type']}',
                        Eventname: '${Eventdata[index]['eventname']}',
                        Eventdate: '${Eventdata[index]['date']}',
                        EventLocation: '${Eventdata[index]['clubname']}',
                        Eventiimage: '${Eventdata[index]['image']}',
                      );
                    })
                : ListView.builder(
                    itemCount: Eventdata.length,
                    scrollDirection: Axis.vertical,
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ShimmerClubsContainer();
                    })
          ],
        ),
      ),
    );
  }
}
