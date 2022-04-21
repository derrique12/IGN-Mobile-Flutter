import 'package:flutter/material.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({Key? key}) : super(key: key);

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  Color primary = const Color(0xFFC02E21);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(children: [
        videoCard(
          onTap: () {
            //TODO:Open video
          },
          image: 'assets/wolf.jpg',
          description:
              'The beta will run from september 2-4 and will be opened to all PS4 owners event those without a PS Subscription',
          profile: 'assets/wolf.jpg',
          writer: 'Tom Marks',
          comment: '300',
          time: '2 mins ago',
          dontKnow: 'THE ORANGE BOX',
        ),
        videoCard(
          onTap: () {
            //TODO:Open video
          },
          image: 'assets/wolf.jpg',
          description:
              'The beta will run from september 2-4 and will be opened to all PS4 owners event those without a PS Subscription',
          profile: 'assets/wolf.jpg',
          writer: 'Tom Marks',
          comment: '300',
          time: '2 mins ago',
          dontKnow: 'THE ORANGE BOX',
        ),
      ]),
    );
  }

  Widget videoCard(
      {required VoidCallback onTap,
      required String description,
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
                    Stack(clipBehavior: Clip.none, children: [
                      Image.asset(
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
                    //Article description
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Text(
                        description,
                        maxLines: 3,
                        style: const TextStyle(
                            overflow: TextOverflow.ellipsis, fontSize: 15),
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
