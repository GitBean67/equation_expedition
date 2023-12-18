import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/task.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.registerAdapter<Task>(TaskAdapter());
  await Hive.openBox<Task>('tasks');
  await Hive.initFlutter();                     // added for Hive
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Equation Expedition',
      theme: ThemeData.dark(),
      home: const MyHomePage(title: 'Equation Expedition'),
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
  int _highestScore = Hive.box('tasks').get('highestScore');
  String  _result = "";

  void _equationCreator() {
    setState(() {
      int _determiner = Random().nextInt(3); // Value is >= 0 and < 3
      int _firstNumber = Random().nextInt(12); // Value is >= 0 and < 100
      int _secondNumber = Random().nextInt(12); // Value is >= 0 and < 100
      if (_determiner == 0) //multiplication
        {
          _equation = "$_firstNumber * $_secondNumber";
          _answer = _firstNumber * _secondNumber;
          print(_answer);
        }
      else if (_determiner == 1 && (_firstNumber % _secondNumber == 0 || _secondNumber % _firstNumber == 0) && _firstNumber != 0  && _secondNumber != 0) {
        if(_firstNumber % _secondNumber == 0) {
          _equation = "$_firstNumber / $_secondNumber";
          _answer = (_firstNumber / _secondNumber) as int;
          print(_answer);
        }
        else if (_secondNumber % _firstNumber == 0)
          {
            _equation = "$_firstNumber / $_secondNumber";
            _answer = (_firstNumber / _secondNumber) as int;
            print(_answer);
          }
      }
      else if (_determiner == 2) {
        _equation = "$_firstNumber - $_secondNumber";
        _answer = _firstNumber - _secondNumber;
        print(_answer);
      }
      else {
        _equation = "$_firstNumber + $_secondNumber";
        _answer = _firstNumber + _secondNumber;
        print(_answer);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _equationCreator();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text("Equation Expedition", style: TextStyle( fontFamily: 'Silkscreen', fontSize: 50.0)),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
        Text(
        'Highest Score: $_highestScore', style: Theme.of(context).textTheme.headlineMedium,
        ),
        SizedBox(
          height: 100,
        ),
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
              controller: _userAnswerTextField
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              '$_result', style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
            setState(() {
              _userAnswer = int.parse(_userAnswerTextField.text);
              if (_userAnswer == _answer) {
                _score++;
                if (_score > _highestScore)
                  {
                    _highestScore = _score;
                  }
                _result = "Correct! The answer was $_answer";
                _userAnswerTextField.text = "";
                _equationCreator();
              }
              else {
                setState(() {
                  _result = "Incorrect! The answer was $_answer";
                  _equationCreator();
                  _userAnswerTextField.text = "";
                });
              }
            });
        },
        child: const Text('Submit'),
      ),
    );
  }
}
