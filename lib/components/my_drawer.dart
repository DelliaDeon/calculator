import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../themes/theme_provider.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Provider.of<ThemeProvider>(context).themeData.colorScheme.secondary,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          Center(
            child: ToggleButtons(
              children: [
                Icon(Icons.light_mode),
                Icon(Icons.dark_mode_outlined)
              ],
              onPressed: (int index){
                Provider.of<ThemeProvider>(context, listen: false).changeTheme();
              },
              isSelected: [
                !Provider.of<ThemeProvider>(context).isDarkMode,
                Provider.of<ThemeProvider>(context).isDarkMode
              ],
            ),
          ),
        ],
      ),
    );
  }
}
