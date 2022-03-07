import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:racego/business_logic/selectablelist_cubit/selectablelist_cubit.dart';

class SelectableList extends StatefulWidget {
  const SelectableList(
      {required this.selectedItems, required this.items, Key? key})
      : super(key: key);

  final List<String> items;
  final List<String> selectedItems;

  @override
  _SelectableListState createState() => _SelectableListState();
}

class _SelectableListState extends State<SelectableList> {
  late final SelectablelistCubit _cubit;
  final TextEditingController _textControlller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _cubit = SelectablelistCubit(widget.items, widget.selectedItems);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _title(),
        const SizedBox(height: 5),
        Expanded(child: _list()),
        const SizedBox(height: 5),
        _addBar(),
      ],
    );
  }

  Widget _title() {
    return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onBackground,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              // offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        child: BlocBuilder<SelectablelistCubit, SelectablelistState>(
          bloc: _cubit,
          builder: (index, state) {
            return Text(
              'Rennklassen: ${_cubit.selection.length}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ));
  }

  Widget _list() {
    return BlocBuilder<SelectablelistCubit, SelectablelistState>(
      bloc: _cubit,
      buildWhen: (previous, current) =>
          current is ListItemChanged ? true : false,
      builder: (context, state) {
        // assign state, because builder state isn't trustworthy ->read bloc docs
        state = _cubit.state;
        final List<String> items =
            state is ListItemChanged ? state.items : widget.items;

        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onBackground,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                // offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Material(
            child: ListView.separated(
              controller: _scrollController,
              itemBuilder: ((context, index) {
                return _listTile(items[index]);
              }),
              separatorBuilder: (context, index) => const Divider(height: 2),
              itemCount: items.length,
            ),
          ),
        );
      },
    );
  }

  Widget _listTile(String itemName) {
    return BlocBuilder<SelectablelistCubit, SelectablelistState>(
      bloc: _cubit,
      buildWhen: (previous, current) {
        if (current is ListSelectionChanged) {}
        if (current is ListSelectionChanged &&
            (current.selection.contains(itemName) ||
                current.previousSelection.contains(itemName))) {
          return true;
        }
        return false;
      },
      builder: (context, _) {
        final bool selected = _cubit.selection.contains(itemName);
        return InkWell(
          onTap: () => _selectionChanged(itemName),
          child: Container(
            height: 30,
            padding: const EdgeInsets.all(3),
            child: Row(
              children: [
                const SizedBox(width: 10),
                Icon(
                  selected ? Icons.check_box : Icons.check_box_outline_blank,
                  size: 15,
                ),
                const SizedBox(width: 20),
                Text(itemName),
              ],
            ),
            color: selected ? Theme.of(context).selectedRowColor : null,
          ),
        );
      },
    );
  }

  void _selectionChanged(String item) {
    if (_cubit.selection.contains(item)) {
      _cubit.selectionChanged(item, false);
    } else {
      _cubit.selectionChanged(item, true);
    }
  }

  void _addItem(String item) {
    _cubit.addItem(item);
  }

  Widget _addBar() {
    return Container(
      height: 40,
      margin: const EdgeInsets.only(top: 5, bottom: 5),
      padding: const EdgeInsets.only(bottom: 7),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              style: const TextStyle(fontSize: 15),
              decoration: InputDecoration(
                hintText: 'Klassen erstellen...',
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
}
