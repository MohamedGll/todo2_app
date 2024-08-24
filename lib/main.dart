import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo2_app/app_theme_data.dart';
import 'package:todo2_app/fcm.dart';
import 'package:todo2_app/firebase_options.dart';
import 'package:todo2_app/providers/auth_provider.dart';
import 'package:todo2_app/providers/theme_provider.dart';
import 'package:todo2_app/views/auth/login_view.dart';
import 'package:todo2_app/views/auth/register_view.dart';
import 'package:todo2_app/views/edit_task_view.dart';
import 'package:todo2_app/views/home_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await FirebaseFirestore.instance.disableNetwork();
  Fcm.fcmInit();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    var authProvider = Provider.of<AuthProvider>(context);
    themeProvider.getTheme();
    return MaterialApp(
      themeMode: themeProvider.appTheme,
      theme: AppThemeData.lightTheme,
      darkTheme: AppThemeData.darkTheme,
      initialRoute:
          authProvider.firebaseUser != null ? HomeView.id : LoginView.id,
      routes: {
        HomeView.id: (context) => const HomeView(),
        LoginView.id: (context) => LoginView(),
        RegisterView.id: (context) => RegisterView(),
        EditTaskView.id: (context) => const EditTaskView(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
