import 'package:flutter/material.dart';
import 'package:space_game/pages/StartPage.dart';
import 'package:space_game/pages/EducationPage.dart';
import 'package:space_game/pages/GamePage.dart';
import 'package:space_game/pages/SettingsPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Space Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/education':
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (context) {
                return EducationPage(
                  characterIndex: args['characterIndex'],
                  name: args['name'],
                );
              },
            );
          case '/game':
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (context) {
                return GamePage(
                  characterIndex: args['characterIndex'],
                  name: args['name'],
                );
              },
            );
          case '/settings':
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (context) {
                return SettingsPage(
                  characterIndex: args['characterIndex'],
                  name: args['name'],
                );
              },
            );
          default:
            return MaterialPageRoute(builder: (context) => StartPage());
        }
      },
      routes: {
        '/': (context) => StartPage(),
      },
    );
  }
}