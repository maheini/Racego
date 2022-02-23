import 'package:racego/ui/widgets/timeinput.dart';

class UserDetails {
  UserDetails(
      this._id, this._firstName, this._lastName, this.classes, this.lapTimes);
  final int _id;
  final String _firstName;
  final String _lastName;

  static UserDetails fromJson(Map<String, dynamic> json) {
    final List<String> laps =
        (json["laps"] as List).map((e) => e as String).toList();
    final List<String> classes =
        (json["laps"] as List).map((e) => e as String).toList();
    return UserDetails(
      json['id'],
      json['first_name'],
      json['last_name'],
      classes,
      laps.map((e) => Time.fromTimeString(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    List<String> laps = lapTimes.map((name) => name.toTimeString).toList();
    return {
      'id': _id,
      'first_name': _firstName,
      'last_name': _lastName,
      'class': classes,
      'laps': laps
    };
  }

  List<Time> lapTimes = [];
  List<String> classes = [];

  int get id => _id;
  String get firstName => _firstName;
  String get lastName => _lastName;
}
