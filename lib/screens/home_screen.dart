// ignore_for_file: must_be_immutable, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/components/new_task_dialog.dart';

import '../components/todo_tile.dart';
import '../controller/list_controller.dart';
import '../utils/colors.dart';

class MyHomePage extends StatelessWidget {
  final String title;
  MyHomePage({super.key, required this.title});

  ListController listController = Get.put(ListController());

  var box = Hive.box('MyBox');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: green_primary,
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20))),
        backgroundColor: bg_green,
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24, color: white),
        ),
        centerTitle: true,
      ),
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.bottomCenter, colors: [green, green_primary])),
          height: MediaQuery.of(context).size.height * 1,
          width: MediaQuery.of(context).size.width * 1,
        ),
        Obx(() {
          return listController.toDoList.value.isNotEmpty
              ? ToDoTile(
                  listController: listController,
                )
              : Center(
                  child: Text(
                  'No Data Found',
                  style: TextStyle(color: white, fontSize: 25),
                ));
        }),
      ]),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(
          Icons.add,
          color: txt_green,
        ),
        label: Text(
          'Add Task',
          style: TextStyle(color: txt_green),
        ),
        backgroundColor: Colors.white.withOpacity(0.8),
        onPressed: () {
          listController.controller.value.text = '';
          showGeneralDialog(
            context: context,
            transitionBuilder: (context, a1, a2, widget) {
              return Transform.scale(
                scale: a1.value,
                child: Opacity(
                  opacity: a1.value,
                  child: widget,
                ),
              );
            },
            pageBuilder: (context, animation, secondaryAnimation) {
              return NewTask(
                controller: listController.controller.value,
                onCancel: () {
                  Navigator.pop(context);
                  listController.controller.value.clear();
                },
                onSave: () {
                  if (listController.controller.value.text != '') {
                    listController.toDoList.add(
                      [listController.controller.value.text, false],
                    );
                    Navigator.pop(context);
                    listController.controller.value.clear();
                    listController.updateData();
                  }
                },
              );
            },
          );
        },
        tooltip: 'Add Task',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
