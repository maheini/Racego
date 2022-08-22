import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:racego/data/api/racego_api.dart';
import 'package:racego/ui/widgets/coloredbutton.dart';
import 'package:racego/ui/widgets/titlebar.dart';

import '../../business_logic/racemanagerlist_cubit/racemanagerlist_cubit.dart';
import '../../data/models/race_manager.dart';
import '../../generated/l10n.dart';

class RaceManagerList extends StatefulWidget {
  const RaceManagerList({required List<RaceManager> manager, Key? key})
      : _manager = manager,
        super(key: key);

  final List<RaceManager> _manager;
  @override
  State<RaceManagerList> createState() => _RaceManagerListState();
}

class _RaceManagerListState extends State<RaceManagerList> {
  late final RaceManagerListCubit _cubit;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textControlller = TextEditingController();

  @override
  void initState() {
    _cubit = RaceManagerListCubit(widget._manager, '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleBar(
          S.current.manager,
          subtitle: S.current.manager_subtitle,
          fontSize: 20,
        ),
        const SizedBox(height: 5),
        _list(),
        const SizedBox(height: 5),
        _toolBar(),
      ],
    );
  }

  Widget _list() {
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
            _addBar(),
            const SizedBox(height: 15),
            _listTitle(),
            _listBody(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _addBar() {
    return Container(
      height: 40,
      padding: const EdgeInsets.only(bottom: 7),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              style: const TextStyle(fontSize: 15),
              decoration: InputDecoration(
                hintText: S.current.add_username,
                suffix: IconButton(
                  icon: const Icon(
                    Icons.clear,
                    size: 15,
                  ),
                  splashRadius: 15,
                  onPressed: () {
                    _textControlller.clear();
                    _cubit.changeFilter('');
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
              onChanged: (filter) => _cubit.changeFilter(filter),
              onSubmitted: (text) => _addItem(text),
              controller: _textControlller,
            ),
          ),
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
              onPressed: () => _addItem(_textControlller.text),
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }

  void _addItem(String username) {
    RaceManager manager = RaceManager(username, false);
    _cubit.addManager(manager);
    _textControlller.clear();
    _cubit.changeFilter('');
  }

  Widget _listTitle() {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              S.current.username,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 5),
          SizedBox(
            width: 50,
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

  Widget _listBody() {
    return Expanded(
      child: Column(
        children: [
          const SizedBox(height: 3),
          const Divider(thickness: 2, height: 4),
          Expanded(
            child: BlocBuilder<RaceManagerListCubit, RaceManagerListState>(
              bloc: _cubit,
              buildWhen: (previous, current) =>
                  current is ManagerListItemChanged ? true : false,
              builder: (context, state) {
                // assign state, because builder state isn't trustworthy ->read bloc docs
                state = _cubit.state;
                final List<RaceManager> manager =
                    state is ManagerListItemChanged
                        ? state.manager
                        : widget._manager;

                return Material(
                  child: ListView.separated(
                    controller: _scrollController,
                    itemBuilder: ((context, index) {
                      return _listTile(manager[index]);
                    }),
                    separatorBuilder: (context, index) =>
                        const Divider(height: 2),
                    itemCount: manager.length,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _listTile(RaceManager manager) {
    return BlocBuilder<RaceManagerListCubit, RaceManagerListState>(
      bloc: _cubit,
      buildWhen: (previous, current) {
        if (current is ManagerListSelectionChanged) {}
        if (current is ManagerListSelectionChanged &&
            (current.selectedUserName.toLowerCase() ==
                    manager.username.toLowerCase() ||
                previous.selectedUserName.toLowerCase() ==
                    manager.username.toLowerCase())) {
          return true;
        }
        return false;
      },
      builder: (context, _) {
        final bool selected = _cubit.state.selectedUserName == manager.username;
        return InkWell(
          onTap: () => _selectionChanged(manager.username),
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    manager.username,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 5),
                SizedBox(
                  width: 50,
                  child: Text(
                    manager.isAdmin
                        ? S.of(context).role_administrator
                        : S.of(context).role_manager,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            color: selected ? Theme.of(context).selectedRowColor : null,
          ),
        );
      },
    );
  }

  void _selectionChanged(String username) {
    if (_cubit.selection == username) {
      _cubit.unSelect();
    } else {
      _cubit.select(username);
    }
  }

  Widget _toolBar() {
    return BlocSelector<RaceManagerListCubit, RaceManagerListState, String>(
      bloc: _cubit,
      selector: (state) => state.selectedUserName,
      builder: (context, state) {
        bool isCurrentUser = context.read<RacegoApi>().username == state;
        bool disabled = state.isEmpty || isCurrentUser;

        return AbsorbPointer(
          absorbing: disabled,
          child: Row(
            children: [
              Expanded(
                child: ColoredButton(
                  const Icon(Icons.remove_circle),
                  color: Colors.red,
                  onPressed: () => _cubit.removeManager(state),
                  isDisabled: disabled,
                ),
              ),
              Expanded(
                child: ColoredButton(
                  Text(S.of(context).switch_role),
                  color: Colors.green,
                  onPressed: () => _cubit.changeRole(state),
                  isDisabled: disabled,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
