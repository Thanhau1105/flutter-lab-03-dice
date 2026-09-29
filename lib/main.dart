import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const DiceApp());
}

class DiceApp extends StatelessWidget {
  const DiceApp({super.key});

  static const Color orange = Color(0xFFEC4B26);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dice',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: orange),
        scaffoldBackgroundColor: const Color(0xFFFFFAF7),
        appBarTheme: const AppBarTheme(
          backgroundColor: orange,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
      ),
      home: const DicePage(),
    );
  }
}

class DicePage extends StatefulWidget {
  const DicePage({super.key});

  @override
  State<DicePage> createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> {
  final Random _random = Random();

  int _leftDie = 1;
  int _rightDie = 2;
  int _rollCount = 0;

  void _rollDice() {
    setState(() {
      _leftDie = _random.nextInt(6) + 1;
      _rightDie = _random.nextInt(6) + 1;
      _rollCount++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dice')),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'LẮC XÚC XẮC',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: const Color(0xFF8B2D1A),
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Nhấn nút để xem vận may của bạn',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: const Color(0xFF705E59),
                    ),
                  ),
                  const SizedBox(height: 36),
                  Row(
                    children: [
                      Expanded(
                        child: Image.asset(
                          'assets/dice_$_leftDie.png',
                          key: const Key('left-die'),
                          semanticLabel: 'Xúc xắc trái: $_leftDie',
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(width: 18),
                      Expanded(
                        child: Image.asset(
                          'assets/dice_$_rightDie.png',
                          key: const Key('right-die'),
                          semanticLabel: 'Xúc xắc phải: $_rightDie',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                  Text(
                    'Tổng điểm: ${_leftDie + _rightDie}',
                    key: const Key('dice-total'),
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: const Color(0xFF8B2D1A),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('Lần lắc: $_rollCount'),
                  const SizedBox(height: 28),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      key: const Key('roll-button'),
                      onPressed: _rollDice,
                      icon: const Icon(Icons.casino_outlined),
                      label: const Text('LẮC XÚC XẮC'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: DiceApp.orange,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
