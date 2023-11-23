// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ListController extends GetxController {
  RxList toDoList = [].obs;

  var box = Hive.box('MyBox');

  Rx<TextEditingController> controller = TextEditingController().obs;
  @override
  Future<void> onInit() async {
    if (box.get('ToDoList') == null) {
      await createInitialData();
    } else {
      await loadData();
    }
    super.onInit();
  }

  createInitialData() {
    toDoList.value = [
      ['Add Your First Task', false],
    ];
  }

  loadData() async {
    toDoList.value = await box.get('ToDoList');
  }

  updateData() async {
    await box.put('ToDoList', toDoList.value);
    toDoList.refresh();
  }
}
