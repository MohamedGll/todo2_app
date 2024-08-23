import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo2_app/app_colors.dart';
import 'package:todo2_app/firebase_functions.dart';
import 'package:todo2_app/providers/theme_provider.dart';
import 'package:todo2_app/widgets/task_item.dart';

class TasksView extends StatefulWidget {
  const TasksView({super.key});

  @override
  State<TasksView> createState() => _TasksViewState();
}

class _TasksViewState extends State<TasksView> {
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Column(
      children: [
        Stack(
          children: [
            Container(
              color: AppColors.primaryColor,
              width: double.infinity,
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: CalendarTimeline(
                initialDate: date,
                firstDate: DateTime.now().subtract(const Duration(days: 365)),
                lastDate: DateTime.now().add(const Duration(days: 365)),
                onDateSelected: (dateTime) {
                  date = dateTime;
                  setState(() {});
                },
                leftMargin: 60,
                monthColor: themeProvider.appTheme == ThemeMode.dark
                    ? Colors.white
                    : AppColors.grey,
                dayColor: themeProvider.appTheme == ThemeMode.dark
                    ? Colors.white
                    : Colors.teal[200],
                activeDayColor: AppColors.primaryColor,
                activeBackgroundDayColor:
                    themeProvider.appTheme == ThemeMode.dark
                        ? AppColors.primaryDarkColor
                        : Colors.white,
                dotColor: AppColors.primaryColor,
                // selectableDayPredicate: (date) => date.day != 25,
                locale: 'en_ISO',
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 18,
        ),
        StreamBuilder(
          stream: FirebaseFunctions.getTask(date),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: AppColors.primaryColor,
                ),
              );
            } else if (snapshot.hasError) {
              return Text(
                'Something went wrong',
                style: TextStyle(
                  color: themeProvider.appTheme == ThemeMode.dark
                      ? Colors.white
                      : Colors.black,
                ),
              );
            }
            var tasks =
                snapshot.data?.docs.map((doc) => doc.data()).toList() ?? [];
            if (tasks.isEmpty) {
              return Center(
                child: Text(
                  'No Tasks',
                  style: TextStyle(
                    color: themeProvider.appTheme == ThemeMode.dark
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              );
            }
            return Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 18),
                itemBuilder: (context, index) {
                  return TaskItem(
                    taskModel: tasks[index],
                  );
                },
                itemCount: tasks.length,
              ),
            );
          },
        ),
      ],
    );
  }
}
