// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<Welcome> welcomeFromJson(String str) =>
    List<Welcome>.from(json.decode(str).map((x) => Welcome.fromJson(x)));

String welcomeToJson(List<Welcome> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Welcome {
  Welcome({
    required this.createdAt,
    required this.name,
    required this.avatar,
    required this.questions,
    required this.id,
  });

  DateTime createdAt;
  String name;
  String avatar;
  List<Question> questions;
  String id;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        createdAt: DateTime.parse(json["createdAt"]),
        name: json["name"],
        avatar: json["avatar"],
        questions: List<Question>.from(
            json["questions"].map((x) => Question.fromJson(x))),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt.toIso8601String(),
        "name": name,
        "avatar": avatar,
        "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
        "id": id,
      };
}

class Question {
  Question({
    required this.question,
    required this.answers,
    required this.correctIndex,
  });

  String question;
  List<String> answers;
  int correctIndex;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        question: json["question"],
        answers: List<String>.from(json["answers"].map((x) => x)),
        correctIndex: json["correctIndex"],
      );

  Map<String, dynamic> toJson() => {
        "question": question,
        "answers": List<dynamic>.from(answers.map((x) => x)),
        "correctIndex": correctIndex,
      };
}
