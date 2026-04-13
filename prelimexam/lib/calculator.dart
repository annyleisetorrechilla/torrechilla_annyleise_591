import 'package:flutter/material.dart';
import 'dart:math';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  // ============================================================
  // STATE VARIABLES (Do not modify these declarations)
  // ============================================================
  String _display = '0'; // Shows current number or result
  String _firstOperand = ''; // Stores first number before operator
  String _operator = ''; // Stores selected operation
  bool _shouldResetDisplay = false; // Flag for display reset
  String _expression = ''; // Shows the full expression

  // ============================================================
  // TASK 1: Complete initState() (10 points)
  //
  // Initialize all state variables to their default values.
  // Hint: Don't forget to call super.initState() first!

  // ============================================================
@override
// TODO: Implement this function
void initState() {
  super.initState();
  _display = '0';
  _firstOperand = '';
  _operator = '';
  _shouldResetDisplay = false;
  _expression = '';
}


  // ============================================================
  // TASK 2: Complete _onNumberPressed() (20 points)
  //
  // Handle when number buttons (0-9) are pressed.
  //
  // Hints:
  // - Use setState(() { ... }) to update the UI
  // - If _display is '0' OR _shouldResetDisplay is true:
  //     → Replace _display with the new number
  //     → Set _shouldResetDisplay to false
  // - Otherwise:
  //     → Append the number to _display (limit to 12 chars)
  // ============================================================
void _onNumberPressed(String number) {
  // TODO: Implement this function using setState
  setState(() {
    if (_display == '0' || _shouldResetDisplay) {
      _display = number;
      _shouldResetDisplay = false;
    } else if (_display.length < 12) {
      _display += number;
    }
  });
}


  // ============================================================
  // TASK 3: Complete _onDecimalPressed() (15 points)
  //
  // Handle when the decimal point (.) button is pressed.
  //
  // Hints:
  // - Use setState(() { ... }) to update the UI
  // - If _shouldResetDisplay is true:
  //     → Set _display to '0.'
  //     → Set _shouldResetDisplay to false
  // - Else if _display does NOT contain '.':
  //     → Append '.' to _display
  // ============================================================
void _onDecimalPressed() {
  // TODO: Implement this function using setState
  setState(() {
    if (_shouldResetDisplay) {
      _display = '0.';
      _shouldResetDisplay = false;
    } else if (!_display.contains('.')) {
      _display += '.';
    }
  });
}

  // ============================================================
  // TASK 4: Complete _onOperatorPressed() (20 points)
  //
  // Handle when operator buttons (+, -, ×, ÷, ^, %) are pressed.
  //
  // Hints:
  // - Use setState(() { ... }) to update the UI
  // - Store _display into _firstOperand
  // - Store the operator parameter into _operator
  // - Update _expression to show: "$_display $operator"
  // - Set _shouldResetDisplay to true
  // ============================================================
