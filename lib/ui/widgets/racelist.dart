import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/widgets/list_selection_cubit.dart';
import '../../data/models/race.dart';
import '../../generated/l10n.dart';

class RaceList extends StatefulWidget {
  const RaceList(
      {required this.races,
      this.selectionChanged,
      this.onDoubleTap,
      this.onAddPressed,
      Key? key})
      : super(key: key);

  final List<Race> races;

  final void Function(int id, bool isSelected)? selectionChanged;
  final void Function(int selection)? onDoubleTap;
  final void Function(String name)? onAddPressed;

  @override
  State<RaceList> createState() => _RaceListState();
}

class _RaceListState extends State<RaceList> {
  final TextEditingController _searchTextController = TextEditingController();
  final ListSelectionCubit _listCubit = ListSelectionCubit();

  @override
  void didUpdateWidget(RaceList oldWidget) {
    super.didUpdateWidget(oldWidget);

    // check if new items contain current id, else update selection
    var contain =
        widget.races.where((element) => element.id == _listCubit.state);
    if (contain.isEmpty) {
      _listCubit.itemPressed(-1);
      widget.selectionChanged?.call(-1, false);
    }
  }

  int _pendingTabs = 0;
  int _lastID = -1;
  void onTab(int id) async {
    // is new item selected? ->remove all pending items and update current item
    if (_lastID != id) {
      _pendingTabs = 0;
      _lastID = id;
    }
    // if there are waiting tabs, then send doubletab and reset waiting tabs
    if (_pendingTabs > 0) {
      // If Item got unselected with the first click, then re-select the item
      if (_listCubit.state != id) {
        _listCubit.itemPressed(id);
        widget.selectionChanged?.call(id, id == _listCubit.state);
      }
      // Send doubleTap and reset pendingTabs
      widget.onDoubleTap?.call(id);
      _pendingTabs = 0;
    }
    // else send tab and start waiting for doubletab
    else {
      _listCubit.itemPressed(id);
      widget.selectionChanged?.call(id, id == _listCubit.state);
      _pendingTabs++;
      await Future.delayed(const Duration(milliseconds: 300));
      // if there are pending tabs and still the same id, then reset
      if (_pendingTabs > 0 && _lastID == id) {
        _pendingTabs--;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
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
                _searchBar(),
                const SizedBox(height: 15),
                _listTitle(),
                _generateList(widget.races),
              ],
            ),
          ),
        ),
        // const SizedBox(height: 5),
        // _toolbar(),
      ],
    );
  }

  Widget _searchBar({void Function(String searchtext)? onChanged}) {
    return Container(
      height: 40,
      padding: const EdgeInsets.only(bottom: 7),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              style: const TextStyle(fontSize: 15),
              decoration: InputDecoration(
                hintText: S.current.add_ranking_hint,
                suffix: IconButton(
                  icon: const Icon(
                    Icons.clear,
                    size: 15,
                  ),
                  splashRadius: 15,
                  onPressed: () {
                    _searchTextController.clear();
                    onChanged?.call(_searchTextController.text);
                  },
                ),
                isDense: true,
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(4),
                      bottomLeft: Radius.circular(4)),
                ),
                contentPadding: const EdgeInsets.all(10),
                filled: true,
              ),
              onChanged: onChanged,
              controller: _searchTextController,
            ),
          ),
          if (widget.onAddPressed != null)
            SizedBox(
              height: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(4),
                        bottomRight: Radius.circular(4)),
                  )),
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                ),
                onPressed: () =>
                    widget.onAddPressed?.call(_searchTextController.text),
                child: const Icon(Icons.add),
              ),
            ),
        ],
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
              S.current.id,
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
              S.current.manager,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 5),
          SizedBox(
            width: 100,
            child: Text(
              S.current.role,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _generateList(List<Race> list) {
    return Expanded(
      child: Column(
        children: [
          const SizedBox(height: 3),
          const Divider(thickness: 2, height: 4),
          Expanded(
            child: Material(
              child: ListView.separated(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return _rankingTile(
                    list[index].id,
                    list[index].name,
                    list[index].manager,
                    list[index].isAdmin,
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
      ),
    );
  }

  Widget _rankingTile(int id, String name, int manager, bool isAdmin) {
    return InkWell(
      onTap: () => onTab(id),
      child: BlocBuilder<ListSelectionCubit, int>(
        buildWhen: (previousSelection, currentSelection) {
          if (id == currentSelection || id == previousSelection) {
            return true;
          } else {
            return false;
          }
        },
        bloc: _listCubit,
        builder: (context, currentSelection) {
          return Container(
            color: currentSelection == id
                ? Theme.of(context).selectedRowColor
                : null,
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                SizedBox(
                  width: 50,
                  child: Text(
                    id.toString(),
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
                    manager.toString(),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(width: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    isAdmin
                        ? S.current.role_administrator
                        : S.current.role_manager,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
