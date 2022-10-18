class RankingList {
  RankingList(List<Map<String, String>>? ranks) : _ranks = ranks ?? [];

  final List<Map<String, String>> _ranks;

  Map<String, String> getValue(int index) {
    if (index >= _ranks.length || index < 0) {
      return {};
    } else {
      return _ranks[index];
    }
  }

  int get length => _ranks.length;

  static RankingList fromJson(List<dynamic> json) {
    List<Map<String, String>> ranking =
        json.map((e) => {e['name'].toString(): e['time'].toString()}).toList();

    return RankingList(ranking);
  }
}
