
import 'package:flutter/material.dart';
import 'settings_tile.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDarkTheme = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          isDarkTheme
              ? const Color(0xff121212)
              : Colors.white,

      appBar: AppBar(
        title: const Text("Настройки"),

        backgroundColor:
            isDarkTheme
                ? const Color(0xff121212)
                : Colors.white,

        foregroundColor:
            isDarkTheme
                ? Colors.white
                : Colors.black,

        elevation: 0,
      ),

      body: Center(
        child: SizedBox(
          width: 300,

          child: SettingsTile(
            isDarkTheme: isDarkTheme,

            onChanged: (value) {
              setState(() {
                isDarkTheme = value;
              });
            },
          ),
        ),
      ),
    );
  }
}