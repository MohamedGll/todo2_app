import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo2_app/app_colors.dart';
import 'package:todo2_app/providers/theme_provider.dart';
import 'package:todo2_app/views/auth/login_view.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  String selectedLang = 'English';
  List<String> langs = ['English', 'Arabic'];
  String selectedmode = 'Light';
  List<String> modes = ['Light', 'Dark'];
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          color: AppColors.primaryColor,
          width: double.infinity,
          height: 50,
          child: Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushNamedAndRemoveUntil(
                      context, LoginView.id, (route) => false);
                },
                icon: Icon(
                  Icons.logout_outlined,
                  color: themeProvider.appTheme == ThemeMode.dark
                      ? Colors.black
                      : Colors.white,
                  size: 28,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 32,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Text(
            'Language',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: themeProvider.appTheme == ThemeMode.dark
                  ? Colors.white
                  : Colors.black,
            ),
          ),
        ),
        const SizedBox(
          height: 28,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Container(
            decoration: BoxDecoration(
              color: themeProvider.appTheme == ThemeMode.dark
                  ? AppColors.primaryDarkColor
                  : Colors.white,
              border: Border.all(
                color: AppColors.primaryColor,
                width: 1.5,
              ),
            ),
            child: DropdownButton<String>(
              value: selectedLang,
              onChanged: (String? newValue) {
                setState(() {
                  selectedLang = newValue!;
                });
              },
              items: langs.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 175),
                    child: Text(
                      value,
                      style: TextStyle(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                );
              }).toList(),
              icon: const Icon(Icons.arrow_drop_down),
              iconEnabledColor: AppColors.primaryColor,
              underline: const SizedBox(),
            ),
          ),
        ),
        const SizedBox(
          height: 32,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Text(
            'Mode',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: themeProvider.appTheme == ThemeMode.dark
                  ? Colors.white
                  : Colors.black,
            ),
          ),
        ),
        const SizedBox(
          height: 28,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Container(
            decoration: BoxDecoration(
              color: themeProvider.appTheme == ThemeMode.dark
                  ? AppColors.primaryDarkColor
                  : Colors.white,
              border: Border.all(
                color: AppColors.primaryColor,
                width: 1.5,
              ),
            ),
            child: DropdownButton<String>(
              value: selectedmode,
              onChanged: (String? newValue) {
                selectedmode = newValue!;
                newValue == 'Dark'
                    ? themeProvider.changeTheme(ThemeMode.dark)
                    : themeProvider.changeTheme(ThemeMode.light);
                selectedmode = newValue;
              },
              items: modes.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 190),
                    child: Text(
                      value,
                      style: TextStyle(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                );
              }).toList(),
              icon: const Icon(Icons.arrow_drop_down),
              iconEnabledColor: AppColors.primaryColor,
              underline: const SizedBox(),
            ),
          ),
        ),
      ],
    );
  }
}
