import 'package:racego/data/models/race_manager.dart';

class RaceDetails {
  RaceDetails(this.id, this.name, this.managers);
  int id;
  String name;
  List<RaceManager> managers;

  RaceDetails.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        managers = json['race_manager']
            .map<RaceManager>((json) => RaceManager.fromJson(json))
            .toList();
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'race_manager': managers.map((e) => e.toJson()).toList()
      };
}
