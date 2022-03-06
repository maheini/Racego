import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:racego/business_logic/lapeditor_cubit/lapeditor_cubit.dart';
import 'package:racego/data/models/time.dart';
import 'package:racego/ui/widgets/coloredbutton.dart';
import 'package:racego/ui/widgets/timeinput.dart';

class LapsEditor extends StatefulWidget {
  const LapsEditor(this.laps, {Key? key}) : super(key: key);
  final List<Time> laps;
  @override
  _LapsEditorState createState() => _LapsEditorState();
}

class _LapsEditorState extends State<LapsEditor> {
  late final LapeditorCubit _cubit;

  @override
  void initState() {
    _cubit = LapeditorCubit(widget.laps);
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
        _toolButtons(),
      ],
    );
  }

  Widget _title() {
    return Container(
      color: Theme.of(context).colorScheme.onBackground,
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      child: BlocBuilder<LapeditorCubit, LapeditorState>(
        bloc: _cubit,
        buildWhen: (previous, current) => current is LapsChanged,
        builder: (index, state) {
          return Text(
            'Runden: ${_cubit.laps.length}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          );
        },
      ),
    );
  }

  Widget _list() {
    return BlocBuilder<LapeditorCubit, LapeditorState>(
      bloc: _cubit,
      buildWhen: (previous, current) => current is LapsChanged,
      builder: (context, state) {
        // assign state, because builder state isn't trustworthy ->read bloc docs
        state = _cubit.state;

        if (state is LapsChanged) {
          final List<Time> laps = state.laps;
          return Material(
            child: ListView.separated(
              itemBuilder: ((context, index) {
                return _listTile(index, laps[index].toTimeString);
              }),
              separatorBuilder: (context, index) => const Divider(height: 2),
              itemCount: laps.length,
            ),
          );
        } else {
          return const Text('Unbekannter Fehler');
        }
      },
    );
  }

  Widget _listTile(int index, String itemName) {
    return BlocBuilder<LapeditorCubit, LapeditorState>(
      bloc: _cubit,
      buildWhen: (previous, current) => current is SelectionChanged,
      builder: (context, state) {
        final bool selected = _cubit.currentSelection == index;

        return InkWell(
          onTap: () => _cubit.selectionChanged(index),
          child: Container(
            height: 30,
            padding: const EdgeInsets.all(3),
            child: Text(itemName, textAlign: TextAlign.center),
            color: selected ? Theme.of(context).selectedRowColor : null,
          ),
        );
      },
    );
  }

  _toolButtons() {
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          _timeInput(),
          _addTimeButton(),
          _removeTimeButton(),
        ],
      ),
    );
  }

  Time? _currentTime;
  Widget _timeInput() {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: BlocSelector<LapeditorCubit, LapeditorState, int>(
        bloc: _cubit,
        selector: (state) => state.selectedIndex,
        builder: (context, state) {
          return TimeInput(
            reset: true,
            onChanged: (time) {
              _currentTime = time;
              _cubit.timeInputChanged(time);
            },
          );
        },
      ),
    );
  }

  Widget _addTimeButton() {
    return BlocSelector<LapeditorCubit, LapeditorState, bool>(
      bloc: _cubit,
      selector: (state) => state.isValidTime,
      builder: (context, isValidTime) {
        return Expanded(
          child: ColoredButton(
            const Icon(Icons.access_alarm),
            color: Colors.green,
            isDisabled: !isValidTime,
            onPressed: () => _cubit.addLap(_currentTime ?? Time()),
          ),
        );
      },
    );
  }

  Widget _removeTimeButton() {
    return BlocSelector<LapeditorCubit, LapeditorState, int>(
      bloc: _cubit,
      selector: (state) => state.selectedIndex,
      builder: (context, currentSelection) {
        return Expanded(
          child: IgnorePointer(
            ignoring: currentSelection < 0,
            child: ColoredButton(
              const Icon(Icons.dangerous),
              color: Colors.red,
              isDisabled: currentSelection < 0,
              onPressed: () => _cubit.removeLap(_cubit.currentSelection),
            ),
          ),
        );
      },
    );
  }
}
