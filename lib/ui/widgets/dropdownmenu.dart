import 'package:flutter/material.dart';

class DropDownMenu extends StatefulWidget {
  const DropDownMenu(
      {Key? key,
      List<String>? items,
      this.selectionChanged,
      this.initialSelection})
      : items = items ?? const [],
        super(key: key);

  final List<String> items;
  final Function(String?)? selectionChanged;
  final String? initialSelection;

  @override
  State<DropDownMenu> createState() => _DropDownMenuState();
}

class _DropDownMenuState extends State<DropDownMenu> {
  String? _currentItem;

  @override
  void initState() {
    // try to select initial item and set it to _currentSelection
    if (widget.initialSelection != null &&
        widget.items.contains(widget.initialSelection)) {
      _currentItem = widget.initialSelection;
      widget.selectionChanged?.call(widget.initialSelection);
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // if the list changes, this function will re-validate the current selection
    if (!widget.items.contains(_currentItem)) {
      // try to set initial selection
      if (widget.initialSelection != null &&
          widget.items.contains(widget.initialSelection)) {
        _currentItem = widget.initialSelection;
        widget.selectionChanged?.call(widget.initialSelection);
      } else {
        // try to select first item
        if (widget.items.isNotEmpty) {
          _currentItem = widget.items.first;
          widget.selectionChanged?.call(_currentItem = widget.items.first);
        }
        // else reset selection (no selection)
        else {
          _currentItem = null;
          widget.selectionChanged?.call(null);
        }
      }
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      focusColor: Colors.transparent,
      value: _currentItem,
      icon: const Icon(
        Icons.arrow_downward,
        size: 20,
      ),
      decoration: const InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.all(10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
      ),
      onChanged: (String? newValue) {
        _currentItem = newValue;
        setState(() {
          widget.selectionChanged?.call(newValue);
          _currentItem = newValue!;
        });
      },
      items: widget.items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
