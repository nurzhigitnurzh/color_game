import 'package:flutter/material.dart';

class SettingsTile extends StatelessWidget {

  final bool isDarkTheme;
  final Function(bool) onChanged;

  const SettingsTile({
    super.key,
    required this.isDarkTheme,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(

      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(

        color:
            isDarkTheme
                ? const Color(0xff1E1E1E)
                : Colors.white,

        borderRadius: BorderRadius.circular(12),

        border: Border.all(
          color: Colors.grey.shade300,
        ),
      ),

      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween,

        children: [

          Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              Text(
                "Тёмная тема",

                style: TextStyle(

                  color:
                      isDarkTheme
                          ? Colors.white
                          : Colors.black,

                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                "Переключить тему приложения",

                style: TextStyle(

                  color:
                      isDarkTheme
                          ? Colors.grey
                          : Colors.black54,

                  fontSize: 12,
                ),
              ),
            ],
          ),

          Switch(

            value: isDarkTheme,

            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}