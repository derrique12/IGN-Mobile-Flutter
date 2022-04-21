import 'package:flutter/material.dart';
import 'package:ign_mobile_flutter/screens/articlewebview.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:http/http.dart' as http;
import 'dart:convert';

class ArticlePage extends StatefulWidget {
  const ArticlePage({Key? key}) : super(key: key);

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  Color primary = const Color(0xFFC02E21);
  late List<String> slugs = [];
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future fetchData() async {
    final response =
        await http.get(Uri.parse('https://ign-apis.herokuapp.com/articles'));
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
      height: height - 167,
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
                if (snapshot.data['data'][index]['metadata']['description'] ==
                    null) {
                  return article2Card(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ArticleWebView(
                            url:
                                '${snapshot.data['data'][index]['metadata']['slug']}',
                            number: index,
                            slugs: slugs,
                          ),
                        ),
                      );
                    },
                    title: snapshot.data['data'][index]['metadata']['headline'],
                    image: snapshot.data['data'][index]['thumbnails'][2]['url'],
                    profile: snapshot.data['data'][index]['authors'].length > 0
                        ? snapshot.data['data'][index]['authors'][0]
                                    ['thumbnail'] ==
                                ''
                            ? 'https://oystatic.ignimgs.com/src/core/img/social/avatars/ign.jpg'
                            : snapshot.data['data'][index]['authors'][0]
                                ['thumbnail']
                        : "https://images.genius.com/393bfda8da80c5024e572eb01cf58020.900x900x1.jpg",
                    writer: snapshot.data['data'][index]['authors'].length > 0
                        ? snapshot.data['data'][index]['authors'][0]['name']
                        : "Unknown author",
                    comment: '970',
                    time: timeago
                        .format(DateTime.parse(snapshot.data['data'][index]
                            ['metadata']['publishDate']))
                        .toString(),
                    dontKnow: snapshot.data['data'][index]['tags'].length > 0
                        ? snapshot.data['data'][index]['tags'][0]
                        : 'none',
                  );
                } else {
                  return articleCard(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ArticleWebView(
                            url:
                                '${snapshot.data['data'][index]['metadata']['slug']}',
                            number: index,
                            slugs: slugs,
                          ),
                        ),
                      );
                    },
                    title: snapshot.data['data'][index]['metadata']['headline'],
                    image: snapshot.data['data'][index]['thumbnails'][2]['url'],
                    description: snapshot.data['data'][index]['metadata']
                            ['description'] ??
                        '',
                    profile: snapshot.data['data'][index]['authors'].length > 0
                        ? snapshot.data['data'][index]['authors'][0]
                                    ['thumbnail'] ==
                                ''
                            ? 'https://oystatic.ignimgs.com/src/core/img/social/avatars/ign.jpg'
                            : snapshot.data['data'][index]['authors'][0]
                                ['thumbnail']
                        : "https://images.genius.com/393bfda8da80c5024e572eb01cf58020.900x900x1.jpg",
                    writer: snapshot.data['data'][index]['authors'].length > 0
                        ? snapshot.data['data'][index]['authors'][0]['name']
                        : "Unknown author",
                    comment: '970',
                    time: timeago
                        .format(DateTime.parse(snapshot.data['data'][index]
                            ['metadata']['publishDate']))
                        .toString(),
                    dontKnow: snapshot.data['data'][index]['tags'].length > 0
                        ? '${snapshot.data['data'][index]['tags'][0]},${snapshot.data['data'][index]['tags'][1]}'
                        : 'none',
                  );
                }
              },
            );
          }
          return const Center(child: Text('Loading....'));
        },
      ),
    );
  }

  Widget articleCard(
      {required VoidCallback onTap,
      required String title,
      required String image,
      required String description,
      required String profile,
      required String writer,
      required String comment,
      required String time,
      required String dontKnow}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Title
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  //Article image
                  Image.network(
                    image,
                    width: double.infinity,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  //Article description
                  Text(
                    description,
                    maxLines: 3,
                    style: const TextStyle(
                        overflow: TextOverflow.ellipsis, fontSize: 15),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  //Writer profile and name
                  Row(
                    children: [
                      //Profile
                      ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: SizedBox(
                          height: 36,
                          width: 36,
                          child: Image.network(
                            profile,
                            height: 36,
                            width: 36,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      //Name
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: RichText(
                          text: TextSpan(
                              style: const TextStyle(color: Colors.black),
                              children: [
                                const TextSpan(text: 'By '),
                                TextSpan(
                                  text: writer,
                                  style: const TextStyle(
                                      decoration: TextDecoration.underline),
                                )
                              ]),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),

                  ///Link and comments
                  Row(
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
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget article2Card(
      {required VoidCallback onTap,
      required String title,
      required String image,
      required String profile,
      required String writer,
      required String comment,
      required String time,
      required String dontKnow}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //Article image
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Image.network(
                          image,
                          width: double.infinity,
                          height: 165,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          bottom: -38,
                          right: MediaQuery.of(context).size.width * 0.37,
                          child: SizedBox(
                            height: 120,
                            width: 60,
                            child: Stack(
                              children: [
                                Center(
                                    child: Image.asset(
                                  'assets/Hexagon.png',
                                  height: 110,
                                  fit: BoxFit.cover,
                                  color: const Color(0xFFC02E21),
                                )),
                                const Positioned(
                                  left: 15,
                                  top: 52,
                                  child: Icon(
                                    Icons.menu,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),

                    const SizedBox(
                      height: 35,
                    ),
                    //Title
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    //Writer profile and name
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //Profile
                        ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: SizedBox(
                            height: 36,
                            width: 36,
                            child: Image.network(
                              profile,
                              fit: BoxFit.cover,
                              height: 36,
                              width: 36,
                            ),
                          ),
                        ),
                        //Name
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: RichText(
                            text: TextSpan(
                                style: const TextStyle(color: Colors.black),
                                children: [
                                  const TextSpan(text: 'By '),
                                  TextSpan(
                                    text: writer,
                                    style: const TextStyle(
                                        decoration: TextDecoration.underline),
                                  )
                                ]),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Container(
                        width: double.infinity,
                        height: 1,
                        color: const Color.fromARGB(181, 158, 158, 158),
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
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
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
      ),
    );
  }
}
