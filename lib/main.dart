import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/task.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.registerAdapter<Task>(TaskAdapter());
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

  //important variables
  final _userAnswerTextField = TextEditingController();
  String _equation = "";
  int _answer = 0;
  int _userAnswer = 0;
  int _playerPowerLevel = 0;
  int _highestPowerLevel = 0;
  int _tries = 3;
  int _enemyPowerLevel = 0;
  String _enemyName = "";
  String _enemyImageURL = "";
  String  _result = "";

  //Generate Equation
  void _equationCreator() {
    setState(() {
      int _determiner = Random().nextInt(3); // Value is >= 0 and < 3, determines the type of equation
      int _firstNumber = Random().nextInt(13); // Value is >= 0 and < 13, first number used in equation
      int _secondNumber = Random().nextInt(13); // Value is >= 0 and < 13, first number used in equation

      if (_determiner == 0) //multiplication
          {
        _equation = "$_firstNumber * $_secondNumber";
        _answer = _firstNumber * _secondNumber;
        print(_answer);
      }
      else if (_determiner == 1 && _firstNumber % _secondNumber == 0 && _firstNumber != 0  && _secondNumber != 0) //division
      {
          _equation = "$_firstNumber / $_secondNumber";
          _answer = (_firstNumber / _secondNumber) as int;
          print(_answer);
      }
      else if (_determiner == 2) //subtraction
      {
        _equation = "$_firstNumber - $_secondNumber";
        _answer = _firstNumber - _secondNumber;
        print(_answer);
      }
      else //addition
      {
        _equation = "$_firstNumber + $_secondNumber";
        _answer = _firstNumber + _secondNumber;
        print(_answer);
      }
      //call to generate the enemy since it only ever happens when an equation is generated
      _generateEnemy(_playerPowerLevel);
    });
  }

  //generate an enemy based on user's power level
  void _generateEnemy(_playerPowerLevel) {
    if (_playerPowerLevel <= 10)
      {
        _enemyPowerLevel = 10;
        _enemyName = "Master Roshi";
        _enemyImageURL = "https://i.redd.it/gxgmm1qr84u31.jpg";
      }
    else if (_playerPowerLevel <= 15 && _playerPowerLevel > 10)
    {
      _enemyPowerLevel = 15;
      _enemyName = "King Picclo";
      _enemyImageURL = "https://qph.cf2.quoracdn.net/main-qimg-e36344eb2f31636d6717a0ca332db8b3-lq";
    }
    else if (_playerPowerLevel <= 20 && _playerPowerLevel > 15)
    {
      _enemyPowerLevel = 20;
      _enemyName = "Raditz";
      _enemyImageURL = "https://miro.medium.com/v2/resize:fit:720/1*1-iNPyLSkAUUwVVi3k-GJg.png";
    }
    else if (_playerPowerLevel <= 25 && _playerPowerLevel > 20)
    {
      _enemyPowerLevel = 25;
      _enemyName = "Nappa";
      _enemyImageURL = "https://qph.cf2.quoracdn.net/main-qimg-1622f85ee72b9e6db6eda963f323b8d2-pjlq";
    }
    else if (_playerPowerLevel <= 30 && _playerPowerLevel > 25)
    {
      _enemyPowerLevel = 30;
      _enemyName = "Vegeta";
      _enemyImageURL = "https://static.wikia.nocookie.net/6e03a603-3c80-4376-8f40-d9bae369a874";
    }
    else if (_playerPowerLevel <= 35 && _playerPowerLevel > 30)
    {
      _enemyPowerLevel = 35;
      _enemyName = "Dodoria";
      _enemyImageURL = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRaTWAiMpBKTurAEVjjGxBLiP-zkXUFYUufFQ&usqp=CAU";
    }
    else if (_playerPowerLevel <= 40 && _playerPowerLevel > 35)
    {
      _enemyPowerLevel = 40;
      _enemyName = "Zarbon";
      _enemyImageURL = "https://m.media-amazon.com/images/M/MV5BNTg3Y2RlY2UtOWZjZi00MDZlLTg0ODItOWJlNjg0YTU4OTVjXkEyXkFqcGdeQXVyMTk3OTMzOA@@._V1_.jpg";
    }
    else if (_playerPowerLevel <= 45 && _playerPowerLevel > 40)
    {
      _enemyPowerLevel = 45;
      _enemyName = "Guldo";
      _enemyImageURL = "https://pbs.twimg.com/media/FOEMDt6WYAEpCWW.jpg:large";
    }
    else if (_playerPowerLevel <= 50 && _playerPowerLevel > 45)
    {
      _enemyPowerLevel = 50;
      _enemyName = "Recoome";
      _enemyImageURL = "https://derf9v1xhwwx1.cloudfront.net/image/upload/oth/FunimationStoreFront/V1696679/artwork/74a6ac49-32ac-4bd5-91c2-e943a3b87dd6_keyartofficialvideoimage.jpg";
    }
    else if (_playerPowerLevel <= 55 && _playerPowerLevel > 50)
    {
      _enemyPowerLevel = 55;
      _enemyName = "Burter";
      _enemyImageURL = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcStu8OK4eD0P9KsecRhG5tRyTdXUKm1NPEN0vmilGCkGF5uZF3zXm6y-Xa-Xu0d9eM1INs&usqp=CAU";
    }
    else if (_playerPowerLevel <= 60 && _playerPowerLevel > 55)
    {
      _enemyPowerLevel = 60;
      _enemyName = "Jeice";
      _enemyImageURL = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSrHD9QoTw-xoNaUQI3LTKiRa5svx6KasRyBg&usqp=CAU";
    }
    else if (_playerPowerLevel <= 65 && _playerPowerLevel > 60)
    {
      _enemyPowerLevel = 65;
      _enemyName = "Captain Ginyu";
      _enemyImageURL = "https://static1.cbrimages.com/wordpress/wp-content/uploads/2018/03/Dragon-Ball-S-Captain-Ginyu.jpg";
    }
    else if (_playerPowerLevel <= 70 && _playerPowerLevel > 65)
    {
      _enemyPowerLevel = 70;
      _enemyName = "Frieza (First Form)";
      _enemyImageURL = "https://miro.medium.com/v2/resize:fit:600/0*ADXTt5ehv3koorIY.";
    }
    else if (_playerPowerLevel <= 75 && _playerPowerLevel > 70)
    {
      _enemyPowerLevel = 75;
      _enemyName = "Frieza (Second Form)";
      _enemyImageURL = "https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/4be561f7-178d-46ea-a4c5-056d15df1b0d/d8bfxb6-44b42511-6513-47a0-9ec2-c6e931610ca0.png/v1/fill/w_577,h_1385/frieza_2nd_form_by_niiii_link_d8bfxb6-pre.png?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7ImhlaWdodCI6Ijw9MTU5OCIsInBhdGgiOiJcL2ZcLzRiZTU2MWY3LTE3OGQtNDZlYS1hNGM1LTA1NmQxNWRmMWIwZFwvZDhiZnhiNi00NGI0MjUxMS02NTEzLTQ3YTAtOWVjMi1jNmU5MzE2MTBjYTAucG5nIiwid2lkdGgiOiI8PTY2NiJ9XV0sImF1ZCI6WyJ1cm46c2VydmljZTppbWFnZS5vcGVyYXRpb25zIl19.VPA3S0nxhCyWOTdkXlbnSblXzcUPGwlNHebc2f7anOU";
    }
    else if (_playerPowerLevel <= 80 && _playerPowerLevel > 75)
    {
      _enemyPowerLevel = 80;
      _enemyName = "Frieza (Third Form)";
      _enemyImageURL = "https://m.media-amazon.com/images/M/MV5BM2IwNDJmNWQtODJkZS00ZGUzLTkyODgtNDY0MzViMzE1NWUxXkEyXkFqcGdeQXVyMTk3OTMzOA@@._V1_.jpg";
    }
    else if (_playerPowerLevel <= 85 && _playerPowerLevel > 80)
    {
      _enemyPowerLevel = 85;
      _enemyName = "Frieza (Final Form)";
      _enemyImageURL = "https://pbs.twimg.com/media/ESFTRITW4AE1Viw?format=jpg&name=large";
    }
    else if (_playerPowerLevel <= 100 && _playerPowerLevel > 85)
    {
      _enemyPowerLevel = 100;
      _enemyName = "Perfect Cell";
      _enemyImageURL = "https://imgix.ranker.com/list_img_v2/8396/2728396/original/best-cell-quotes-dbz?fit=crop&fm=pjpg&q=80&dpr=2&w=1200&h=720";
    }
    else
      {
        _enemyPowerLevel = _playerPowerLevel;
        _enemyName = "Goku";
        _enemyImageURL = "https://images.immediate.co.uk/production/volatile/sites/3/2023/08/2023.06.28-06.20-boundingintocomics-649c79f009cdf-Cropped-8d74232.png?resize=768,574";
      }
  }

  //calculate Attack
  void _calculateAttack() {
    _userAnswer = int.parse(_userAnswerTextField.text);
    if (_userAnswer == _answer) {
      _playerPowerLevel++;

      if (_playerPowerLevel > _highestPowerLevel)
      {
        _highestPowerLevel = _playerPowerLevel;
        scoreBox.put(1, new Task(highestScore: _playerPowerLevel));
      }
      if (_playerPowerLevel == 31) {
        _result = "You've traveled to Namek! You restored your Attacks and are on to face more powerful Foes!";
        _tries = 3;
        _userAnswerTextField.text = "";
        _equationCreator();
      }
      if (_playerPowerLevel == 86) {
        _result = "You beat the galatic tyrant Frieza! But what's this? Looks like you now have to face Perfect Cell! Your Attacks have been restored. Good Luck!";
        _userAnswerTextField.text = "";
        _tries = 3;
        _equationCreator();
      }
      if (_playerPowerLevel == 101)
      {
        _result = "Incredible! You defeated Perfect Cell! Now you can go one on one with one the formitable Goku!";
        _userAnswerTextField.text = "";
        _equationCreator();
      }
      else
      {
        _result = "Correct! The answer was $_answer";
        _userAnswerTextField.text = "";
        _equationCreator();
      }
    }
    else {
      setState(() {
        _result = "Incorrect! The answer was $_answer";
        _tries = _tries - 1;
        if (_tries == 0)
        {
          _tries = 3;
          _playerPowerLevel = 0;
          _result = "Oh No! You were Defeated! Lets try again!";
        }
        _equationCreator();
        _userAnswerTextField.text = "";
      });
    }
}
  //Hive stuff
  var scoreBox;

  initHive() async {
    scoreBox = await Hive.openBox<Task>('tasks');
  }

  //build enemy display
  Widget enemyWidget() {
    return
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 10,),
          Text('$_enemyName', style: TextStyle(fontSize: 40, color: Colors.black,)),
          SizedBox(height: 10,),
          Text('Enemy Power Level: $_enemyPowerLevel', style: TextStyle(fontSize: 30, color: Colors.black,),),
          SizedBox(height: 10,),
          Image.network (
            _enemyImageURL,
            height: 300,
            width: 300,
          ),
          SizedBox(height: 30,)
        ],
      );
  }

  //build player display
  Widget playerWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Your Current Power Level: $_playerPowerLevel', style: TextStyle(fontSize: 30, color: Colors.black,),
              ),
              SizedBox(height: 20,),
              Text('Attacks Remaining: $_tries', style: TextStyle(fontSize: 30, color: Colors.black,),),
              SizedBox(height: 20,),
              Text('Your Equation Is: ', style: TextStyle(fontSize: 30, color: Colors.black,),),
              Text('$_equation', style: TextStyle(fontSize: 30, color: Colors.black,),),
              SizedBox(height: 30,),
              Container(
                width: 200.0,
                child: TextField(
                  controller: _userAnswerTextField, textAlign: TextAlign.center, style: TextStyle(fontSize: 30, color: Colors.black,), cursorColor: Colors.black,
                ),
              ),
              SizedBox(height: 50,),
      ],
    );
  }

  //build result display
  Widget resultWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('$_result', style: TextStyle(fontSize: 15, color: Colors.black,),),
        SizedBox(height: 20,),
        Text('Highest Power Level Ever Achieved: $_highestPowerLevel', style: TextStyle(fontSize: 15, color: Colors.black,),),
        SizedBox(height: 20,),
      ],
    );
  }

  //build UI
  @override
  Widget build(BuildContext context) {
    _equationCreator();
    initHive();
    if (scoreBox != null) {
      Task hsTask = scoreBox.get(1);
      _highestPowerLevel = hsTask.highestScore;
    }
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 153, 34, 1.0),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(7, 32, 131, 1.0),
        title: Text("Dragon Ball Math Fighters", style: TextStyle(fontSize: 40, color: Colors.white,)),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            enemyWidget(),
            playerWidget(),
            resultWidget(),
          ],
        ),
      ),
      floatingActionButton: Container(
        height: 100,
        width: 100,
        child:
          FloatingActionButton(
            onPressed: () {
            setState(() {
              _calculateAttack();
          });
        },
        child: const Text('Attack', style: TextStyle(fontSize: 25, color: Colors.white,)), backgroundColor: Color.fromRGBO(7, 32, 131, 1.0),
      ),
      ),
    );
  }
}
