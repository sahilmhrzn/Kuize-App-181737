import 'package:flutter/material.dart';
import 'package:kuize_app/screens/result_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController controller = PageController();
  final key = GlobalKey<FormState>();
  TextEditingController answerController = TextEditingController();
  int currentIndex = 0;

  List<String> questions = [
    '60 + 9  = ',
    '10 + 5 = ',
    '2 * 7 = ',
    '20 / 2 = ',
    '12 - 3 = '
  ];
  List<String> correctAnswerList = ['69', '15', '14', '10', '9'];

  List<String> userAnswerList = [];

  toNextPage() async {
    await controller.nextPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeIn,
    );
    setState(() {
      answerController.text = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kuize'),
        centerTitle: true,
      ),
      body: Form(
        key: key,
        child: Column(
          children: <Widget>[
            Expanded(
              child: PageView.builder(
                controller: controller,
                onPageChanged: (value) {
                  setState(() {
                    currentIndex = value;
                  });
                },
                itemCount: questions.length,
                itemBuilder: (context, index) => QuizWidget(
                  onTap: () {
                    if (key.currentState!.validate()) {
                      setState(() {
                        userAnswerList.add(answerController.text);
                      });
                      if ((currentIndex + 1) >= questions.length) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ResultScreen(
                              questions: questions,
                              correctAns: correctAnswerList,
                              userAns: userAnswerList,
                            ),
                          ),
                        );
                      }
                      toNextPage();
                    }
                  },
                  controller: answerController,
                  question: questions[index],
                ),
              ),
            ),
            Text(
              '${currentIndex + 1}/${questions.length}',
              style: const TextStyle(fontSize: 15),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class QuizWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String question;
  final TextEditingController controller;
  const QuizWidget({
    super.key,
    required this.onTap,
    required this.question,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            height: 20,
          ),
          Text(
            '$question ?',
            style: const TextStyle(
              fontSize: 42,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: controller,
            validator: (value) {
              if (value == null || value == '') {
                return 'Please fill up your answer';
              }
              return null;
            },
            style: const TextStyle(fontSize: 20),
            decoration: const InputDecoration(
              hintText: 'Enter your answer',
              hintStyle: TextStyle(fontSize: 18),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          ElevatedButton(
            onPressed: onTap,
            child: Text('Next'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green[800],
              // textStyle:
              //     TextStyle(fontSize: 30, fontWeight: FontWeight.bold)
            ),
          ),
        ],
      ),
    );
  }
}
