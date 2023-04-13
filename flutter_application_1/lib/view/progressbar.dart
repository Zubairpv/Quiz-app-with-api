import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:websafe_svg/websafe_svg.dart';

import '../controller/question_controller.dart';

class Progressbar extends StatelessWidget {
  const Progressbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 35,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF3F4768), width: 3),
        borderRadius: BorderRadius.circular(50),
      ),
      child: GetBuilder<QuestionController>(
          init: QuestionController(context),
          builder: (controller) {
            return Stack(children: [
              LayoutBuilder(
                  builder: (context, constraints) => Container(
                        width:
                            constraints.maxWidth * controller.animation.value,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(50), // <-- Radius
                            gradient: const LinearGradient(
                              colors: [Color(0xFF46A0AE), Color(0xFF00FFCB)],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            )),
                      )),
              Positioned.fill(
                  child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${(controller.animation.value * 10).round()}'),
                    WebsafeSvg.asset('assets/icons/clock.svg')
                  ],
                ),
              ))
            ]);
          }),
    );
  }
}
