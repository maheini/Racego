import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:racego/data/models/user.dart';
import '../../business_logic/widgets/list_selection_cubit.dart';

class UserList extends StatefulWidget {
  const UserList(List<User> userList,
      {String? title,
      void Function(String searchText)? searchChanged,
      void Function(int index, int userID, bool isSelected)? onSelectionChanged,
      void Function(int index, int userID)? onDoubleTap,
      Key? key})
      : _title = title,
        _list = userList,
        _searchChanged = searchChanged,
        _onSelectionChanged = onSelectionChanged,
        _onDoubleTap = onDoubleTap,
        super(key: key);

  final String? _title;
  final List<User> _list;
  final void Function(String searchText)? _searchChanged;
  final void Function(int index, int userID, bool isSelected)?
      _onSelectionChanged;
  final void Function(int index, int userID)? _onDoubleTap;

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  final ScrollController _controller = ScrollController();
  final ListSelectionCubit _listCubit = ListSelectionCubit();

  @override
  void didUpdateWidget(UserList oldWidget) {
    super.didUpdateWidget(oldWidget);

    // check if new items contain current id, else update selection
    var contain =
        widget._list.where((element) => element.id == _listCubit.state);
    if (contain.isEmpty) {
      _listCubit.itemPressed(-1);
      widget._onSelectionChanged?.call(-1, -1, false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _userListDecoration(
      child: Column(
        children: [
          if (widget._searchChanged != null)
            _searchBar(onChanged: widget._searchChanged),
          _title(),
          const SizedBox(height: 3),
          const Divider(thickness: 2, height: 4),
          Expanded(
            child: ListView.separated(
              controller: _controller,
              itemCount: widget._list.length,
              itemBuilder: (context, index) {
                return _userListTile(widget._list[index], index);
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  height: 2,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _title() {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        children: const [
          Expanded(
            flex: 1,
            child: Text(
              'ID',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(width: 5),
          Expanded(
            flex: 3,
            child: Text(
              'Vorname',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(width: 5),
          Expanded(
            flex: 3,
            child: Text(
              'Nachname',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(width: 5),
          Expanded(
            flex: 1,
            child: Text(
              'Runden',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  final TextEditingController _searchTextController = TextEditingController();
  Widget _searchBar({void Function(String searchtext)? onChanged}) {
    return Container(
      height: 40,
      padding: const EdgeInsets.only(bottom: 7),
      child: TextField(
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 15),
        decoration: InputDecoration(
          hintText: 'Suchen...',
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
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          contentPadding: const EdgeInsets.all(10),
          filled: true,
        ),
        onChanged: onChanged,
        controller: _searchTextController,
      ),
    );
  }

  Widget _userListDecoration({required Widget child}) {
    if (widget._title == null) {
      return Container(
        child: child,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(color: Colors.black.withOpacity(0.1)),
      );
    } else {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.grey.shade800.withOpacity(0.7),
            width: double.infinity,
            child: Text(
              widget._title!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Expanded(
            child: Container(
              child: child,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: Colors.black.withOpacity(0.1)),
            ),
          ),
          // Expanded(child: child),
        ],
      );
    }
  }

  int _pendingTabs = 0;
  int _currentID = -1;
  void onTab(int index, int id) async {
    // is new item selected? ->remove all pending items and update current item
    if (_currentID != id) {
      _pendingTabs = 0;
      _currentID = id;
    }
    // if there are waiting tabs, then send doubletab and reset waiting tabs
    if (_pendingTabs > 0) {
      widget._onDoubleTap?.call(index, id);
      _pendingTabs = 0;
    }
    // else send tab and start waiting for doubletab
    else {
      widget._onSelectionChanged?.call(index, id, _listCubit.state != id);
      _listCubit.itemPressed(id);
      _pendingTabs++;
      await Future.delayed(const Duration(milliseconds: 300));
      // if there are pending tabs and still the same id, then reset
      if (_pendingTabs > 0 && _currentID == id) {
        _pendingTabs--;
      }
    }
  }

  Widget _userListTile(User user, int index) {
    return InkWell(
      onTap: () => onTab(index, user.id), //() => onTab(index, user.id),
      child: BlocBuilder<ListSelectionCubit, int>(
        buildWhen: (previousSelection, currentSelection) {
          if (user.id == currentSelection || user.id == previousSelection) {
            return true;
          } else {
            return false;
          }
        },
        bloc: _listCubit,
        builder: (context, currentSelection) {
          return Container(
            color: _listCubit.state == user.id
                ? Colors.white.withOpacity(0.1)
                : null,
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    '${user.id}',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  flex: 3,
                  child: Text(user.firstName, overflow: TextOverflow.ellipsis),
                ),
                const SizedBox(width: 5),
                Expanded(
                  flex: 3,
                  child: Text(user.lastName, overflow: TextOverflow.ellipsis),
                ),
                const SizedBox(width: 5),
                Expanded(
                  flex: 1,
                  child:
                      Text('${user.lapCount}', overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
