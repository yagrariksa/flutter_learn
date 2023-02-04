import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorController extends GetxController {
  var userInput = "";
  var userOutput = "";

  doMath() {
    String userInputFix = userInput;

    userInputFix = userInputFix.replaceAll("X", "*");

    Parser p = Parser();
    try {
      Expression exp = p.parse(userInputFix);
      ContextModel ctx = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, ctx);

      userOutput = eval.toString();
    } catch (e) {
      print("EXPRESSION : ${userInputFix}");
      print(e);
      userOutput = "Error";
    }

    update();
  }

  clearInputAndOutput() {
    userInput = "";
    userOutput = "";
    update();
  }

  deleteBtnAction() {
    // userInput.substring(0, userInput.length - 1);
    if (userInput.length > 0) {
      userInput = userInput.substring(0, userInput.length - 1);
    }
    update();
  }

  onBtnTap(String index) {
    if (index == "0") {
      print("HEY ENOL");
    } else {
      print(index);
    }
    userInput += index;
    update();
  }
}
