import 'package:racego/data/models/user.dart';

class RankingList {
  RankingList(List<Map<String, String>>? ranks) : _ranks = ranks ?? [];

  final List<Map<String, String>> _ranks;

  Map<String, String> getRank(int rank) {
    if (rank >= _ranks.length) {
      return {'dsf': 'sdf'};
    } else {
      return _ranks[rank - 1];
    }
  }

  static RankingList fromJson(List<dynamic> json) {
    List<Map<String, String>> ranking =
        json.map((e) => {e['name'].toString(): e['time'].toString()}).toList();

    return RankingList(ranking);
  }
}
