import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _userAnswerTextField = TextEditingController();
  String _equation = "";
  int _answer = 0;
  int _userAnswer = 0;
  int _score = 0;

  void _equationCreator() {
    setState(() {
      int _firstNumber = Random().nextInt(100); // Value is >= 0 and < 100
      int _secondNumber = Random().nextInt(100); // Value is >= 0 and < 100
      _equation = "$_firstNumber * $_secondNumber";
      _answer = _firstNumber * _secondNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    _equationCreator();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Equation Expedition"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Score: $_score', style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(
              height: 100,
            ),
            Text(
              'Your Equation Is: ', style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              '$_equation', style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(
              height: 50,
            ),
            TextField(
              controller: _userAnswerTextField,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _userAnswer = int.parse(_userAnswerTextField as String);
          if (_userAnswer == _answer) {
            _score++;
            _equationCreator();
          }
          else
            {
              _equationCreator();
            }
        },
        tooltip: 'Increment',
        child: const Text('Submit'),
      ),
    );
  }
}
