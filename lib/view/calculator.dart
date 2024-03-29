import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CalculatorView extends StatefulWidget {
  const CalculatorView({super.key});

  @override
  State<CalculatorView> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  num x = 0;
  num y = 0;
  num z = 0;

  final dispalyOneController = TextEditingController();
  final dispalyTwoController = TextEditingController();

  late final AppLifecycleListener _listener;

  @override
  void initState() {
    dispalyOneController.text = x.toString();
    dispalyTwoController.text = y.toString();

    _listener = AppLifecycleListener(
        onShow: _onShow,
        onHide: _onHide,
        onResume: _onResume,
        onDetach: _onDetach,
        onInactive: _onInactive,
        onPause: _onPause,
        onRestart: _onRestart,
        onStateChange: _onStateChanged);
    super.initState();
  }

  void _onShow() => print("onShow called");

  void _onHide() => print("onHide called");

  void _onResume() => print("onResume called");

  void _onDetach() => print("onDetach called");

  void _onInactive() => print("onInactive called");

  void _onPause() => print("onPause called");

  void _onRestart() => print("onRestart called");

  void _onStateChanged(AppLifecycleState state) {
    print("onStateChange called");
  }

  @override
  void dispose() {
    dispalyOneController.dispose();
    dispalyTwoController.dispose();
    _listener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(children: [
        CalculatorDispaly(
            hint: "Enter first number", controller: dispalyOneController),
        const SizedBox(
          height: 30,
        ),
        CalculatorDispaly(
            hint: "Enter second number", controller: dispalyTwoController),
        const SizedBox(
          height: 30,
        ),
        Text(
          z.toString(),
          style: const TextStyle(
            fontSize: 69,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton(
              onPressed: () {
                setState(() {
                  z = num.tryParse(dispalyOneController.text)! +
                      num.tryParse(dispalyTwoController.text)!;
                });
              },
              child: const Icon(Icons.add),
            ),
            FloatingActionButton(
              onPressed: () {
                setState(() {
                  z = num.tryParse(dispalyOneController.text)! -
                      num.tryParse(dispalyTwoController.text)!;
                });
              },
              child: const Icon(CupertinoIcons.minus),
            ),
            FloatingActionButton(
              onPressed: () {
                setState(() {
                  z = num.tryParse(dispalyOneController.text)! *
                      num.tryParse(dispalyTwoController.text)!;
                });
              },
              child: const Icon(CupertinoIcons.multiply),
            ),
            FloatingActionButton(
              onPressed: () {
                setState(() {
                  z = num.tryParse(dispalyOneController.text)! /
                      num.tryParse(dispalyTwoController.text)!;
                });
              },
              child: const Icon(CupertinoIcons.divide),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        FloatingActionButton.extended(
          onPressed: () {
            setState(() {
              x = 0;
              y = 0;
              z = 0;
              dispalyOneController.clear();
              dispalyTwoController.clear();
            });
          },
          label: const Text("Clear"),
        ),
      ]),
    );
  }
}

class CalculatorDispaly extends StatelessWidget {
  const CalculatorDispaly({
    super.key,
    this.hint = "Enter a Number",
    required this.controller,
  });

  final String? hint;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      //autofocus: true,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
          borderSide: BorderSide(
            color: Colors.black,
            width: 3.0,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
          borderSide: BorderSide(
            color: Colors.black,
            width: 2.0,
          ),
        ),
        hintText: hint,
        hintStyle: const TextStyle(
          color: Colors.black,
        ),
        filled: true,
        fillColor: Colors.blueGrey,
      ),
    );
  }
}
