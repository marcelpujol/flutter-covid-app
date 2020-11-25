import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class MyDatePicker extends StatefulWidget {
  final String label;
  final String hint;
  final String currentValue;
  final Function(String) callbackFn;

  MyDatePicker({ this.label, this.hint, this.currentValue, this.callbackFn });

  @override
  State<StatefulWidget> createState() {
   return new MyDatePickerState();
  }

}

class MyDatePickerState extends State<MyDatePicker> {
  //sets default value
  var ctrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ctrl.text = widget.currentValue;
    return TextFormField(
      controller: ctrl,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: widget.hint,
        hintStyle: TextStyle(color: Colors.white),
        labelText: widget.label,
        labelStyle: TextStyle(color: Colors.blueAccent),
        prefixIcon: Icon(Icons.calendar_today, color: Colors.white)
      ),
      keyboardType: TextInputType.datetime,
      onTap: () async {
        _buildDatePicker(context);
      },
      readOnly: true
    );
  }

  _buildDatePicker(BuildContext context) async {
    final DateTime picker = await showDatePicker(
      context: context, 
      initialDate: DateTime.parse(widget.currentValue), 
      firstDate: DateTime(2020), 
      lastDate: DateTime(2021),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark(),
          child: child
        );
      }
    );

    if (picker != null && picker != DateTime.parse(widget.currentValue)) {
      setState(() {
        ctrl.text = DateFormat('dd/MM/yyyy').format(picker);
        widget.callbackFn(_parseSelectedDate(picker));
      });
    }
  }

  _parseSelectedDate(DateTime selectedDate) {
    return DateFormat('yyyy-MM-dd').format(selectedDate);
  }
}