import 'package:flutter/material.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({Key? key}) : super(key: key);

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  Color primary = const Color(0xFFC02E21);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView.builder(
        itemBuilder: (context, index) {
          return articleCard(
            onTap: () {
              //TODO:Open article
            },
            title: '',
            image: '',
            description: '',
            profile: '',
            writer: '',
            comment: '',
            time: '',
            dontKnow: '',
          );
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
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Text(
              time,
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Colors.grey,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Article image
                  Image.asset(
                    image,
                    width: double.infinity,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  //Article description
                  Text(description),
                  const SizedBox(
                    height: 15,
                  ),
                  //Writer profile and name
                  Row(
                    children: [
                      //Profile
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: SizedBox(
                          height: 40,
                          width: 40,
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
                          text: TextSpan(children: [
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

                  ///Link and comments
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        dontKnow,
                        style: TextStyle(
                            color: primary,
                            decoration: TextDecoration.underline),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.comment_rounded,
                          ),
                          Text(comment)
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
