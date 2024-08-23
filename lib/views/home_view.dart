import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo2_app/app_colors.dart';
import 'package:todo2_app/providers/auth_provider.dart';
import 'package:todo2_app/providers/theme_provider.dart';
import 'package:todo2_app/views/settings_view.dart';
import 'package:todo2_app/views/tasks_view.dart';
import 'package:todo2_app/widgets/custom_bottom_sheet.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  static const String id = 'HomeView';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int selectedIndex = 0;

  List<Widget> views = [
    const TasksView(),
    const SettingsView(),
  ];

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context);

    List<String> labels = [
      'To Do List, Hello ${authProvider.userModel?.userName}',
      'Settings',
    ];
    var themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text(
          labels[selectedIndex],
        ),
      ),
      body: views[selectedIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        height: 55,
        width: 55,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () {
              showModalBottomSheet(
                backgroundColor: themeProvider.appTheme == ThemeMode.dark
                    ? AppColors.primaryDarkColor
                    : Colors.white,
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: const CustomBottomSheet(),
                  );
                },
              );
            },
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 8,
        shape: const CircularNotchedRectangle(),
        padding: EdgeInsets.zero,
        child: SizedBox(
          height: 70,
          child: BottomNavigationBar(
            currentIndex: selectedIndex,
            onTap: (index) {
              selectedIndex = index;
              setState(() {});
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                ),
                label: 'Settings',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
