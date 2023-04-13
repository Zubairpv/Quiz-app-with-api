import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/progressbar.dart';
import 'package:flutter_application_1/view/questioncard.dart';

import 'package:provider/provider.dart';
import 'package:websafe_svg/websafe_svg.dart';

import '../controller/provider.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final indexProvider = Provider.of<IndexNotifier>(context);
    return Scaffold(
      body: Stack(
        children: [
          WebsafeSvg.asset("assets/icons/bg.svg", fit: BoxFit.fill),
          SafeArea(
              child: Column(
            children: [
              const Center(
                child: Progressbar(),
              ),
              Text.rich(TextSpan(
                  text: '${indexProvider.currentIndex + 1}',
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(color: const Color(0xFF8B94BC)),
                  children: [
                    TextSpan(
                      text: '/12',
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(color: Color(0xFF8B94BC)),
                    )
                  ])),
              const Divider(thickness: 1.5),
              const SizedBox(height: 20),
               Expanded(child: Questioncard()),
            ],
          ))
        ],
      ),
    );
  }
}


