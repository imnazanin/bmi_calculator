import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: 'LoadingPage',
      routes: {
        'LoadingPage': (context) => const HomeScreen(),
        'darkModePage': (context) => const DarkMode(),
        'lightModePage': (context) => const LightMode(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const DarkMode();
  }
}

class LightMode extends StatefulWidget {
  const LightMode({Key? key}) : super(key: key);

  @override
  State<LightMode> createState() => _LightModeState();
}

class _LightModeState extends State<LightMode> {
  double sliderValue() {
    if (_bmiResult < 12) {
      return 12;
    } else if (_bmiResult > 38) {
      return 38;
    } else {
      return _bmiResult;
    }
  }

  String _healthAdvice = '';
  String unit = 'Metric';
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  double _bmiResult = 0;
  String _textResult = ' ';
  String ab = '';

  Widget _healthAdviceButton() {
    return (_bmiResult > 0)
        ? Row(
            children: [
              Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width / 2,
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  height: 60,
                  color: Colors.lightBlue.shade700,
                  onPressed: calculateBmi,
                  child: const Text(
                    'Calculate',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Seg',
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width / 2,
                child: MaterialButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                            'Healthy Advices',
                            style: TextStyle(
                              color: Colors.lightBlue.shade700,
                              fontFamily: 'Seg',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          content: Text(
                            _healthAdvice,
                            style: const TextStyle(
                              color: Colors.black87,
                              fontFamily: 'Seg',
                              fontSize: 18,
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'OK',
                                style: TextStyle(
                                  color: Colors.lightBlue.shade700,
                                  fontFamily: 'Seg',
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  minWidth: 50,
                  height: 50,
                  color: Colors.lightBlue.shade700,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text(
                    (_bmiResult > 0) ? '?' : '',
                    style: const TextStyle(
                      fontSize: 28,
                      color: Colors.white,
                      fontFamily: 'Seg',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                height: 60,
                color: Colors.lightBlue.shade700,
                onPressed: calculateBmi,
                child: const Text(
                  'Calculate',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Seg',
                  ),
                ),
              ),
            ],
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'darkModePage');
                },
                icon: Icon(Icons.dark_mode_outlined,
                    color: Colors.lightBlue.shade700),
              ),
              const SizedBox(
                width: 20,
              )
            ],
          )
        ],
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'B M I   C A L C U L A T O R',
          style: TextStyle(
            fontWeight: FontWeight.w300,
            color: Colors.lightBlue.shade700,
            fontFamily: 'Seg',
          ),
        ),
      ),
      backgroundColor: Colors.grey.shade200,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 150,
                  child: TextField(
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    controller: _heightController,
                    style: const TextStyle(
                      fontSize: 35,
                      color: Colors.black87,
                      fontFamily: 'Seg',
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      hintText: 'Height',
                      hintStyle: TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.w300,
                        color: Colors.lightBlue.shade700,
                        fontFamily: 'Seg',
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 150,
                  child: TextField(
                    textAlign: TextAlign.center,
                    controller: _weightController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                      fontSize: 35,
                      color: Colors.black87,
                      fontFamily: 'Seg',
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      hintText: 'Weight',
                      hintStyle: TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.w300,
                        color: Colors.lightBlue.shade700,
                        fontFamily: 'Seg',
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            _healthAdviceButton(),
            const SizedBox(
              height: 30,
            ),
            SleekCircularSlider(
              appearance: CircularSliderAppearance(
                animDurationMultiplier: 3.0,
                counterClockwise: false,
                infoProperties: InfoProperties(
                  mainLabelStyle: const TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.w300,
                    color: Colors.black87,
                    fontFamily: 'Seg',
                  ),
                  modifier: (double value) {
                    return (_bmiResult > 0)
                        ? _bmiResult.toStringAsFixed(1)
                        : '';
                  },
                ),
                customWidths: CustomSliderWidths(
                  progressBarWidth: 10,
                ),
                customColors: CustomSliderColors(
                  progressBarColors: [
                    Colors.red.shade900,
                    Colors.red,
                    Colors.green,
                    Colors.red,
                  ],
                ),
              ),
              min: 12,
              max: 38,
              initialValue: sliderValue(),
            ),
            const SizedBox(height: 30),
            Text(
              _textResult,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w300,
                color: Colors.black87,
                fontFamily: 'Seg',
              ),
            ),
          ],
        ),
      ),
    );
  }

  void calculateBmi() {
    if (unit == 'Metric') {
      if (_heightController.text.isEmpty || _weightController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Height and Weight cannot be empty!'),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
        _bmiResult = 0;
        return;
      } else if (double.parse(_heightController.text) < 100) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Enter your height correctly! in Cm'),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
        _bmiResult = 0;
        return;
      }
    } else {
      if (_heightController.text.isEmpty || _weightController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Height and Weight cannot be empty!'),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
        _bmiResult = 0;
        return;
      }
    }
    setState(() {
      double height = double.parse(_heightController.text) / 100;
      double weight = double.parse(_weightController.text);
      _bmiResult = weight / (height * height);
      if (unit == 'Impreial') {
        _bmiResult *= 703;
      }
      if (_bmiResult < 16) {
        _textResult = 'Severe Thinness\nYou are extermly underweighted!!';
      } else if (_bmiResult >= 16 && _bmiResult < 17) {
        _textResult = 'Moderate Thinness\nYour weight is too low!';
      } else if (_bmiResult >= 17 && _bmiResult < 18.5) {
        _textResult = 'Mild Thinness\nYou are underweighted!';
      } else if (_bmiResult < 25 && _bmiResult >= 18.5) {
        _textResult = 'Normal\nyour height and weight are matched together!';
      } else if (_bmiResult < 30 && _bmiResult >= 25) {
        _textResult = 'Overweighted\nYou are overweighted!';
      } else if (_bmiResult < 35 && _bmiResult >= 30) {
        _textResult = 'Obese Class I\nYour weight is too high!';
      } else {
        _textResult = 'Obese Class II\nYou are extermly overweighted!';
      }
      if (_bmiResult < 18.5) {
        _healthAdvice =
            'You are considered underweight.\nMaybe you should check in with a doctor for any health issues or start working out and build some muscle.';
      } else if (_bmiResult >= 18.5 && _bmiResult < 25) {
        _healthAdvice = 'You are within a healthy weight range.';
      } else if (_bmiResult >= 25 && _bmiResult < 35) {
        _healthAdvice =
            'You are considered overweight.\nYou probably need to start working out and eating healthier.';
      } else {
        _healthAdvice =
            'You are considered obese.\nIt will be dangerous to your health if you don\'t act soon';
      }
    });
  }
}

