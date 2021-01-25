import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/video_manager.dart';
import './models/styles.dart';
import './screens/all_videos_screen.dart';
import './screens/settings_screen.dart';
import './screens/video_screen.dart';
import './helpers/dark_theme_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(VidPlayerApp());
}

class VidPlayerApp extends StatefulWidget {
  @override
  _VidPlayerAppState createState() => _VidPlayerAppState();
}

class _VidPlayerAppState extends State<VidPlayerApp> {
  DarkThemeProvider _themeProvider = DarkThemeProvider();

  @override
  void initState() {
    super.initState();
    _getCurrentAppTheme();
  }

  //this will get the app current theme as saved in the shared pref file
  void _getCurrentAppTheme() async {
    _themeProvider.darkTheme =
        await _themeProvider.darkThemePreference.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
        create: (ctx) => _themeProvider,
        ),

         ChangeNotifierProvider(
        create: (ctx) => VideoManager(),
        ),

      ],
    
        child: Consumer<DarkThemeProvider>(
          builder: (_, themeProvider, __) => MaterialApp(
            title: 'Video Player',
            theme: Styles.themeData(themeProvider.darkTheme, context),
            home: AllVideosScreen(),
            routes: {
              SettingsScreen.routeName: (ctx) => SettingsScreen(),
              VideoScreen.routeName: (ctx) => VideoScreen(),
            },
            debugShowCheckedModeBanner: false,
          ),
        ), 
    );
  }
}
