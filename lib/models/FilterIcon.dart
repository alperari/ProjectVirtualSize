import 'package:flutter/material.dart';

class FilterIcon extends StatefulWidget {
  final Icon icon;
  final bool isSelected;
  final Color bgColor;

  const FilterIcon(
      {Key key,
        this.icon,
        this.isSelected = false,
        this.bgColor = Colors.green})
      : super(key: key);
  @override
  _FilterIconState createState() => _FilterIconState();
}

class _FilterIconState extends State<FilterIcon> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        border: widget.isSelected
            ? Border.all(
          color: Colors.grey,
          width: 2
        )
            : null,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Center(
        child: Container(
          height: 38,
          width: 38,
          decoration: BoxDecoration(
            color: widget.bgColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          child: widget.icon,
        ),
      ),
    );
  }
}