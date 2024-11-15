import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Calculator',
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Calculations cubit = Calculations();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: BlocProvider.value(
        value: cubit,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                child: BlocBuilder<Calculations, CalculationsState>(
                  bloc: cubit,
                  builder: (context, state) => Text(
                    state.result ?? "",
                    style: const TextStyle(fontSize: 54, color: Colors.white),
                  ),
                ),
              ),
            ),
            GridView(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, childAspectRatio: 1.5),
              physics: const ScrollPhysics(),
              children: const [
                CalButton(text: 'AC'),
                CalButton(text: '+/-'),
                CalButton(text: '%'),
                CalButton(text: '÷'),
                CalButton(text: '7'),
                CalButton(text: '8'),
                CalButton(text: '9'),
                CalButton(text: '*'),
                CalButton(text: '4'),
                CalButton(text: '5'),
                CalButton(text: '6'),
                CalButton(text: '-'),
                CalButton(text: '1'),
                CalButton(text: '2'),
                CalButton(text: '3'),
                CalButton(text: '+'),
                CalButton(text: '0'),
                CalButton(text: ''),
                CalButton(text: '.'),
                CalButton(text: '='),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CalButton extends StatelessWidget {
  const CalButton({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<Calculations>(context);
    return GestureDetector(
      onTap: text.isEmpty ? null : () => cubit.calculate(text),
      child: Container(
        margin: text.isEmpty
            ? const EdgeInsets.only(top: 0.5, right: 0.5)
            : text == "0"
            ? const EdgeInsets.only(top: 0.5, left: 0.5)
            : const EdgeInsets.all(0.5),
        color: (text == "." || text.isEmpty || int.tryParse(text) != null)
            ? Colors.grey.shade700
            : (text == "AC" || text == '+/-' || text == "%")
            ? Colors.grey.shade800
            : Colors.orange,
        child: Center(
          child: Text(
            text,
            style: const TextStyle(fontSize: 28, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