void _onOperatorPressed(String operator) {
  // TODO: Implement this function using setState
  setState(() {
    _firstOperand = _display;
    _operator = operator;
    _expression = '$_display $operator';
    _shouldResetDisplay = true;
  });
}


  // ============================================================
  // TASK 5: Complete _onScientificPressed() (35 points)
  //
  // Handle scientific functions: sin, cos, tan, √, log, ln, x², π, e, ±
  //
  // Hints:
  // - Use setState(() { ... }) to update the UI
  // - Get current number: double num = double.tryParse(_display) ?? 0;
  // - Use switch statement for each function
  //
  // Formulas:
  // - sin: sin(num * pi / 180)  ← converts degrees to radians
  // - cos: cos(num * pi / 180)
  // - tan: tan(num * pi / 180)  ← Error if num % 180 == 90
  // - √:   sqrt(num)            ← Error if num < 0
  // - log: log(num) / ln10      ← log base 10, Error if num <= 0
  // - ln:  log(num)             ← natural log, Error if num <= 0
  // - x²:  num * num
  // - ±:   num * -1
  // - π:   pi                   ← constant from dart:math
  // - e:   e                    ← constant from dart:math
  //
  // For errors: set _display = 'Error' and appropriate _expression
  // For success: update _display with _formatResult(result)
  //              update _expression to show the operation
  //              set _shouldResetDisplay to true
  // ============================================================

  void _onScientificPressed(String function) {
  // TODO: Implement this function using setState

  // Step 1: Parse the current display value
  // double num = double.tryParse(_display) ?? 0;
  // double result = 0;

  // Step 2: Use setState and switch statement to handle each function
  // Step 3: Update _display, _expression, and _shouldResetDisplay

  setState(() {
    double num = double.tryParse(_display) ?? 0;
    double result = 0;

    switch (function) {
      case 'sin':
        result = sin(num * pi / 180);
        _expression = 'sin($num) = ${_formatResult(result)}';
        break;

      case 'cos':
        result = cos(num * pi / 180);
        _expression = 'cos($num) = ${_formatResult(result)}';
        break;

      case 'tan':
        result = tan(num * pi / 180);
        if (num % 180 == 90) {
          _display = 'Error';
          _expression = 'tan($num) is undefined';
          _resetAfterError();
          return;
        }
        result = tan(num * pi / 180);
        _expression = 'tan($num) = ${_formatResult(result)}';
        break;

      case '√':
        if (num < 0) {
          _display = 'Error';
          _expression = 'Cannot take √ of negative';
          _resetAfterError();
          return;
        }
        result = sqrt(num);
        _expression = '√($num) = ${_formatResult(result)}';
        break;

      case 'log':
        if (num <= 0) {
          _display = 'Error';
          _expression = 'Cannot take log of non-positive';
          _resetAfterError();
          return;
        }
        result = log(num) / ln10;
        _expression = 'log($num) = ${_formatResult(result)}';
        break;

      case 'ln':
        if (num <= 0) {
          _display = 'Error';
          _expression = 'Cannot take ln of non-positive';
          _resetAfterError();
          return;
        }
        result = log(num);
        _expression = 'ln($num) = ${_formatResult(result)}';
        break;

      case 'x²':
        result = num * num;
        _expression = '($num)² = ${_formatResult(result)}';
        break;

      case '±':
        result = num * -1;
        _expression = '±($num) = ${_formatResult(result)}';
        break;

      case 'π':
        result = pi;
        _expression = 'π = ${_formatResult(result)}';
        break;

      case 'e':
        result = e;
        _expression = 'e = ${_formatResult(result)}';
        break;
    }
  });
}


  // ============================================================
  // PROVIDED FUNCTIONS (Do not modify below this line)
  // ============================================================

  // Calculate Result - Called when "=" is pressed
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

      _expression =
          '$_firstOperand $_operator $_display = ${_formatResult(result)}';
      _display = _formatResult(result);
      _firstOperand = '';
      _operator = '';
      _shouldResetDisplay = true;
    });
  }


  void _clear() {
    setState(() {
      _display = '0';
      _firstOperand = '';
      _operator = '';
      _shouldResetDisplay = false;
      _expression = '';
    });
  }

  void _clearEntry() {
    setState(() {
      _display = '0';
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

  // Reset after error
  void _resetAfterError() {
    _firstOperand = '';
    _operator = '';
    _shouldResetDisplay = true;
  }

  // Format result to remove unnecessary decimals
  String _formatResult(double result) {
    if (result.isNaN || result.isInfinite) {
      return 'Error';
    }
    if (result == result.toInt()) {
      return result.toInt().toString();
    }
    String formatted = result.toStringAsFixed(8);
    formatted = formatted.replaceAll(RegExp(r'0+$'), '');
    formatted = formatted.replaceAll(RegExp(r'\.$'), '');
    return formatted;
  }

  // Build Calculator Button
  Widget _buildButton(
    String text, {
    Color? backgroundColor,
    Color? textColor,
    VoidCallback? onPressed,
    int flex = 1,
  }) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Material(
          color: backgroundColor ?? const Color(0xFF333333),
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: onPressed,
            child: Container(
              height: 65,
              alignment: Alignment.center,
              child: Text(
                text,
                style: TextStyle(
                  fontSize: text.length > 2 ? 18 : 24,
                  fontWeight: FontWeight.w500,
                  color: textColor ?? Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // UI BUILD METHOD (Do not modify)
  // ============================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator Exam'),
        backgroundColor: const Color(0xFF1C1C1E),
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Display Area
            Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Expression Display
                    Text(
                      _expression,
                      style: TextStyle(fontSize: 18, color: Colors.grey[500]),
                      textAlign: TextAlign.right,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 10),
                    // Main Display
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerRight,
                      child: Text(
                        _display,
                        style: const TextStyle(
                          fontSize: 56,
                          fontWeight: FontWeight.w300,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.right,
                        maxLines: 1,
                      ),
                    ),
                    const SizedBox(height: 5),
                    // Operator Indicator
                    if (_operator.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.orange.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Operator: $_operator',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.orange,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),

            // Divider
            Container(
              height: 1,
              color: Colors.grey[800],
              margin: const EdgeInsets.symmetric(horizontal: 16),
            ),

            // Scientific Buttons Row 1
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                children: [
                  _buildButton(
                    'sin',
                    backgroundColor: const Color(0xFF505050),
                    onPressed: () => _onScientificPressed('sin'),
                  ),
                  _buildButton(
                    'cos',
                    backgroundColor: const Color(0xFF505050),
                    onPressed: () => _onScientificPressed('cos'),
                  ),
                  _buildButton(
                    'tan',
                    backgroundColor: const Color(0xFF505050),
                    onPressed: () => _onScientificPressed('tan'),
                  ),
                  _buildButton(
                    'log',
                    backgroundColor: const Color(0xFF505050),
                    onPressed: () => _onScientificPressed('log'),
                  ),
                  _buildButton(
                    'ln',
                    backgroundColor: const Color(0xFF505050),
                    onPressed: () => _onScientificPressed('ln'),
                  ),
                ],
              ),
            ),

            // Scientific Buttons Row 2
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                children: [
                  _buildButton(
                    '√',
                    backgroundColor: const Color(0xFF505050),
                    onPressed: () => _onScientificPressed('√'),
                  ),
                  _buildButton(
                    'x²',
                    backgroundColor: const Color(0xFF505050),
                    onPressed: () => _onScientificPressed('x²'),
                  ),
                  _buildButton(
                    '^',
                    backgroundColor: const Color(0xFF505050),
                    onPressed: () => _onOperatorPressed('^'),
                  ),
                  _buildButton(
                    'π',
                    backgroundColor: const Color(0xFF505050),
                    onPressed: () => _onScientificPressed('π'),
                  ),
                  _buildButton(
                    'e',
                    backgroundColor: const Color(0xFF505050),
                    onPressed: () => _onScientificPressed('e'),
                  ),
                ],
              ),
            ),

            // Clear and Utility Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                children: [
                  _buildButton(
                    'C',
                    backgroundColor: const Color(0xFFFF6B6B),
                    onPressed: _clear,
                  ),
                  _buildButton(
                    'CE',
                    backgroundColor: const Color(0xFFFF8E72),
                    onPressed: _clearEntry,
                  ),
                  _buildButton(
                    '⌫',
                    backgroundColor: const Color(0xFF505050),
                    onPressed: _backspace,
                  ),
                  _buildButton(
                    '%',
                    backgroundColor: const Color(0xFFFF9500),
                    onPressed: () => _onOperatorPressed('%'),
                  ),
                  _buildButton(
                    '÷',
                    backgroundColor: const Color(0xFFFF9500),
                    onPressed: () => _onOperatorPressed('÷'),
                  ),
                ],
              ),
            ),

            // Number Pad Row 1 (7, 8, 9, ×)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                children: [
                  _buildButton('7', onPressed: () => _onNumberPressed('7')),
                  _buildButton('8', onPressed: () => _onNumberPressed('8')),
                  _buildButton('9', onPressed: () => _onNumberPressed('9')),
                  _buildButton(
                    '×',
                    backgroundColor: const Color(0xFFFF9500),
                    onPressed: () => _onOperatorPressed('×'),
                  ),
                ],
              ),
            ),

            // Number Pad Row 2 (4, 5, 6, -)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                children: [
                  _buildButton('4', onPressed: () => _onNumberPressed('4')),
                  _buildButton('5', onPressed: () => _onNumberPressed('5')),
                  _buildButton('6', onPressed: () => _onNumberPressed('6')),
                  _buildButton(
                    '-',
                    backgroundColor: const Color(0xFFFF9500),
                    onPressed: () => _onOperatorPressed('-'),
                  ),
                ],
              ),
            ),

            // Number Pad Row 3 (1, 2, 3, +)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                children: [
                  _buildButton('1', onPressed: () => _onNumberPressed('1')),
                  _buildButton('2', onPressed: () => _onNumberPressed('2')),
                  _buildButton('3', onPressed: () => _onNumberPressed('3')),
                  _buildButton(
                    '+',
                    backgroundColor: const Color(0xFFFF9500),
                    onPressed: () => _onOperatorPressed('+'),
                  ),
                ],
              ),
            ),

            // Number Pad Row 4 (±, 0, ., =)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                children: [
                  _buildButton('±', onPressed: () => _onScientificPressed('±')),
                  _buildButton('0', onPressed: () => _onNumberPressed('0')),
                  _buildButton('.', onPressed: _onDecimalPressed),
                  _buildButton(
                    '=',
                    backgroundColor: const Color(0xFF34C759),
                    onPressed: _calculate,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
