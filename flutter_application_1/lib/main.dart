import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/welcomescreen.dart';
import 'package:provider/provider.dart';
import 'controller/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => IndexNotifier(),
      child: MaterialApp(
          title: 'Quiz App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark(),
          home: Welcomescreen()),
    );
  }
}
