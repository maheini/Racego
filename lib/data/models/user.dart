
class User {
  User(this._id, this._firstName, this._lastName, this._lapCount);
  final int _id;
  final int _lapCount;
  final String _firstName;
  final String _lastName;

  User.fromJson(Map<String, dynamic> json)
      : _id = json['id'],
        _firstName = json['first_name'],
        _lastName = json['last_name'],
        _lapCount = json['lap_count']?? 0;
  Map<String, dynamic> toJson() => {
    'id' : _id,
    'first_name': _firstName,
    'last_name': _lastName,
    'lap_count': _lapCount,
  };

  int get id => _id;
  int get lapCount => _lapCount;
  String get firstName => _firstName;
  String get lastName => _lastName;
}