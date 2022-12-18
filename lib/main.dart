import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truckappp/provider/google_map_provider.dart';
import 'package:truckappp/splash_screen.dart';
import 'package:truckappp/utils/app_string.dart';

import 'package:truckappp/views/tracking_view.dart/tracking_imports.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GoogleMapProvider()),
      ],
      child: MaterialApp(
        title: AppStrings.app__main___name,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
