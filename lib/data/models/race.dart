class Race {
  Race(this.id, this.name, this.manager, this.isAdmin);
  int id;
  String name;
  int manager;
  bool isAdmin;

  Race.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        manager = json['manager'],
        isAdmin = json['is_admin'] == 1 ? true : false;
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'manager': manager,
        'is_admin': isAdmin,
      };
}
