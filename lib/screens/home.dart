import 'package:flutter/material.dart';
import 'package:ign_mobile_flutter/screens/articles.dart';
import 'package:ign_mobile_flutter/screens/videos.dart';
import 'package:http/http.dart';

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
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;
    // /double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
              child: Column(
            children: [
              //AppBAr
              Container(
                width: double.infinity,
                height: 60,
                color: primary,
                child: Center(
                  child: Image.asset(
                    'assets/logo.png',
                    height: 50,
                    fit: BoxFit.fitHeight,
                    color: Colors.white,
                  ),
                ),
              ),
              //Articles and Videos Selection
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  titleMenu(
                    onTap: () {
                      articleSelect = true;
                      videoSelect = false;
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
                        articleSelect = false;
                        videoSelect = true;
                      },
                      title: "Videos",
                      selected: videoSelect,
                      icon: Icons.play_arrow_outlined),
                ],

                //
              ),
              articleSelect ? const ArticlePage() : const VideoPage(),
            ],
          )),
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
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: selected
              ? const Border(
                  bottom: BorderSide(color: Colors.black, width: 2),
                )
              : Border.all(width: 0),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: selected ? Colors.black : Colors.grey,
              size: 18,
            ),
            Text(
              title,
              style: TextStyle(
                color: selected ? Colors.black : Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
