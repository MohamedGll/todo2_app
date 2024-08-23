import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo2_app/app_colors.dart';
import 'package:todo2_app/firebase_functions.dart';
import 'package:todo2_app/models/task_model.dart';
import 'package:todo2_app/providers/theme_provider.dart';
import 'package:todo2_app/widgets/custom_text_field.dart';

class EditTaskView extends StatefulWidget {
  const EditTaskView({super.key});
  static const String id = 'EditView';

  @override
  State<EditTaskView> createState() => _EditTaskViewState();
}

class _EditTaskViewState extends State<EditTaskView> {
  DateTime selectedDate = DateTime.now();

  var titleController = TextEditingController();

  var descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    var task = ModalRoute.of(context)!.settings.arguments as TaskModel;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: themeProvider.appTheme == ThemeMode.dark
          ? AppColors.secondaryDarkColor
          : AppColors.secondryColor,
      appBar: AppBar(
        title: const Text(
          'To Do List',
        ),
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                color: AppColors.primaryColor,
                width: double.infinity,
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Center(
                  child: Container(
                    height: 580,
                    width: 320,
                    decoration: BoxDecoration(
                      color: themeProvider.appTheme == ThemeMode.dark
                          ? AppColors.primaryDarkColor
                          : Colors.white,
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(
                            height: 32,
                          ),
                          Text(
                            'Edit Task',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: themeProvider.appTheme == ThemeMode.dark
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                          const SizedBox(
                            height: 26,
                          ),
                          CustomTextFormField(
                            labelText: 'Tilte',
                            initialValue: task.title,
                            onChanged: (value) {
                              task.title = value;
                            },
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          CustomTextFormField(
                            labelText: 'Description',
                            onChanged: (value) {
                              task.desc = value;
                            },
                            initialValue: task.desc,
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          Text(
                            'Selecte Time',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: themeProvider.appTheme == ThemeMode.dark
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          GestureDetector(
                            onTap: () async {
                              DateTime? newDate =
                                  await selecteDateFunction(context);
                              if (newDate != null) {
                                task.date = newDate.millisecondsSinceEpoch;
                                setState(() {});
                              }
                            },
                            child: Text(
                              DateFormat.yMd().format(
                                DateUtils.dateOnly(
                                  DateTime.fromMillisecondsSinceEpoch(
                                    task.date,
                                  ),
                                ),
                              ),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                          const Spacer(),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                            ),
                            onPressed: () {
                              FirebaseFunctions.updateTask(task);
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Save Changes',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<DateTime?> selecteDateFunction(BuildContext context) async {
    DateTime? choosenDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primaryColor,
            ),
          ),
          child: child!,
        );
      },
    );
    if (choosenDate != null) {
      selectedDate = choosenDate;
      setState(() {});
    }
    return choosenDate;
  }
}
