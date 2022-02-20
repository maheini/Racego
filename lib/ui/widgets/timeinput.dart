import 'package:flutter/material.dart';
import 'package:racego/ui/widgets/timeinputformatter.dart';

class TimeInput extends StatelessWidget {
  TimeInput({Function(Time time)? onChanged, Key? key})
      : _onChanged = onChanged,
        super(key: key);

  final Function(Time time)? _onChanged;

  final Time _duration = Time();

  final TextEditingController _minuteController =
      TextEditingController(text: '00');
  final TextEditingController _secondController =
      TextEditingController(text: '00');
  final TextEditingController _millisecondController =
      TextEditingController(text: '000');

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   padding: const EdgeInsets.all(10),
    //   decoration: BoxDecoration(
    //     color: Colors.grey.shade400,
    //     borderRadius: BorderRadius.circular(4),
    //   ),
    // child: Row(
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 35,
          width: 35,
          child: TextField(
            onChanged: (val) {
              _duration.minutes = int.tryParse(_minuteController.text) ?? 0;
              _onChanged?.call(_duration);
            },
            controller: _minuteController,
            onTap: () => _minuteController.selection = TextSelection(
                baseOffset: 0, extentOffset: _minuteController.text.length),
            style: const TextStyle(
              fontSize: 22,
            ),
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide.none,
              ),
              filled: true,
              contentPadding: EdgeInsets.all(3),
            ),
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            inputFormatters: [
              TimeInputFormatter(2),
            ],
          ),
        ),
        const Text(':', style: TextStyle(fontSize: 20)),
        SizedBox(
          height: 35,
          width: 35,
          child: TextField(
            onChanged: (val) {
              _duration.seconds = int.tryParse(_secondController.text) ?? 0;
              _onChanged?.call(_duration);
            },
            controller: _secondController,
            onTap: () => _secondController.selection = TextSelection(
                baseOffset: 0, extentOffset: _secondController.text.length),
            style: const TextStyle(
              fontSize: 22,
            ),
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide.none,
              ),
              filled: true,
              contentPadding: EdgeInsets.all(3),
            ),
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            inputFormatters: [
              TimeInputFormatter(2),
            ],
          ),
        ),
        const Text('.', style: TextStyle(fontSize: 20)),
        SizedBox(
          height: 35,
          width: 50,
          child: TextField(
            onChanged: (val) {
              _duration.milliseconds =
                  int.tryParse(_millisecondController.text) ?? 0;
              _onChanged?.call(_duration);
            },
            controller: _millisecondController,
            onTap: () => _millisecondController.selection = TextSelection(
                baseOffset: 0,
                extentOffset: _millisecondController.text.length),
            style: const TextStyle(
              fontSize: 22,
            ),
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide.none,
              ),
              filled: true,
              contentPadding: EdgeInsets.all(3),
            ),
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            inputFormatters: [
              TimeInputFormatter(3, isMilliseconds: true),
            ],
          ),
        ),
      ],
    );
    //   );
    // }
  }
}

class Time {
  Time({int? milliseconds, int? seconds, int? minutes, int? hours}) {
    if (milliseconds != null && milliseconds < 1000) {
      _milliseconds = milliseconds;
    }
    if (seconds != null && seconds < 60) {
      _seconds = seconds;
    }
    if (minutes != null && minutes < 60) {
      _minutes = minutes;
    }
    if (hours != null && hours < 60) {
      _hours = hours;
    }
  }

  int _milliseconds = 0;
  int _seconds = 0;
  int _minutes = 0;
  int _hours = 0;

  set milliseconds(int milliseconds) {
    if (milliseconds < 1000) _milliseconds = milliseconds;
  }

  set seconds(int seconds) {
    if (seconds < 60) _seconds = seconds;
  }

  set minutes(int minutes) {
    if (minutes < 60) _minutes = minutes;
  }

  set hours(int hours) {
    if (hours < 60) _hours = hours;
  }

  int get milliseconds => _milliseconds;
  int get seconds => _seconds;
  int get minutes => _minutes;
  int get hours => _hours;
}