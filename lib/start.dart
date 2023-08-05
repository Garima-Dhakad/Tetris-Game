import 'package:flutter/material.dart';

import 'board.dart';

class StartingScreen extends StatefulWidget {
  const StartingScreen({super.key});

  @override
  State<StartingScreen> createState() => _StartingScreenState();
}

class _StartingScreenState extends State<StartingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/startscreen.jpg"),
            fit: BoxFit.cover,
            opacity: 50,
          ),
        ),
        child: Center(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 150),
                child: Text(
                  'Tetris Game',
                  style: TextStyle(fontSize: 60, color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 150,
              ),
              OutlinedButton(
                style: const ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll<Color>(Colors.white),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const GameBoard()));
                },
                child: const Text(
                  'Start Game',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
