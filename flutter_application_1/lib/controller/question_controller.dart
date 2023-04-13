import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/provider.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:provider/provider.dart';
import '../view/score.dart';

class QuestionController extends GetxController
    with SingleGetTickerProviderMixin {
  final BuildContext context;

  late AnimationController _animationController;

  QuestionController(this.context);
  AnimationController get anime => _animationController;
  late Animation _animation;

  Animation get animation => this._animation;

  @override
  void onInit() {
    final indexProvider = Provider.of<IndexNotifier>(context);
    _animationController =
        AnimationController(duration: const Duration(seconds: 20), vsync: this);
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addListener(() {
        update();
      });
    _animationController.forward().whenComplete(() {
      indexProvider.currentIndex++;
      _animationController.reset();
      _animationController.forward().whenComplete(() {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const Score(
                    imageurl: 'assets/icons/oh.gif',
                    situation: "You've missed two chances.",
                  )),
        );
      });
    });
    super.onInit();
  }
}
