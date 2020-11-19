import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class MyDatePicker extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
   return new MyDatePickerState();
  }

}

class MyDatePickerState extends State<MyDatePicker> {
  //sets default value
  DateTime selectedDate = DateTime.now();
  var ctrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ctrl.text = DateFormat('dd/MM/yyyy').format(selectedDate);
    return TextFormField(
      controller: ctrl,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: 'Select an initial date',
        hintStyle: TextStyle(color: Colors.white),
        labelText: 'Initial Date',
        prefixIcon: Icon(Icons.calendar_today),
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
      initialDate: selectedDate, 
      firstDate: DateTime(2020), 
      lastDate: DateTime(2021),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark(),
          child: child
        );
      }
    );

    if (picker != null && picker != selectedDate) {
      setState(() {
        selectedDate = picker;
        ctrl.text = DateFormat('dd/MM/yyyy').format(selectedDate);
      });
    }
  }
}