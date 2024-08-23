import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo2_app/app_colors.dart';
import 'package:todo2_app/firebase_functions.dart';
import 'package:todo2_app/models/task_model.dart';
import 'package:todo2_app/providers/theme_provider.dart';
import 'package:todo2_app/widgets/custom_text_field.dart';

class CustomBottomSheet extends StatefulWidget {
  const CustomBottomSheet({super.key});

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  DateTime selectedDate = DateTime.now();
  var titleController = TextEditingController();
  var descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Add New Task',
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
            controller: titleController,
            hintText: 'Title',
          ),
          const SizedBox(
            height: 18,
          ),
          CustomTextFormField(
            controller: descController,
            hintText: 'Description',
          ),
          const SizedBox(
            height: 18,
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
            onTap: () {
              selecteDateFunction(context);
            },
            child: Text(
              selectedDate.toString().substring(0, 10),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: AppColors.primaryColor,
              ),
            ),
          ),
          const SizedBox(
            height: 18,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
            ),
            onPressed: () {
              TaskModel task = TaskModel(
                title: titleController.text,
                desc: descController.text,
                date: DateUtils.dateOnly(selectedDate).millisecondsSinceEpoch,
                userId: FirebaseAuth.instance.currentUser!.uid,
              );
              FirebaseFunctions.addTask(task);
              Navigator.pop(context);
            },
            child: const Text(
              'Add',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void selecteDateFunction(BuildContext context) async {
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
  }
}
