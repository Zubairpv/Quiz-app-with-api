import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/constants.dart';
import '../model/model.dart';

class IndexNotifier extends ChangeNotifier {
  List<Welcome> data = [];
  ProviderStatus status = ProviderStatus.LOADING;
  bool answerWasSelected = false;
  bool endQuiz = false;
  int _currentIndex = 0;
  int totalScore = 0;
  bool updateContainer1 = true;
  int get currentIndex => _currentIndex;

  set currentIndex(int value) {
    _currentIndex = value;
    notifyListeners();
  }

  fetchQuestion() async {
    final response = await http
        .get(Uri.parse('https://637dbfffcfdbfd9a639bba1e.mockapi.io/sample'));
    if (response.statusCode == 200) {
      data = welcomeFromJson(response.body);
      status = ProviderStatus.COMPLETED;
    } else {
      throw Exception('Failed to load album');
    }
    notifyListeners();
  }
}
