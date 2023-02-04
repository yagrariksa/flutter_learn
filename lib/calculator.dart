import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({Key? key}) : super(key: key);

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  var _display = 0;

  testFun() {
    print("HEY");
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    const firstRow = [
      ButtonCalculator(
        index: "AC",
        decoration: greyButton,
      ),
      ButtonCalculator(
        index: "DEL",
        decoration: greyButton,
      ),
      ButtonCalculator(
        index: "%",
        decoration: greyButton,
      ),
      ButtonCalculator(
        index: "/",
        decoration: orangeButton,
      ),
    ];

    const secondRow = [
      ButtonCalculator(
        index: "7",
        decoration: blackButton,
      ),
      ButtonCalculator(
        index: "8",
        decoration: blackButton,
      ),
      ButtonCalculator(
        index: "9",
        decoration: blackButton,
      ),
      ButtonCalculator(
        index: "X",
        decoration: orangeButton,
      ),
    ];

    const thirdRow = [
      ButtonCalculator(
        index: "4",
        decoration: blackButton,
      ),
      ButtonCalculator(
        index: "5",
        decoration: blackButton,
      ),
      ButtonCalculator(
        index: "6",
        decoration: blackButton,
      ),
      ButtonCalculator(
        index: "-",
        decoration: orangeButton,
      ),
    ];

    const fourthRow = [
      ButtonCalculator(
        index: "1",
        decoration: blackButton,
      ),
      ButtonCalculator(
        index: "2",
        decoration: blackButton,
      ),
      ButtonCalculator(
        index: "3",
        decoration: blackButton,
      ),
      ButtonCalculator(
        index: "+",
        decoration: orangeButton,
      ),
    ];

    const lastRow = [
      ButtonLongCalculator(
        index: "0",
        decoration: blackButton,
      ),
      ButtonCalculator(
        index: ",",
        decoration: blackButton,
      ),
      ButtonCalculator(
        index: "=",
        decoration: orangeButton,
      ),
    ];

    return CupertinoPageScaffold(
        child: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              height: size.height * 0.05,
            ),
            ResultSection(result: "$_display"),
            Column(
              children: const [
                RowCalculator(innerRow: firstRow),
                RowCalculator(innerRow: secondRow),
                RowCalculator(innerRow: thirdRow),
                RowCalculator(innerRow: fourthRow),
                RowCalculator(innerRow: lastRow),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}

class ResultSection extends StatelessWidget {
  final String result;
  const ResultSection({
    Key? key,
    required this.result,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Expanded(
      child: Container(
        color: Colors.orange,
        width: size.width,
        child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("${result}"),
          ),
        ),
      ),
    );
  }
}

class RowCalculator extends StatelessWidget {
  final innerRow;
  const RowCalculator({Key? key, required this.innerRow}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: innerRow,
        ),
      ),
    );
  }
}

class ButtonCalculator extends StatelessWidget {
  final String index;
  final decoration;
  const ButtonCalculator({
    Key? key,
    required this.index,
    required this.decoration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.2,
      decoration: decoration,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
          alignment: Alignment.center,
          child: TextButton(
              onPressed: () {},
              child: Text(
                index,
                style: TextStyle(color: Colors.white, fontSize: 24),
              )),
        ),
      ),
    );
  }
}

class ButtonLongCalculator extends StatelessWidget {
  final String index;
  final decoration;
  const ButtonLongCalculator({
    Key? key,
    required this.index,
    required this.decoration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.45,
      decoration: decoration,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
          alignment: Alignment.center,
          child: TextButton(
              onPressed: () {},
              child: Text(
                index,
                style: TextStyle(color: Colors.white, fontSize: 24),
              )),
        ),
      ),
    );
  }
}

const greyButton = BoxDecoration(
  color: Color.fromARGB(174, 0, 0, 0),
  borderRadius: BorderRadius.all(
    Radius.circular(100),
  ),
);

const blackButton = BoxDecoration(
  color: Colors.black,
  borderRadius: BorderRadius.all(
    Radius.circular(100),
  ),
);

const orangeButton = BoxDecoration(
  color: Colors.orange,
  borderRadius: BorderRadius.all(
    Radius.circular(100),
  ),
);
