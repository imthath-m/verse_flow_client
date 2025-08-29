import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/surah_provider.dart';
import 'screens/surah_list_screen.dart';
import 'utils/theme.dart';
import 'utils/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SurahProvider()),
      ],
      child: MaterialApp(
        title: AppConstants.appName,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system, // Automatically use light/dark theme based on system
        home: const SurahListScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
