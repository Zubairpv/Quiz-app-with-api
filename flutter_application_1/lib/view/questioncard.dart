import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/score.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../controller/provider.dart';
import '../controller/question_controller.dart';
import '../model/constants.dart';
import 'options.dart';

class Questioncard extends StatefulWidget {
  const Questioncard({
    Key? key,
  }) : super(key: key);

  @override
  State<Questioncard> createState() => _QuestioncardState();
}

class _QuestioncardState extends State<Questioncard> {
  int buttenindex = -1;
  int questionindex = 1;
  int totalscore = 0;
  bool? answerwasselected = false;
  int indexfornextque = 0;
  bool match = false;
  List<String> optinosIndictor = ['A.', "B.", "C.", "D.", "E."];

  @override
  Widget build(BuildContext context) {
    final QuestionController controller = Get.put(QuestionController(context));

    final indexProvider = Provider.of<IndexNotifier>(context);
    // ignore: non_constant_identifier_names
    ResetQuiz() {
      indexProvider.totalScore = 0;
      indexProvider.endQuiz = false;
      indexProvider.currentIndex = 0;
    }

    // ignore: non_constant_identifier_names
    void AnswerClicked(bool userScore) {
      setState(() {
        indexProvider.answerWasSelected = true;

        if (userScore) {
          indexProvider.totalScore++;
        }

        if (indexProvider.currentIndex + 1 ==
            indexProvider.data[0].questions.length) {
          indexProvider.endQuiz = true;
        }
      });
    }

    return Consumer<IndexNotifier>(
      builder: (context, getdata, child) {
        getdata.fetchQuestion();
        if (getdata.status == ProviderStatus.COMPLETED) {
          return Container(
              margin: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
              width: 400,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(25)),
              child: Column(children: [
                Container(
                  height: 90,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25)),
                  child: Text(
                    getdata.data[0].questions[indexProvider.currentIndex].question,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(
                  height: 380,
                  child: ListView.builder(
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      buttenindex = index;
                      int correctindex = getdata.data[0]
                          .questions[indexProvider.currentIndex].correctIndex;
                      buttenindex == correctindex
                          ? match = true
                          : match = false;
                      return option(
                          text:
                              '${optinosIndictor[index]}-${getdata.data[0].questions[indexProvider.currentIndex].answers[index]}',
                          index: questionindex,
                          press: () {
                            if (indexProvider.answerWasSelected) {
                              return;
                            }
                            AnswerClicked(
                              match,
                            );
                            controller.anime.stop();
                          },
                          volor: indexProvider.answerWasSelected
                              ? match
                                  ? Colors.green
                                  : Colors.red
                              : const Color.fromARGB(255, 61, 57, 57),
                          icon: indexProvider.answerWasSelected
                              ? match
                                  ? Icons.check
                                  : Icons.cancel
                              : Icons.circle_outlined);
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          elevation: MaterialStateProperty.all(0)),
                      onPressed: () {
                        if (indexProvider.currentIndex <= 0) {
                          return;
                        }
                        indexProvider.currentIndex =
                            (indexProvider.currentIndex - 1) %
                                getdata.data[0].questions.length;
                        controller.anime.reset();
                        controller.anime.forward().whenComplete(() {
                          indexProvider.currentIndex++;
                          controller.anime.reset();
                          controller.anime.forward();
                        });
                      },
                      // ignore: prefer_const_literals_to_create_immutables
                      child: Row(children: [
                        const Icon(
                          Icons.arrow_back_ios_new_outlined,
                          color: Colors.black,
                        ),
                        const Text(
                          'Back',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ]),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          elevation: MaterialStateProperty.all(0)),
                      onPressed: () {
                        if (indexProvider.endQuiz == false) {
                          indexProvider.currentIndex++;

                          controller.anime.reset();
                          controller.anime.forward().whenComplete(() {
                            indexProvider.currentIndex++;
                            controller.anime.reset();
                            controller.anime
                                .forward()
                                .whenComplete(() => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const Score(
                                                imageurl: 'assets/icons/oh.gif',
                                                situation:
                                                    "You've missed two chances.",
                                              )),
                                    ));
                          });
                          indexProvider.answerWasSelected = false;
                          if (indexProvider.currentIndex >=
                              getdata.data[0].questions.length) {
                            ResetQuiz();
                          }
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Score(
                                      imageurl: indexProvider.totalScore >= 5
                                          ? 'assets/icons/gj.gif'
                                          : 'assets/icons/oops.gif',
                                      situation: indexProvider.totalScore >= 5
                                          ? 'Great'
                                          : 'oops!!!',
                                    )),
                          );
                        }
                      },
                      child: Row(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          const Text(
                            'Next',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ]));
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
