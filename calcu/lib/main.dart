import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData.dark(),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String output = "0";
  String _output = "0";
  double num1 = 0.0;
  double num2 = 0.0;
  String operand = "";

  buttonPressed(String buttonText) {
    if (buttonText == "C") {
      _output = "0";
      num1 = 0.0;
      num2 = 0.0;
      operand = "";
    } else if (buttonText == "DEL") {
      _output = _output.length > 1 ? _output.substring(0, _output.length - 1) : "0";
    } else if (buttonText == "=") {
      num2 = double.parse(output);

      switch (operand) {
        case "+":
          _output = (num1 + num2).toString();
          break;
        case "-":
          _output = (num1 - num2).toString();
          break;
        case "*":
          _output = (num1 * num2).toString();
          break;
        case "/":
          _output = (num1 / num2).toString();
          break;
      }

      num1 = 0.0;
      num2 = 0.0;
      operand = "";
    } else if (buttonText == "+" ||
        buttonText == "-" ||
        buttonText == "*" ||
        buttonText == "/") {
      num1 = double.parse(output);
      operand = buttonText;
      _output = "0";
    } else {
      _output += buttonText;
    }

    setState(() {
      output = double.parse(_output).toString();
    });
  }

  Widget buildButton(String buttonText, Color color) {
    return ElevatedButton(
      onPressed: () => buttonPressed(buttonText),
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(10), // Reduced padding for smaller buttons
        backgroundColor: buttonText == "="
            ? Colors.blue
            : (buttonText == "+" || buttonText == "-" || buttonText == "*" || buttonText == "/")
            ? Colors.orange
            : Colors.grey[850]!,
      ),
      child: Text(
        buttonText,
        style: const TextStyle(fontSize: 16, color: Colors.white), // Reduced font size
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Calculator")),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
            child: Text(
              output,
              style: const TextStyle(
                fontSize: 24.0, // Further reduced font size
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Divider(),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 1.2, // Adjusted aspect ratio for smaller buttons
              ),
              itemCount: 16,
              itemBuilder: (context, index) {
                List<String> buttons = [
                  'C', '/', 'X', 'AC',
                  '7', '8', '9', '-',
                  '4', '5', '6', '+',
                  '1', '2', '3', '=',
                ];
                return buildButton(
                    buttons[index],
                    buttons[index] == "="
                        ? Colors.blue
                        : (buttons[index] == "C" || buttons[index] == "AC")
                        ? Colors.red
                        : Colors.grey[850]!);
              },
            ),
          ),
        ],
      ),
    );
  }
}
