import 'package:flutter/material.dart';

void main() {
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quiz App',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      home: const QuizScreen(),
    );
  }
}

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _questionIndex = 0;
  int _score = 0;

  final List<Map<String, Object>> _questions = [
    {
      'question': 'What is Flutter?',
      'answers': [
        {'text': 'A UI toolkit', 'score': 1},
        {'text': 'A programming language', 'score': 0},
        {'text': 'A database', 'score': 0},
      ],
    },
    {
      'question': 'Which language does Flutter use?',
      'answers': [
        {'text': 'Java', 'score': 0},
        {'text': 'Dart', 'score': 1},
        {'text': 'Python', 'score': 0},
      ],
    },
    {
      'question': 'Who developed Flutter?',
      'answers': [
        {'text': 'Google', 'score': 1},
        {'text': 'Facebook', 'score': 0},
        {'text': 'Microsoft', 'score': 0},
      ],
    },
  ];

  void _answerQuestion(int score) {
    setState(() {
      _score += score;
      _questionIndex++;
    });
  }

  void _restartQuiz() {
    setState(() {
      _questionIndex = 0;
      _score = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quiz App')),
      body: _questionIndex < _questions.length
          ? Quiz(
              question: _questions[_questionIndex]['question'] as String,
              answers: _questions[_questionIndex]['answers'] as List<Map<String, Object>>,
              onAnswer: _answerQuestion,
            )
          : Result(score: _score, restartQuiz: _restartQuiz),
    );
  }
}

class Quiz extends StatelessWidget {
  final String question;
  final List<Map<String, Object>> answers;
  final Function(int) onAnswer;

  const Quiz({super.key, required this.question, required this.answers, required this.onAnswer});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(question, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          ...answers.map((answer) {
            return ElevatedButton(
              onPressed: () => onAnswer(answer['score'] as int),
              child: Text(answer['text'] as String),
            );
          }).toList(),
        ],
      ),
    );
  }
}

class Result extends StatelessWidget {
  final int score;
  final VoidCallback restartQuiz;

  const Result({super.key, required this.score, required this.restartQuiz});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Your Score: $score', style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: restartQuiz,
            child: const Text('Restart Quiz'),
          ),
        ],
      ),
    );
  }
}
