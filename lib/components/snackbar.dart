import 'package:flutter/material.dart';

import '../utils/colors.dart';

snackBar(context, listController, temp, int index) {
  return SnackBar(
    duration: const Duration(seconds: 5),
    backgroundColor: Colors.white.withOpacity(0.9),
    elevation: 0,
    // behavior: SnackBarBehavior.floating,
    // shape: StadiumBorder(),
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
    content: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Task Removed',
          style: TextStyle(fontSize: 16, color: txt_grey),
        ),
        TextButton(
            onPressed: () {
              // db.toDoList.value.add(
              //   [temp[0], temp[1]],
              // );
              listController.toDoList.value.insert(index, [temp[0], temp[1]]);
              listController.updateData();
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
            child: Text('Undo', style: TextStyle(fontSize: 18, color: txt_green))),
      ],
    ),
  );
}
