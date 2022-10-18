class Time {
  Time({int? milliseconds, int? seconds, int? minutes}) {
    if (milliseconds != null && milliseconds < 1000) {
      _milliseconds = milliseconds;
    }
    if (seconds != null && seconds < 60) {
      _seconds = seconds;
    }
    if (minutes != null && minutes < 60) {
      _minutes = minutes;
    }
  }

  int _milliseconds = 0;
  int _seconds = 0;
  int _minutes = 0;

  set milliseconds(int milliseconds) {
    if (milliseconds < 1000) _milliseconds = milliseconds;
  }

  set seconds(int seconds) {
    if (seconds < 60) _seconds = seconds;
  }

  set minutes(int minutes) {
    if (minutes < 60) _minutes = minutes;
  }

  int get milliseconds => _milliseconds;
  int get seconds => _seconds;
  int get minutes => _minutes;

  bool get isValid => _milliseconds > 0 || _seconds > 0 || _minutes > 0;

  String get toTimeString {
    return _minutes.toString().padLeft(2, '0') +
        ':' +
        _seconds.toString().padLeft(2, '0') +
        '.' +
        _milliseconds.toString().padLeft(3, '0');
  }

  String get isoTime {
    return '00:' +
        _minutes.toString().padLeft(2, '0') +
        ':' +
        _seconds.toString().padLeft(2, '0') +
        '.' +
        _milliseconds.toString().padLeft(3, '0');
  }

  static Time fromTimeString(String timeString) {
    if (!RegExp(r'^[0-5][0-9]:[0-5][0-9].[0-9]{3}$').hasMatch(timeString)) {
      throw const FormatException();
    }
    List<String> parts = timeString.split(':');
    final int minute = int.parse(parts[0]);
    parts = parts[1].split('.');
    final int second = int.parse(parts[0]);
    final int millisecond = int.parse(parts[1]);
    return Time(minutes: minute, seconds: second, milliseconds: millisecond);
  }
}
