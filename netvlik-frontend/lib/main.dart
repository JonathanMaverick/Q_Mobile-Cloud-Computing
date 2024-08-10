import 'package:flutter/material.dart';
import 'package:netvlik/page/login.dart';
import 'package:netvlik/utils/user_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
        create: (context) => UserProvider(''), child: const MainApp()),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, value, child) => MaterialApp(
        title: 'Netvlik',
        theme: ThemeData(
          brightness: value.isDarkMode ? Brightness.dark : Brightness.light,
        ),
        home: const LoginPage(),
      ),
    );
  }
}
