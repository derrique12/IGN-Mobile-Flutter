import 'package:flutter/material.dart';
import 'package:ign_mobile_flutter/screens/articles.dart';
import 'package:ign_mobile_flutter/screens/videos.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Color primary = const Color(0xFFC02E21);
  bool articleSelect = true;
  bool videoSelect = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    // /double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          height: height,
          child: Column(
            children: [
              //AppBAr
              SizedBox(
                height: 157,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 35),
                      width: double.infinity,
                      height: 90,
                      color: primary,
                      child: Center(
                        child: Image.asset(
                          'assets/logo.png',
                          height: 30,
                          fit: BoxFit.fitHeight,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    //Articles and Videos Selection
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          titleMenu(
                            onTap: () {
                              setState(() {
                                articleSelect = true;
                                videoSelect = false;
                              });
                            },
                            title: 'Articles',
                            selected: articleSelect,
                            icon: Icons.article,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          titleMenu(
                              onTap: () {
                                setState(() {
                                  articleSelect = false;
                                  videoSelect = true;
                                });
                              },
                              title: "Videos",
                              selected: videoSelect,
                              icon: Icons.play_arrow_rounded),
                        ],

                        //
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                  width: double.infinity,
                  height: height - 157,
                  child: SingleChildScrollView(
                    child:
                        articleSelect ? const ArticlePage() : const VideoPage(),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget titleMenu(
      {required VoidCallback onTap,
      required String title,
      required bool selected,
      required IconData icon}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 13),
        decoration: BoxDecoration(
          border: selected
              ? const Border(
                  bottom: BorderSide(color: Colors.black, width: 5),
                )
              : Border.all(color: Colors.white),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: selected ? Colors.black : Colors.grey,
              size: title == "Articles" ? 20 : 30,
            ),
            const SizedBox(width: 4),
            Text(
              title.toUpperCase(),
              style: TextStyle(
                color: selected ? Colors.black : Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 19,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
