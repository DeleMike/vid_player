import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:provider/provider.dart';

import '../helpers/dark_theme_provider.dart';

///[SettingsScreen] screen is used to display user prefences options
class SettingsScreen extends StatelessWidget {
  static const routeName = '/settings';
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Settings'),
      ),

       body: Container(
        padding: const EdgeInsets.only(top: 1.0),
        child: SettingsList(
          backgroundColor: !themeChange.darkTheme ? Theme.of(context).canvasColor : null,
          sections: [
            SettingsSection(
              title: 'Preferences',
              titleTextStyle: TextStyle(color: themeChange.darkTheme ? Colors.white: Colors.black),
              tiles: [
                SettingsTile.switchTile(
                  title: 'Dark Mode',
                  leading: Icon(themeChange.darkTheme ? Icons.bedtime : Icons.bedtime_outlined, color: Colors.orange,),
                  switchValue: themeChange.darkTheme,
                  switchActiveColor : Colors.orange,
                  onToggle: (bool val) {
                    themeChange.darkTheme = val;
                    print('Settings: Dark Mode = $val');
                  },
                ),
               
              ],
            ),
          ],
        ),
       ),
    );
  }
}
