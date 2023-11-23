// ignore_for_file: must_be_immutable, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:todo_app/components/snackbar.dart';
import 'package:todo_app/components/task_dialog.dart';
import 'package:todo_app/utils/colors.dart';

import '../controller/list_controller.dart';

class ToDoTile extends StatelessWidget {
  ListController listController;
  ToDoTile({
    required this.listController,
    super.key,
  });

  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(top: 20, bottom: 80),
        itemCount: listController.toDoList.value.length,
        reverse: true,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          String task = listController.toDoList.value[index][0];
          bool isChecked = listController.toDoList.value[index][1];
          // index == listController.toDoList.value.length - 1
          //   ? Container(
          //       // height: 50,
          //       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          //       margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          //       decoration: BoxDecoration(color: Colors.white.withOpacity(0.4), borderRadius: BorderRadius.circular(8)),
          //       child: Row(
          //         crossAxisAlignment: CrossAxisAlignment.center,
          //         children: [
          //           const SizedBox(
          //             width: 10,
          //           ),
          //           Expanded(
          //               child: TextField(
          //                   controller: controller,
          //                   cursorColor: bg_green,
          //                   decoration: InputDecoration(
          //                       hintText: 'Add New Task',
          //                       hintStyle: TextStyle(color: green),
          //                       border: UnderlineInputBorder(borderSide: BorderSide.none)))),
          //         ],
          //       ))
          //   :
          return InkWell(
            onTap: () {
              showGeneralDialog(
                  context: context,
                  barrierDismissible: true,
                  barrierLabel: '',
                  barrierColor: Colors.black.withOpacity(0.7),
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
                    return TaskDetails(
                      task: task,
                      isChecked: isChecked,
                    );
                  });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.endToStart,
                onDismissed: (dismissDirection) async {
                  final temp = listController.toDoList.value.removeAt(index);
                  listController.updateData();
                  ScaffoldMessenger.of(context).showSnackBar(snackBar(context, listController, temp, index));
                },
                background: Container(
                  decoration: BoxDecoration(color: delete_red, borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Icon(
                          Icons.delete,
                          color: white,
                        ),
                      ),
                    ],
                  ),
                ),
                child: Container(
                    // height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.4), borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Transform.scale(
                          scale: 1.1,
                          child: Checkbox(
                              checkColor: white,
                              activeColor: bg_green,
                              value: isChecked,
                              onChanged: (value) async {
                                listController.toDoList.value[index][1] = !listController.toDoList.value[index][1];
                                await listController.updateData();
                              }),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            task,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: txt_grey,
                                letterSpacing: 1,
                                fontSize: 16,
                                decoration: isChecked ? TextDecoration.lineThrough : TextDecoration.none),
                          ),
                        ),
                      ],
                    )),
              ),
            ),
          );
        });
  }
}
