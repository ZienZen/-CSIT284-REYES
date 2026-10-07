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
      title: 'Flutter Quiz',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.purple,
        ),
        useMaterial3: true,
      ),
      home: const StartScreen(),
    );
  }
}



class Question {
  final String question;
  final List<String> answers;
  final int correctAnswer;

  const Question({
    required this.question,
    required this.answers,
    required this.correctAnswer,
  });
}

const questions = [
  Question(
    question: 'What programming language is Flutter based on?',
    answers: [
      'Java',
      'Dart',
      'Python',
      'C++',
    ],
    correctAnswer: 1,
  ),
  Question(
    question: 'Which widget is used to arrange widgets vertically?',
    answers: [
      'Row',
      'Stack',
      'Column',
      'Container',
    ],
    correctAnswer: 2,
  ),
  Question(
    question: 'Which function starts a Flutter application?',
    answers: [
      'startApp()',
      'runApp()',
      'mainApp()',
      'beginApp()',
    ],
    correctAnswer: 1,
  ),
  Question(
    question: 'Which widget displays text in Flutter?',
    answers: [
      'Text',
      'Label',
      'String',
      'TextView',
    ],
    correctAnswer: 0,
  ),
  Question(
    question: 'Which widget is commonly used to make a button?',
    answers: [
      'ButtonText',
      'TextButton',
      'ClickWidget',
      'PressButton',
    ],
    correctAnswer: 1,
  ),
];


class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  void startQuiz(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const QuizScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.deepPurple,
              Colors.purple,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/logo.png',
                width: 300,
              ),

              const SizedBox(height: 30),

              const Text(
                'Learn Flutter in a fun way!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () => startQuiz(context),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.deepPurple,
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 35,
                    vertical: 15,
                  ),
                ),
                child: const Text(
                  'Start Quiz',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionIndex = 0;
  int score = 0;
  int? selectedAnswer;

  void selectAnswer(int answerIndex) {
    if (selectedAnswer != null) {
      return;
    }

    setState(() {
      selectedAnswer = answerIndex;

      if (answerIndex ==
          questions[currentQuestionIndex].correctAnswer) {
        score++;
      }
    });
  }

  void nextQuestion() {
    if (selectedAnswer == null) {
      return;
    }

    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedAnswer = null;
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            score: score,
            totalQuestions: questions.length,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Quiz'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),

      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.deepPurple,
              Colors.purple,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Progress
              Text(
                'Question ${currentQuestionIndex + 1} of ${questions.length}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              LinearProgressIndicator(
                value:
                    (currentQuestionIndex + 1) / questions.length,
                backgroundColor: Colors.white30,
                color: Colors.white,
                minHeight: 8,
                borderRadius: BorderRadius.circular(10),
              ),

              const SizedBox(height: 40),

              // Question
              Text(
                question.question,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 30),

              // Answers
              ...List.generate(
                question.answers.length,
                (index) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(bottom: 15),
                    child: AnswerButton(
                      text: question.answers[index],
                      isSelected: selectedAnswer == index,
                      isCorrect:
                          index == question.correctAnswer,
                      hasAnswered: selectedAnswer != null,
                      onTap: () => selectAnswer(index),
                    ),
                  );
                },
              ),

              const Spacer(),

              // Next button
              ElevatedButton(
                onPressed:
                    selectedAnswer == null ? null : nextQuestion,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.deepPurple,
                  padding:
                      const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  currentQuestionIndex ==
                          questions.length - 1
                      ? 'Finish Quiz'
                      : 'Next Question',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class AnswerButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final bool isCorrect;
  final bool hasAnswered;
  final VoidCallback onTap;

  const AnswerButton({
    super.key,
    required this.text,
    required this.isSelected,
    required this.isCorrect,
    required this.hasAnswered,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Colors.white;

    if (hasAnswered && isCorrect) {
      backgroundColor = Colors.green;
    } else if (hasAnswered && isSelected && !isCorrect) {
      backgroundColor = Colors.red;
    }

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: hasAnswered ? null : onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          disabledBackgroundColor: backgroundColor,
          foregroundColor: Colors.black87,
          disabledForegroundColor: Colors.black87,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 18,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}


class ResultScreen extends StatelessWidget {
  final int score;
  final int totalQuestions;

  const ResultScreen({
    super.key,
    required this.score,
    required this.totalQuestions,
  });

  void restartQuiz(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const StartScreen(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final percentage = (score / totalQuestions) * 100;

    String message;

    if (percentage == 100) {
      message = 'Perfect Score! 🎉';
    } else if (percentage >= 60) {
      message = 'Great Job! 👏';
    } else {
      message = 'Keep Practicing! 💪';
    }

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.deepPurple,
              Colors.purple,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30),

            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.emoji_events,
                  color: Colors.amber,
                  size: 100,
                ),

                const SizedBox(height: 20),

                const Text(
                  'Quiz Completed!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 15),

                Text(
                  message,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 30),

                Text(
                  '$score / $totalQuestions',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(
                  '${percentage.toStringAsFixed(0)}%',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 25,
                  ),
                ),

                const SizedBox(height: 40),

                ElevatedButton(
                  onPressed: () => restartQuiz(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.deepPurple,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 16,
                    ),
                  ),
                  child: const Text(
                    'Try Again',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
