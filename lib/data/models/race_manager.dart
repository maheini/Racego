class RaceManager {
  RaceManager(this.username, this.isAdmin);
  String username;
  bool isAdmin;

  RaceManager.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        isAdmin = json['is_admin'] == 1 ? true : false;
  Map<String, dynamic> toJson() => {
        'username': username,
        'is_admin': isAdmin == true ? 1 : 0,
      };
}
