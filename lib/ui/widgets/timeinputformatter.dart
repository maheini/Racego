import 'package:flutter/services.dart';

class TimeInputFormatter extends TextInputFormatter {
  TimeInputFormatter(int digits, {bool? isMilliseconds})
      : _digitCount = digits,
        _isMilliseconds = isMilliseconds ?? false;
  final bool _isMilliseconds;
  final int _digitCount;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    RegExp isDigit = RegExp(r'^[0-9]*$');
    if (!isDigit.hasMatch(newValue.text)) {
      return oldValue;
    } else if (newValue.text.length >= _digitCount) {
      var newString =
          newValue.text.substring(newValue.text.length - _digitCount);
      if (newString.startsWith(RegExp(r'[0-5]')) | _isMilliseconds) {
        return TextEditingValue(
          text: newString,
          selection: TextSelection.collapsed(offset: newString.length),
        );
      } else {
        return oldValue;
      }
    } else {
      String newString = newValue.text.padLeft(_digitCount, '0');
      return TextEditingValue(
        text: newString,
        selection: TextSelection.collapsed(offset: newString.length),
      );
    }
  }
}
