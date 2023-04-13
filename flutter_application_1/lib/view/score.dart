import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/body.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:websafe_svg/websafe_svg.dart';
import '../controller/provider.dart';
import '../controller/question_controller.dart';

class Score extends StatelessWidget {
  final String imageurl;
  final String situation;

  const Score({super.key, required this.imageurl, required this.situation});

  @override
  Widget build(BuildContext context) {
    final indexProvider = Provider.of<IndexNotifier>(context);
    final QuestionController controller = Get.put(QuestionController(context));
    ResetQuiz() {
      indexProvider.totalScore = 0;
      indexProvider.endQuiz = false;
      indexProvider.currentIndex = 0;
    }

    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: 400,
            height: 812,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
          Center(child: WebsafeSvg.asset('assets/icons/bg.svg')),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(situation,
                    style: GoogleFonts.habibi(
                        fontSize: 28,
                        color: Colors.white,
                        fontWeight: FontWeight.w700)),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 300,
                  height: 240,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25)),
                  child: Container(
                      width: 300,
                      height: 220,
                      decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage(imageurl)),
                      )),
                ),
                SizedBox(
                  height: 10,
                ),
                Text("You Have Scored",
                    style: GoogleFonts.oswald(
                        fontSize: 28,
                        color: Colors.white,
                        fontWeight: FontWeight.w700)),
                SizedBox(
                  height: 10,
                ),
                Text("${indexProvider.totalScore}",
                    style: GoogleFonts.roboto(
                        fontSize: 28,
                        color: Colors.white,
                        fontWeight: FontWeight.w700)),
                InkWell(
                  onTap: () {
                    indexProvider.answerWasSelected = false;
                    ResetQuiz();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Body()),
                    );
                    controller.anime.reset();
                    controller.anime.forward().whenComplete(() {
                      indexProvider.currentIndex++;
                      controller.anime.reset();
                      controller.anime
                          .forward()
                          .whenComplete(() => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Score(
                                          imageurl: 'assets/icons/oh.gif',
                                          situation:
                                              "You've missed two chances.",
                                        )),
                              ));
                    });
                  },
                  child: Container(
                      height: 100,
                      width: 200,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        image: DecorationImage(
                            image: AssetImage('assets/icons/R.png')),
                      )),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}