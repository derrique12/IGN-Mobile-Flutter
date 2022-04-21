import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ign_mobile_flutter/screens/videowebview.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:http/http.dart' as http;

class VideoPage extends StatefulWidget {
  const VideoPage({Key? key}) : super(key: key);

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  Color primary = const Color(0xFFC02E21);
  late List<String> slugs = [];
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future fetchData() async {
    final response =
        await http.get(Uri.parse('https://ign-apis.herokuapp.com/videos'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load article');
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      width: double.infinity,
      height: height - 157,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: FutureBuilder(
        future: fetchData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data['data'].length,
              itemBuilder: (context, index) {
                if (slugs.length < snapshot.data['data'].length) {
                  slugs.add(snapshot.data['data'][index]['metadata']['slug']);
                }

                return videoCard(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VideoWebView(
                          url:
                              '${snapshot.data['data'][index]['metadata']['slug']}',
                          number: index,
                          slugs: slugs,
                        ),
                      ),
                    );
                  },
                  title: snapshot.data['data'][index]['metadata']['title'],
                  image: snapshot.data['data'][index]['thumbnails'][2]['url'],
                  comment: '970',
                  time: timeago
                      .format(DateTime.parse(snapshot.data['data'][index]
                          ['metadata']['publishDate']))
                      .toString(),
                  dontKnow: snapshot.data['data'][index]['metadata']
                      ['videoSeries'],
                );
              },
            );
          }
          return const Center(child: Text('Loading....'));
        },
      ),
    );
  }

  Widget videoCard(
      {required VoidCallback onTap,
      required String title,
      required String image,
      required String comment,
      required String time,
      required String dontKnow}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            time.toUpperCase(),
            style: TextStyle(
              color: primary,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          const SizedBox(
            height: 7,
          ),
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Article image
                  Stack(clipBehavior: Clip.none, children: [
                    Image.network(
                      image,
                      width: double.infinity,
                      height: 160,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      bottom: -10,
                      left: 10,
                      child: GestureDetector(
                        onTap: onTap,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Container(
                            height: 50,
                            width: 50,
                            color: const Color(0xFFC02E21),
                            child: const Icon(
                              Icons.play_arrow_rounded,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                        ),
                      ),
                    )
                  ]),

                  const SizedBox(
                    height: 20,
                  ),
                  //Title
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),

                  ///Link and comments
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          dontKnow,
                          style: TextStyle(
                            color: primary,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.comment_outlined,
                              size: 22,
                            ),
                            const SizedBox(
                              width: 7,
                            ),
                            Text(
                              comment,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
