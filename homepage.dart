import 'package:eventzu/constants.dart';
import 'package:eventzu/customwidget/homecontainer.dart';
import 'package:eventzu/customwidget/homecontainer2.dart';
import 'package:eventzu/customwidget/shimmerforhomecontainer.dart';
import 'package:eventzu/customwidget/shimmerforhomegrid.dart';
import 'package:eventzu/my_flutter_app_icons.dart';
import 'package:eventzu/screens/ExplorePage.dart';
import 'package:eventzu/services/clubmanagement.dart';
import 'package:eventzu/services/usermanagement.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:overlay_support/overlay_support.dart';

class Homepage extends StatefulWidget {
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  static Map<String, String> eventname = {};
  static String Profile = '';
  static bool notification = false;
  static List<Map<String, String>> Eventdata = [];
  static List<Map<String, String>> EventdataMain = [];
  static List<Map<String, String>> Eventdatafortrends = [];
  static List<String> eventrendsname = [];
  static List progress = [];
  static int Length = 0;
  static bool loading = true;
  static bool Mobledataoff = false;
  void Connection() async {
    bool Mobiledata = await InternetConnectionChecker().hasConnection;
    if (Mobiledata) {
      setState(() {
        Mobledataoff = false;
      });
    } else {
      setState(() {
        Mobledataoff = true;
      });
    }
  }

  void Progressreport() {
    for (var i = 0; i < eventname.length; i++) {
      setState(() {
        progress.add(false);
      });
    }
  }

  int count = 0;
  void getdata() async {
    count++;
    print('count====>$count');

    Map<String, String> eventdatafortrends =
        await Clubmanagement().EventTrensdata();
    eventdatafortrends.forEach((key, value) {
      eventrendsname.add(key);
    });
    print('Eventrendsname===>$eventrendsname');
    if (eventrendsname.length > 2) {
      Length = 1;
      for (int i = 0; i < 1; i++) {
        // print('iiiiii=>$i');
        Map<String, String> eventdata1 =
            await Clubmanagement().Eventdata('${eventrendsname[i]}');
        // print("Eventdata1=====>$eventdata1");
        Eventdatafortrends.add(eventdata1);
      }
    } else {
      for (int i = 0; i < eventrendsname.length; i++) {
        Map<String, String> eventdata1 =
            await Clubmanagement().Eventdata('${eventrendsname[i]}');
        Eventdatafortrends.add(eventdata1);
      }
    }
    Length = Eventdata.length;
    print("Eventdatafortrends====>$Eventdatafortrends");

    Map<String, String> eventname1 = await Clubmanagement().Eventname();
    setState(() {
      eventname.addAll(eventname1);
    });
    Progressreport();
    for (var i = 0; i < eventname.length; i++) {
      Map<String, String> eventdata1 =
          await Clubmanagement().Eventdata('${eventname['$i']}');
      Eventdata.add(eventdata1);
      EventdataMain.add(eventdata1);
    }
    setState(() {
      loading = false;
    });
  }

  void getprofile() async {
    final profile = await userdata().GetUserImage();
    setState(() {
      Profile = profile;
    });
  }

  void refresh(bool refreshed) async {
    if (refreshed = true) {
      Eventdata = [];
      EventdataMain = [];
      Eventdatafortrends = [];
      getdata();
      getprofile();
      Connection();
    }
  }

  TextEditingController searchcontroller = TextEditingController();
  FocusNode _textFieldFocus = FocusNode();
  Color _color = kbuttonbackgroundcolor;
  Color _coloricon = Color(0xFF5e5e63);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (Eventdata.isEmpty) {
        getdata();
        getprofile();
        Connection();
      }
    });
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbuttonbackgroundcolor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(Profile),
            radius: 10,
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                'Welcome to Eventin',
                style: TextStyle(
                    fontSize: 10.0,
                    fontFamily: 'sans-serif',
                    color: kdividertextcolor),
              ),
              Text(
                'User name',
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 20.0,
                    fontFamily: 'sans-serif',
                    color: kTextcolor),
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Container(
              width: 35.0,
              height: 35.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 1.0, color: kdividertextcolor),
              ),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Positioned(
                    right: 5,
                    top: 15,
                    child: Icon(
                      MyFlutterApp.notification_alert_svgrepo_com,
                      color: kTextcolor,
                    ),
                  ),
                  Positioned(
                      right: 5,
                      top: 15,
                      child: notification == true
                          ? Icon(
                              Icons.circle_sharp,
                              color: Colors.red,
                              size: 10.0,
                            )
                          : Icon(
                              Icons.circle_sharp,
                              size: 10.0,
                              color: Colors.transparent,
                            )),
                ],
              ),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            loading = true;
          });
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            refresh(true);
          });
        },
        child: OverlaySupport.global(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: searchcontroller,
                      onTap: () {
                        Future.delayed(Duration(seconds: 3));
                        FocusScope.of(context).unfocus();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ExplorePage()));
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
                SizedBox(
                  width: double.infinity,
                  height: 350.0,
                  child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount:
                          eventrendsname.length > 2 ? 1 : eventrendsname.length,
                      itemBuilder: (context, index) {
                        if (loading == false || Mobledataoff == true) {
                          return Row(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  setState(() {
                                    progress[index] = true;
                                  });
                                  Future.delayed(const Duration(seconds: 2));
                                  setState(() {
                                    progress[index] = false;
                                  });
                                },
                                child: HomecontainerTrends(
                                  onTap: progress[index],
                                  Eventype:
                                      '${Eventdatafortrends[index]['type']}',
                                  Eventname:
                                      '${Eventdatafortrends[index]['eventname']}',
                                  Eventdate:
                                      '${Eventdatafortrends[index]['date']}',
                                  Eventclubname:
                                      '${Eventdatafortrends[index]['clubname']}',
                                  Eventiimage:
                                      '${Eventdatafortrends[index]['image']}',
                                ),
                              ),
                            ],
                          );
                        } else {
                          return Row(
                            children: [
                              const ShimmerForHomePage(),
                            ],
                          );
                        }
                      }),
                ),
                GridView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.70,
                  ),
                  itemCount: eventname.length,
                  itemBuilder: (context, index) {
                    if (loading == false || Mobledataoff == true) {
                      return Homecontainerall(
                        onTap: false,
                        Eventype: '${Eventdata[index]['type']}',
                        Eventname: '${Eventdata[index]['eventname']}',
                        Eventdate: '${Eventdata[index]['date']}',
                        Eventclubname: '${Eventdata[index]['clubname']}',
                        Eventiimage: '${Eventdata[index]['image']}',
                      );
                    } else {
                      return const ShimmerForHomeGrid();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
