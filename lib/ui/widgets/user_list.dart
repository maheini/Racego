import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:racego/data/models/user.dart';
import '../../business_logic/widgets/list_selection_cubit.dart';

// ignore: must_be_immutable
class UserList extends StatelessWidget {
  UserList(List<User> userList,
      {void Function(int index, int userID, bool isSelected)?
          onSelectionChanged,
      void Function(int index, int userID)? onDoubleTap,
      Key? key})
      : _list = userList,
        _onSelectionChanged = onSelectionChanged,
        _onDoubleTap = onDoubleTap,
        super(key: key);

  final List<User> _list;
  final void Function(int index, int userID, bool isSelected)?
      _onSelectionChanged;
  final void Function(int index, int userID)? _onDoubleTap;

  final ScrollController _controller = ScrollController();
  final ListSelectionCubit _listCubit = ListSelectionCubit();

  @override
  Widget build(BuildContext context) {
    return _userListDecoration(
      child: Column(
        children: [
          _title(),
          const SizedBox(height: 3),
          const Divider(thickness: 2, height: 4),
          Expanded(
            child: ListView.separated(
              controller: _controller,
              itemCount: _list.length,
              itemBuilder: (context, index) {
                return _userListTile(_list[index], index);
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
    return Row(
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
    );
  }

  Widget _userListDecoration({required Widget child}) {
    return Container(
      child: child,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.black.withOpacity(0.1)),
    );
  }

  int _pendingTabs = 0;
  int _currentIndex = -1;
  void onTab(int index, int id) async {
    // is new item selected? ->remove all pending items and update current item
    if (_currentIndex != index) {
      _pendingTabs = 0;
      _currentIndex = index;
    }
    // if there are waiting tabs, then send doubletab and reset waiting tabs
    if (_pendingTabs > 0) {
      _onDoubleTap?.call(index, id);
      _pendingTabs = 0;
    }
    // else send tab and start waiting for doubletab
    else {
      _onSelectionChanged?.call(index, id, _listCubit.state != index);
      _listCubit.itemPressed(index);
      _pendingTabs++;
      await Future.delayed(const Duration(milliseconds: 50000));
      // if there are pending tabs and still the same index, then reset
      if (_pendingTabs > 0 && _currentIndex == index) {
        _pendingTabs--;
      }
    }
  }

  Widget _userListTile(User user, int index) {
    return InkWell(
      onTap: () => onTab(index, user.id),
      child: BlocBuilder<ListSelectionCubit, int>(
        buildWhen: (previousSelection, currentSelection) {
          if (index == currentSelection || index == previousSelection) {
            return true;
          } else {
            return false;
          }
        },
        bloc: _listCubit,
        builder: (context, currentSelection) {
          return Container(
            color: currentSelection == index
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
