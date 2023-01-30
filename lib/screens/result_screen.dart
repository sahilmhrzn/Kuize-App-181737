import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final List<String> questions;
  final List<String> correctAns;
  final List<String> userAns;
  const ResultScreen(
      {super.key,
      required this.questions,
      required this.correctAns,
      required this.userAns});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Text(
                'Your Result',
                style: TextStyle(
                  fontSize: 28,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ResultWidget(
                  question: questions[index],
                  correctAnswer: correctAns[index],
                  userAnswer: userAns[index],
                );
              },
              separatorBuilder: (context, index) {
                return const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Divider(
                    thickness: 2,
                  ),
                );
              },
              itemCount: questions.length,
            ),
          ],
        ),
      ),
    );
  }
}

class ResultWidget extends StatelessWidget {
  final String question;
  final String correctAnswer;
  final String userAnswer;
  const ResultWidget(
      {super.key,
      required this.question,
      required this.correctAnswer,
      required this.userAnswer});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('$question $userAnswer'),
      trailing: correctAnswer == userAnswer
          ? const Text(
              'Correct',
              style: TextStyle(color: Colors.green),
            )
          : const Text(
              'Incorrect',
              style: TextStyle(color: Colors.red),
            ),
      visualDensity: const VisualDensity(
          horizontal: VisualDensity.minimumDensity,
          vertical: VisualDensity.minimumDensity),
    );
  }
}
