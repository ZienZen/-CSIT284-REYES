import 'package:flutter/material.dart';

void main() {
  runApp(const CampusWellnessTracker ());
}
class CampusWellnessTracker extends StatelessWidget {
  const CampusWellnessTracker({super.key});

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
      home: StartScreen (),
    );
  }
}


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
              Color.fromARGB(255, 40, 175, 62),
              Color.fromARGB(214, 65, 255, 112),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [ 
                const Text(
                  'Campus Wellness Tracker',
                  style: TextStyle(
                  color: Color.fromARGB(255, 44, 0, 204),
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),

                ),
                
                const Text(' '),
                const Text(
                  'Evaluate your current study-life balance.',
                  style: TextStyle(
                  color: Color.fromARGB(255, 44, 0, 204),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                ),
                const Text(' '),
                const Text(
                  'Derk E. Reyes',
                  style: TextStyle(
                  color: Color.fromARGB(255, 44, 0, 204),
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                ),
                const Text(' '),
              const Text(
                'BSCS-3 ',
                style: TextStyle(
                  color: Color.fromARGB(255, 44, 0, 204),
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              
            ],
          ),
        ),
      ),
    );
  }
}

class QuizScreen {
  const new();
}

