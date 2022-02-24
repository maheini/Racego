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

  bool get isValid =>
      _milliseconds > 0 || _seconds > 0 || _minutes > 0 || _hours > 0;

  String get toTimeString {
    return '00:' +
        _minutes.toString().padLeft(2, '0') +
        ':' +
        _seconds.toString().padLeft(2, '0') +
        '.' +
        _milliseconds.toString().padLeft(3, '0');
  }

  static Time fromTimeString(String timeString) {
    if (!RegExp(r'^([0-5][0-9]:){2}[0-5][0-9].[0-9]{3}$')
        .hasMatch(timeString)) {
      throw const FormatException();
    }
    List<String> parts = timeString.split(':');
    final int hour = int.parse(parts[0]);
    final int minute = int.parse(parts[1]);
    parts = parts[2].split('.');
    final int second = int.parse(parts[0]);
    final int millisecond = int.parse(parts[1]);
    return Time(
        hours: hour,
        minutes: minute,
        seconds: second,
        milliseconds: millisecond);
  }
}
