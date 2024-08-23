import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo2_app/app_colors.dart';
import 'package:todo2_app/providers/theme_provider.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      this.hintText,
      this.controller,
      this.initialValue,
      this.onChanged,
      this.labelText});
  final String? hintText;
  final TextEditingController? controller;
  final String? initialValue;
  final void Function(String)? onChanged;
  final String? labelText;

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return TextFormField(
      initialValue: initialValue,
      onChanged: onChanged,
      controller: controller,
      style: TextStyle(
        color: themeProvider.appTheme == ThemeMode.dark
            ? Colors.white
            : Colors.black,
      ),
      cursorColor: AppColors.primaryColor,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          color: themeProvider.appTheme == ThemeMode.dark
              ? Colors.white
              : Colors.black,
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          color: themeProvider.appTheme == ThemeMode.dark
              ? Colors.white
              : Colors.black,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(22),
          borderSide: BorderSide(
            color: AppColors.grey,
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(22),
          borderSide: BorderSide(
            color: AppColors.grey,
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(22),
          borderSide: BorderSide(
            color: AppColors.primaryColor,
            width: 2,
          ),
        ),
      ),
    );
  }
}
