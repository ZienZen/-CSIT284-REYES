import 'package:flutter/material.dart';
import 'dart:math';

class diceRoller extends StatefulWidget {
  diceRoller({super.key});

  @override
  State<diceRoller> createState() {
    return _DiceRollerState();
  }
}



class _DiceRollerState extends State<diceRoller> {
  
  final randomizer = Random();

  var currentDiceImage = 'assets/dice-images/dice-images/dice-2.png';

  void rollDice() {
    setState(() {
        var num = randomizer.nextInt(5) + 1;
    currentDiceImage = 'assets/dice-images/dice-images/dice-$num.png';
    });
  }

  @override

  Widget build(context) {
    return  Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(width: 200, currentDiceImage),
        SizedBox(height: 20),
        TextButton(
          onPressed: rollDice,
          child: Text(style: TextStyle(fontSize: 28), "Roll Dice"),
        ),
      ],
    );
  }
}
