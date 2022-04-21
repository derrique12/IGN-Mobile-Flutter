import 'package:flutter/material.dart';
import 'package:ign_mobile_flutter/models/articleModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ArticlePage extends StatefulWidget {
  const ArticlePage({Key? key}) : super(key: key);

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  Color primary = const Color(0xFFC02E21);
  late Future<Article> futureArticle;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureArticle = fetchData();
  }

  Future<Article> fetchData() async {
    final response =
        await http.get(Uri.parse('https://ign-apis.herokuapp.com/articles'));

    if (response.statusCode == 200) {
      return Article.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child:
          //  FutureBuilder(
          //   future: futureArticle,
          //   builder: (context, snapshot) {
          //     if (snapshot.hasData) {
          //       return articleCard(
          //         onTap: () {
          //           //TODO:Open article
          //         },
          //         title: '',
          //         image: '',
          //         description: '',
          //         profile: '',
          //         writer: '',
          //         comment: '',
          //         time: '',
          //         dontKnow: '',
          //       );
          //     }
          //     return Container();
          //   },
          // ),
          Column(
        children: [
          articleCard(
            onTap: () {
              //TODO:Open article
            },
            title: 'Sea of Thiefs Releases Admist Vast Server Issues',
            image: 'assets/wolf.jpg',
            description:
                'The beta will run from september 2-4 and will be opened to all PS4 owners event those without a PS Subscription',
            profile: 'assets/wolf.jpg',
            writer: 'Tom Marks',
            comment: '300',
            time: '2 mins ago',
            dontKnow: 'THE ORANGE BOX',
          ),
          article2Card(
            onTap: () {
              //TODO:Open article
            },
            title: 'Sea of Thiefs Releases Admist Vast Server Issues',
            image: 'assets/wolf.jpg',
            profile: 'assets/wolf.jpg',
            writer: 'Tom Marks',
            comment: '300',
            time: '2 mins ago',
            dontKnow: 'THE ORANGE BOX',
          ),
        ],
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
                  Image.asset(
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
                          child: Image.asset(
                            profile,
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
                        Image.asset(
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
                            child: Image.asset(
                              profile,
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
