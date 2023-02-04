import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_learn/calculatorController.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class CalculatorPage extends StatelessWidget {
  CalculatorPage({Key? key}) : super(key: key);

  final List<String> buttons = [
    "AC",
    "DEL",
    "%",
    "/",
    "7",
    "8",
    "9",
    "X",
    "4",
    "5",
    "6",
    "-",
    "1",
    "2",
    "3",
    "+",
    "0",
    ".",
    "=",
  ];

  BoxDecoration getDecor(int row, int col) {
    if (row == 5) {
      if (col == 3) {
        return orangeButton;
      } else {
        return blackButton;
      }
    } else if (col % 4 == 0) {
      return orangeButton;
    } else if (row == 1) {
      return greyButton;
    } else {
      return blackButton;
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var controller = Get.find<CalculatorController>();

    btnTap(String index) {
      switch (index) {
        case "AC":
          controller.clearInputAndOutput();
          break;
        case "DEL":
          controller.deleteBtnAction();
          break;
        case "=":
          controller.doMath();
          break;
        default:
          controller.onBtnTap(index);
      }
    }

    List<Widget> getRow(int j) {
      List<Widget> array = [];
      if (j == 5) {
        for (var i = (j * 4) - 4; i < (j * 4) - 1; i++) {
          var item = buttons[i];
          if (i == (j * 4) - 4) {
            array.add(btnLongCalculator(
              item,
              getDecor(j, i + 1),
              size,
              () {
                btnTap(item);
              },
            ));
          } else {
            array.add(btnCalculator(
              item,
              getDecor(j, i + 1),
              size,
              () {
                btnTap(item);
              },
            ));
          }
        }
      } else {
        for (var i = (j * 4) - 4; i < j * 4; i++) {
          var item = buttons[i];
          array.add(btnCalculator(
            item,
            getDecor(j, i + 1),
            size,
            () {
              btnTap(item);
            },
          ));
        }
      }
      return array;
    }

    return CupertinoPageScaffold(
        child: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GetBuilder<CalculatorController>(builder: (context) {
              return resultSection(controller, size);
            }),
            Column(
              children: [
                rowCalculator(getRow(1)),
                rowCalculator(getRow(2)),
                rowCalculator(getRow(3)),
                rowCalculator(getRow(4)),
                rowCalculator(getRow(5)),
              ],
            ),
          ],
        ),
      ),
    ));
  }

  Expanded resultSection(CalculatorController controller, Size size) {
    return Expanded(
      child: Container(
        width: size.width,
        child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  controller.userInput,
                  style: resultTextStyle,
                ),
                Text(
                  controller.userOutput,
                  style: resultTextStyle,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container rowCalculator(innerRow) {
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

  Container btnCalculator(
    String index,
    BoxDecoration decoration,
    Size size,
    VoidCallback callback,
  ) {
    return Container(
      width: size.width * 0.2,
      decoration: decoration,
      child: TextButton(
        onPressed: callback,
        child: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 16.0,
            ),
            child: Text(
              index,
              style: btnTextStyle,
            ),
          ),
        ),
      ),
    );
  }

  Container btnLongCalculator(
    String index,
    BoxDecoration decoration,
    Size size,
    VoidCallback callback,
  ) {
    return Container(
      width: size.width * 0.45,
      decoration: decoration,
      child: TextButton(
        onPressed: callback,
        child: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              index,
              style: btnTextStyle,
            ),
          ),
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

const btnTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 16,
);

const resultTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 48,
  decoration: TextDecoration.none,
);
