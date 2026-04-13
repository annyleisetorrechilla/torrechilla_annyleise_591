import 'package:flutter/material.dart';
import 'dart:math';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _display = '0';
  String _firstOperand = '';
  String _operator = '';
  bool _shouldResetDisplay = false;
  String _expression = '';

  @override
  void initState() {
    super.initState();
    _clear();
  }

  void _onNumberPressed(String number) {
    setState(() {
      if (_display == '0' || _shouldResetDisplay || _display == 'Error') {
        _display = number;
        _shouldResetDisplay = false;
      } else if (_display.length < 12) {
        _display += number;
      }
    });
  }

  void _onDecimalPressed() {
    setState(() {
      if (_shouldResetDisplay) {
        _display = '0.';
        _shouldResetDisplay = false;
      } else if (!_display.contains('.')) {
        _display += '.';
      }
    });
  }

  void _onOperatorPressed(String operator) {
    setState(() {
      _firstOperand = _display;
      _operator = operator;
      _expression = '$_firstOperand $_operator';
      _shouldResetDisplay = true;
    });
  }

  // ================= CALCULATE =================
  void _calculate() {
    if (_firstOperand.isEmpty || _operator.isEmpty) return;

    double num1 = double.tryParse(_firstOperand) ?? 0;
    double num2 = double.tryParse(_display) ?? 0;
    double result = 0;

    setState(() {
      switch (_operator) {
        case '+':
          result = num1 + num2;
          break;
        case '-':
          result = num1 - num2;
          break;
        case '×':
          result = num1 * num2;
          break;
        case '÷':
          if (num2 == 0) {
            _display = 'Error';
            _expression = 'Cannot divide by zero';
            _resetAfterError();
            return;
          }
          result = num1 / num2;
          break;
        case '^':
          result = pow(num1, num2).toDouble();
          break;
        case '%':
          if (num2 == 0) {
            _display = 'Error';
            _expression = 'Cannot modulo by zero';
            _resetAfterError();
            return;
          }
          result = num1 % num2;
          break;
      }

      _display = _formatResult(result);
      _expression = '$_firstOperand $_operator $num2 = $_display';
      _firstOperand = '';
      _operator = '';
      _shouldResetDisplay = true;
    });
  }

  // ================= SCIENTIFIC =================
  void _onScientificPressed(String function) {
    double num = double.tryParse(_display) ?? 0;
    double result = 0;

    setState(() {
      switch (function) {
        case 'sin':
          result = sin(num * pi / 180);
          break;
        case 'cos':
          result = cos(num * pi / 180);
          break;
        case 'tan':
          if ((num % 180 - 90).abs() < 1e-9) {
            _display = 'Error';
            _resetAfterError();
            return;
          }
          result = tan(num * pi / 180);
          break;
        case '√':
          if (num < 0) {
            _display = 'Error';
            _resetAfterError();
            return;
          }
          result = sqrt(num);
          break;
        case 'log':
          if (num <= 0) {
            _display = 'Error';
            _resetAfterError();
            return;
          }
          result = log(num) / log(10);
          break;
        case 'ln':
          if (num <= 0) {
            _display = 'Error';
            _resetAfterError();
            return;
          }
          result = log(num);
          break;
        case 'x²':
          result = num * num;
          break;
        case '±':
          result = -num;
          break;
        case 'π':
          result = pi;
          break;
        case 'e':
          result = e;
          break;
      }

      _display = _formatResult(result);
      _expression = '$function($num) = $_display';
      _shouldResetDisplay = true;
    });
  }

  // ================= HELPERS =================
  void _clear() {
    setState(() {
      _display = '0';
      _firstOperand = '';
      _operator = '';
      _expression = '';
      _shouldResetDisplay = false;
    });
  }

  void _backspace() {
    setState(() {
      if (_display.length > 1) {
        _display = _display.substring(0, _display.length - 1);
      } else {
        _display = '0';
      }
    });
  }

  void _resetAfterError() {
    _firstOperand = '';
    _operator = '';
    _shouldResetDisplay = true;
  }

  String _formatResult(double result) {
    if (result.isNaN || result.isInfinite) return 'Error';
    if (result == result.toInt()) return result.toInt().toString();

    String formatted = result.toStringAsFixed(8);
    formatted = formatted.replaceAll(RegExp(r'0+$'), '');
    formatted = formatted.replaceAll(RegExp(r'\.$'), '');
    return formatted;
  }

  // ================= UI (minimal) =================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculator Exam')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_expression, style: const TextStyle(fontSize: 18)),
            Text(_display, style: const TextStyle(fontSize: 40)),
          ],
        ),
      ),
    );
  }
}
