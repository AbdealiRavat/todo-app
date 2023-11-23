// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../utils/colors.dart';

class TaskDetails extends StatelessWidget {
  String task;
  bool isChecked;
  TaskDetails({super.key, required this.task, required this.isChecked});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // alignment: Alignment.center,
      backgroundColor: isChecked ? bg_green : white,
      contentPadding: const EdgeInsets.all(20),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(
                isChecked ? Icons.verified : Icons.report_gmailerrorred,
                color: isChecked ? white : txt_grey,
                size: 30,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                isChecked ? 'Task Completed' : 'Task Incomplete',
                style: TextStyle(color: isChecked ? white : txt_grey, fontSize: 18),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Divider(),
          ),
          SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Text(task, style: TextStyle(color: isChecked ? white : bg_green, letterSpacing: 1, fontSize: 22)),
            ),
          ),
        ],
      ),
    );
  }
}