class DarkMode extends StatefulWidget {
  const DarkMode({Key? key}) : super(key: key);

  @override
  State<DarkMode> createState() => _DarkModeState();
}

class _DarkModeState extends State<DarkMode> {
  double sliderValue() {
    if (_bmiResult < 12) {
      return 12;
    } else if (_bmiResult > 38) {
      return 38;
    } else {
      return _bmiResult;
    }
  }

  String _healthAdvice = '';
  String unit = 'Metric';
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  double _bmiResult = 0;
  String _textResult = ' ';
  Widget _healthAdviceButton() {
    return (_bmiResult > 0)
        ? Row(
            children: [
              Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width / 2,
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  height: 60,
                  color: Colors.yellow,
                  onPressed: calculateBmi,
                  child: const Text(
                    'Calculate',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Seg',
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width / 2,
                child: MaterialButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Colors.black87,
                          title: const Text(
                            'Healthy Advices',
                            style: TextStyle(
                              color: Colors.yellow,
                              fontFamily: 'Seg',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          content: Text(
                            _healthAdvice,
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'Seg',
                              fontSize: 18,
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'OK',
                                style: TextStyle(
                                  color: Colors.yellow,
                                  fontFamily: 'Seg',
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  minWidth: 50,
                  height: 50,
                  color: Colors.yellow,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text(
                    (_bmiResult > 0) ? '?' : '',
                    style: const TextStyle(
                      fontSize: 28,
                      color: Colors.black87,
                      fontFamily: 'Seg',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                height: 60,
                color: Colors.yellow,
                onPressed: calculateBmi,
                child: const Text(
                  'Calculate',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Seg',
                  ),
                ),
              ),
            ],
          );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          actions: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'lightModePage');
                  },
                  icon:
                      const Icon(Icons.wb_sunny_outlined, color: Colors.yellow),
                ),
                const SizedBox(
                  width: 20,
                ),
              ],
            )
          ],
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'B M I   C A L C U L A T O R',
            style: TextStyle(
              fontWeight: FontWeight.w300,
              color: Colors.yellow,
              fontFamily: 'Seg',
            ),
          ),
        ),
        backgroundColor: Colors.grey.shade900,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 130,
                    child: TextField(
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      controller: _heightController,
                      style: const TextStyle(
                        fontSize: 35,
                        color: Colors.yellow,
                        fontFamily: 'Seg',
                      ),
                      decoration: InputDecoration(
                        hintText: 'Height',
                        hintStyle: TextStyle(
                          fontSize: 38,
                          fontWeight: FontWeight.w300,
                          color: Colors.white.withOpacity(0.6),
                          fontFamily: 'Seg',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 130,
                    child: TextField(
                      textAlign: TextAlign.center,
                      controller: _weightController,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(
                        fontSize: 35,
                        color: Colors.yellow,
                        fontFamily: 'Seg',
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Weight',
                        hintStyle: TextStyle(
                          fontSize: 38,
                          fontWeight: FontWeight.w300,
                          color: Colors.white.withOpacity(0.6),
                          fontFamily: 'Seg',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              _healthAdviceButton(),
              const SizedBox(
                height: 30,
              ),
              SleekCircularSlider(
                appearance: CircularSliderAppearance(
                  animDurationMultiplier: 3.0,
                  counterClockwise: false,
                  infoProperties: InfoProperties(
                    mainLabelStyle: const TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                      fontFamily: 'Seg',
                    ),
                    modifier: (double value) {
                      return (_bmiResult > 0)
                          ? _bmiResult.toStringAsFixed(1)
                          : '';
                    },
                  ),
                  customWidths: CustomSliderWidths(
                    progressBarWidth: 10,
                  ),
                  customColors: CustomSliderColors(
                    progressBarColors: [
                      Colors.red.shade900,
                      Colors.red,
                      Colors.green,
                      Colors.red,
                    ],
                  ),
                ),
                min: 12,
                max: 38,
                initialValue: sliderValue(),
              ),
              const SizedBox(height: 30),
              Text(
                _textResult,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                  fontFamily: 'Seg',
                ),
              ),
            ],
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }

  void calculateBmi() {
    if (unit == 'Metric') {
      if (_heightController.text.isEmpty || _weightController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Height and Weight cannot be empty!'),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
        _bmiResult = 0;
        return;
      } else if (double.parse(_heightController.text) < 100) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Enter your height correctly! in Cm'),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
        _bmiResult = 0;
        return;
      }
    } else {
      if (_heightController.text.isEmpty || _weightController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Height and Weight cannot be empty!'),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
        _bmiResult = 0;
        return;
      }
    }
    setState(() {
      double height = double.parse(_heightController.text) / 100;
      double weight = double.parse(_weightController.text);
      _bmiResult = weight / (height * height);
      if (unit == 'Impreial') {
        _bmiResult *= 703;
      }
      if (_bmiResult < 16) {
        _textResult = 'Severe Thinness\nYou are extermly underweighted!!';
      } else if (_bmiResult >= 16 && _bmiResult < 17) {
        _textResult = 'Moderate Thinness\nYour weight is too low!';
      } else if (_bmiResult >= 17 && _bmiResult < 18.5) {
        _textResult = 'Mild Thinness\nYou are underweighted!';
      } else if (_bmiResult < 25 && _bmiResult >= 18.5) {
        _textResult = 'Normal\nyour height and weight are matched together!';
      } else if (_bmiResult < 30 && _bmiResult >= 25) {
        _textResult = 'Overweighted\nYou are overweighted!';
      } else if (_bmiResult < 35 && _bmiResult >= 30) {
        _textResult = 'Obese Class I\nYour weight is too high!';
      } else {
        _textResult = 'Obese Class II\nYou are extermly overweighted!';
      }
      if (_bmiResult < 18.5) {
        _healthAdvice =
            'You are considered underweight.\nMaybe you should check in with a doctor for any health issues or start working out and build some muscle.';
      } else if (_bmiResult >= 18.5 && _bmiResult < 25) {
        _healthAdvice = 'You are within a healthy weight range.';
      } else if (_bmiResult >= 25 && _bmiResult < 35) {
        _healthAdvice =
            'You are considered overweight.\nYou probably need to start working out and eating healthier.';
      } else {
        _healthAdvice =
            'You are considered obese.\nIt will be dangerous to your health if you don\'t act soon';
      }
    });
  }
}
