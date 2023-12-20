// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../utils/colors.dart';

class NewTask extends StatelessWidget {
  TextEditingController controller;
  VoidCallback onCancel;
  VoidCallback onSave;
  NewTask({super.key, required this.controller, required this.onCancel, required this.onSave});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 8,
      alignment: Alignment.center,
      backgroundColor: white,
      contentPadding: const EdgeInsets.only(top: 0, right: 20, left: 20, bottom: 10),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
      actionsAlignment: MainAxisAlignment.center,
      content: ListView(
        shrinkWrap: true,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon((Icons.close)))
            ],
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: controller,
            cursorOpacityAnimates: true,
            // autofocus: true,
            maxLines: 6,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: bg_green,
                    )),
                hintText: 'Add New task',
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                hintStyle: TextStyle(color: green, fontSize: 16)),
          ),
          Expanded(
            child: TextButton(
                onPressed: onSave,
                child: Text(
                  'ADD',
                  style: TextStyle(color: txt_green, letterSpacing: 2, fontSize: 20, fontWeight: FontWeight.w800),
                )),
          )
        ],
      ),
    );
  }
}
