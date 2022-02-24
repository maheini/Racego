import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:racego/business_logic/lapeditor_cubit/lapeditor_cubit.dart';
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
        Expanded(child: _list()),
        _toolButtons(),
      ],
    );
  }

  Widget _title() {
    return Container(
      padding: const EdgeInsets.all(10),
      color: Colors.grey.shade800.withOpacity(0.7),
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
          return ListView.separated(
            itemBuilder: ((context, index) {
              return _listTile(index, laps[index].toTimeString);
            }),
            separatorBuilder: (context, index) => const Divider(height: 2),
            itemCount: laps.length,
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
            color: selected ? Colors.white.withOpacity(0.1) : null,
            child: Text(itemName, textAlign: TextAlign.center),
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
      child: BlocBuilder<LapeditorCubit, LapeditorState>(
        bloc: _cubit,
        buildWhen: (previous, state) => state is SelectionChanged,
        builder: (context, state) {
          // update state, because builder state isn't trustworthy
          state = _cubit.state;

          final bool reset = state is SelectionChanged;
          return TimeInput(
            reset: reset,
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
    return BlocBuilder<LapeditorCubit, LapeditorState>(
      bloc: _cubit,
      buildWhen: (previous, state) => state is TimeInputChanged,
      builder: (context, state) {
        // update state, because builder state isn't trustworthy
        state = _cubit.state;

        final bool disabled = !(state is TimeInputChanged && state.isValid);
        return Expanded(
          child: ColoredButton(
            const Icon(Icons.access_alarm),
            color: Colors.green,
            isDisabled: disabled,
            onPressed: () => _cubit.addLap(_currentTime ?? Time()),
          ),
        );
      },
    );
  }

  Widget _removeTimeButton() {
    return BlocBuilder<LapeditorCubit, LapeditorState>(
      bloc: _cubit,
      buildWhen: (previous, current) => current is SelectionChanged,
      builder: (context, state) {
        // update state, because builder state isn't trustworthy
        state = _cubit.state;

        final bool isDisabled =
            !(state is SelectionChanged && state.currentSelection >= 0);
        return Expanded(
          child: IgnorePointer(
            ignoring: isDisabled,
            child: ColoredButton(
              const Icon(Icons.dangerous),
              color: Colors.red,
              isDisabled: isDisabled,
              onPressed: () => _cubit.removeLap(_cubit.currentSelection),
            ),
          ),
        );
      },
    );
  }
}
