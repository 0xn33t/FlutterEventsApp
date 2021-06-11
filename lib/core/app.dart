import 'package:eventsapp/core/providers/event_provider.dart';
import 'package:eventsapp/ui/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'common/app_theme.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EventProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Events App',
        theme: appTheme,
        home: HomeScreen(),
      ),
    );
  }
}
