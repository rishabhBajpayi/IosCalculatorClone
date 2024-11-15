import 'package:flutter_bloc/flutter_bloc.dart';

class Calculations extends Cubit<CalculationsState> {
  Calculations() : super(CalculationsState());

  var _oldOperator = '';
  String? _b;

  void calculate(String text) {
    double? digit = double.tryParse(text);
    if (digit != null || text == ".") {
      if (state.result?.contains(".") == true && text == ".") return;
      if (state.operator == null || state.operator == "=") {
        var r = "${state.a ?? ""}$text";
        emit(state.copyWith(a: r, result: r));
      } else {
        var r = "${state.b ?? ""}$text";
        emit(state.copyWith(b: r, result: r));
      }
    } else {
      if (text == "AC" || (state.a == null && state.b == null)) {
        emit(CalculationsState());
      } else {
        if (text != "=") {
          _oldOperator = text;
        } else if (state.operator != "=") {
          _b = state.b;
        }
        if (state.operator == "=") {
          state.operator = _oldOperator;
          state.b = _b;
        }

        if (text == "+/-") {
          if (state.operator == null) {
            var r = state.a!.contains("-")
                ? state.result?.substring(1, state.result?.length)
                : "-${state.result}";
            emit(state.copyWith(a: r, result: r));
          } else {
            var r = state.b!.contains("-")
                ? state.result?.substring(1, state.result?.length)
                : "-${state.result}";
            emit(state.copyWith(b: r, result: r));
          }
        } else if (text == "%") {
          var r =
              "${(int.tryParse(state.result ?? "") ?? double.tryParse(state.result ?? "") ?? 0) / 100}";
          if (state.operator == null) {
            emit(state.copyWith(a: r, result: r));
          } else {
            emit(state.copyWith(b: r, result: r));
          }
        } else if (state.operator == "+") {
          var r =
              "${(int.tryParse(state.a ?? "") ?? double.tryParse(state.a ?? "") ?? 0) + (int.tryParse(state.b ?? '') ?? double.tryParse(state.b ?? "") ?? 0)}";
          if (state.a != null && state.b != null) {
            emit(CalculationsState(
                a: text == "=" ? "" : r, operator: text, result: r));
          } else {
            emit(state.copyWith(operator: text));
          }
        } else if (state.operator == "-") {
          var r =
              "${(int.tryParse(state.a ?? "") ?? double.tryParse(state.a ?? "") ?? 0) - (int.tryParse(state.b ?? '') ?? double.tryParse(state.b ?? "") ?? 0)}";
          if (state.a != null && state.b != null) {
            emit(CalculationsState(
                a: text == "=" ? "" : r, operator: text, result: r));
          } else {
            emit(state.copyWith(operator: text));
          }
        } else if (state.operator == "*") {
          var r =
              "${(int.tryParse(state.a ?? "") ?? double.tryParse(state.a ?? "") ?? 0) * (int.tryParse(state.b ?? '') ?? double.tryParse(state.b ?? "") ?? 0)}";
          if (state.a != null && state.b != null) {
            emit(CalculationsState(
                a: text == "=" ? "" : r, operator: text, result: r));
          } else {
            emit(state.copyWith(operator: text));
          }
        } else if (state.operator == "÷") {
          var r =
              "${(int.tryParse(state.a ?? '') ?? double.tryParse(state.a ?? "") ?? 0) / (int.tryParse(state.b ?? "") ?? double.tryParse(state.b ?? "") ?? 0)}";
          if (state.a != null && state.b != null) {
            emit(CalculationsState(
                a: text == "=" ? "" : r, operator: text, result: r));
          } else {
            emit(state.copyWith(operator: text));
          }
        } else {
          emit(state.copyWith(operator: text));
        }
      }
    }
  }
}

class CalculationsState {
  String? a;
  String? b;
  String? operator;
  String? result;

  CalculationsState({this.a, this.b, this.operator, this.result});

  CalculationsState copyWith(
      {String? a, String? b, String? operator, String? result}) {
    return CalculationsState(
      a: a ?? this.a,
      b: b ?? this.b,
      operator: operator ?? this.operator,
      result: result ?? this.result,
    );
  }
}
