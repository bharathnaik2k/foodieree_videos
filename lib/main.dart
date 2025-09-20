import 'package:flutter/material.dart';
import 'package:foodieree/controller/food_loction_controller.dart';
import 'package:foodieree/controller/food_videos.controller.dart';
import 'package:foodieree/routes/bottom_nav_bar.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocationProvider()),
        ChangeNotifierProvider(create: (_) => GetVideoProvider()),
      ],
      child: MaterialApp(
        title: 'FoodieRee',
        debugShowCheckedModeBanner: false,
        home: BottomNavBar(),
      ),
    );
  }
}
