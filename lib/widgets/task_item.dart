import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo2_app/app_colors.dart';
import 'package:todo2_app/firebase_functions.dart';
import 'package:todo2_app/models/task_model.dart';
import 'package:todo2_app/providers/theme_provider.dart';
import 'package:todo2_app/views/edit_task_view.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key, required this.taskModel});
  final TaskModel taskModel;

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Slidable(
      startActionPane: ActionPane(
        extentRatio: .5,
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              FirebaseFunctions.deleteTask(taskModel.id);
            },
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(22),
              topLeft: Radius.circular(22),
            ),
          ),
          SlidableAction(
            onPressed: (context) {
              Navigator.pushNamed(context, EditTaskView.id,
                  arguments: taskModel);
            },
            backgroundColor: AppColors.primaryColor,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Edit',
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(22),
              topRight: Radius.circular(22),
            ),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26),
        child: Container(
          decoration: BoxDecoration(
            color: themeProvider.appTheme == ThemeMode.dark
                ? AppColors.primaryDarkColor
                : Colors.white,
            borderRadius: BorderRadius.circular(22),
          ),
          width: double.infinity,
          height: 115,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Row(
              children: [
                Container(
                  width: 3.5,
                  height: 60,
                  decoration: BoxDecoration(
                    color: taskModel.isDone == true
                        ? Colors.green
                        : AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        taskModel.title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: taskModel.isDone == true
                              ? Colors.green
                              : AppColors.primaryColor,
                        ),
                      ),
                      Text(
                        taskModel.desc,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: taskModel.isDone == true
                              ? Colors.green
                              : AppColors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                taskModel.isDone == true
                    ? const Text(
                        'Done!',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    : ElevatedButton(
                        onPressed: () {
                          taskModel.isDone = true;
                          FirebaseFunctions.updateTask(taskModel);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Icon(
                          Icons.done_outline_rounded,
                          color: Colors.white,
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
