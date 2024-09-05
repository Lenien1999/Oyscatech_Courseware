// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:ucris_oyscatech/constant/style.dart';
 

// ignore: must_be_immutable
class CustomDropdownButton extends StatefulWidget {
  List<String> values;
  double width;
  final ValueChanged<String?>? onChanged;
  CustomDropdownButton(
      {super.key, required this.values, required this.width, this.onChanged});

  @override
  _CustomDropdownButtonState createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.values.isNotEmpty ? widget.values.first : null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      padding:
          EdgeInsets.symmetric(vertical: 6, horizontal: widget.width * 0.05),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        iconEnabledColor: Colors.white,
        focusColor: Colors.white,
        value: selectedValue,
        underline: Container(),
        dropdownColor: Colors.white,
        style: textStyle(
            color: Colors.teal, fontsize: 14, fontWeight: FontWeight.bold),
        items: widget.values
            .map((e) => DropdownMenuItem(
                  value: e,
                  child: Text(e),
                ))
            .toList(),
        icon: const Icon(Icons.arrow_drop_down, color: Colors.teal),
        onChanged: (String? newValue) {
          setState(() {
            selectedValue = newValue;
          });
          if (widget.onChanged != null) {
            widget.onChanged!(newValue);
          }
        },
      ),
    );
  }
}
