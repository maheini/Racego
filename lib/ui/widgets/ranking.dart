import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:racego/business_logic/ranking_cubit/ranking_cubit.dart';
import 'package:racego/data/exceptions/racego_exception.dart';
import 'package:racego/data/models/rankinglist.dart';
import 'package:racego/ui/widgets/dropdownmenu.dart';
import 'package:racego/ui/widgets/titlebar.dart';

import '../../data/api/racego_api.dart';
import '../../generated/l10n.dart';

class Ranking extends StatefulWidget {
  const Ranking({Key? key, this.onAuthException}) : super(key: key);

  final void Function()? onAuthException;
  @override
  State<Ranking> createState() => _RankingState();
}

class _RankingState extends State<Ranking> {
  late final RankingCubit _cubit;

  @override
  void initState() {
    _cubit = RankingCubit(context.read<RacegoApi>())..loadClasses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _body(),
      ],
    );
  }

  Widget _body() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onBackground,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ],
        ),
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        child: Column(
          children: [
            _classSelector(),
            const SizedBox(height: 15),
            _listTitle(),
            _ranking(),
          ],
        ),
      ),
    );
  }

  Widget _classSelector() {
    return BlocSelector<RankingCubit, RankingcubitState, List<String>>(
      bloc: _cubit,
      selector: (state) => state.classList,
      builder: (context, classList) {
        List<String> newList = [S.current.all_classes];
        newList.addAll(classList);

        return DropDownMenu(
          items: newList,
          selectionChanged: (val) {
            if (val == null) {
              return;
            } else if (val == S.current.all_classes) {
              _cubit.loadRanking(null);
            } else {
              _cubit.loadRanking(val);
            }
          },
        );
      },
    );
  }

  Widget _ranking() {
    return Expanded(
      child: BlocBuilder<RankingCubit, RankingcubitState>(
        bloc: _cubit,
        builder: (context, state) {
          if (state is RankingLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is RankingLoaded) {
            return _generateList(state.ranking);
          } else {
            if (state is RankingError) {
              if (state.exception is AuthException) widget.onAuthException;
              return Center(
                child: Text(state.exception.errorMessage),
              );
            }
            return Center(child: Text(S.current.unknown_error));
          }
        },
      ),
    );
  }

  Widget _listTitle() {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        children: [
          SizedBox(
            width: 50,
            child: Text(
              S.current.rank,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Text(
              S.current.name,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 5),
          SizedBox(
            width: 100,
            child: Text(
              S.current.lap_time,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _generateList(RankingList list) {
    return Column(
      children: [
        const SizedBox(height: 3),
        const Divider(thickness: 2, height: 4),
        Expanded(
          child: Material(
            child: ListView.separated(
              itemCount: list.length,
              itemBuilder: (context, index) {
                return _rankingTile(
                  index + 1,
                  list.getValue(index).keys.first,
                  list.getValue(index).values.first,
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  height: 2,
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _rankingTile(int rank, String name, String time) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          SizedBox(
            width: 50,
            child: Text(
              '$rank',
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Text(name, overflow: TextOverflow.ellipsis),
          ),
          const SizedBox(width: 5),
          SizedBox(
            width: 100,
            child: Text(
              time,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
