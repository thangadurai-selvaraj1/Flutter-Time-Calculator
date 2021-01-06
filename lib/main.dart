import 'package:flutter/material.dart';
import 'package:time_calculator/ui/DashBoardScreen.dart';

import 'Utils/NavigationRouteNames.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Time Calculator',
      debugShowCheckedModeBanner: false,
      routes: {
        NavigationRouteNames.dashBoard: (context) => DashBoardScreen(),
      },
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: DashBoardScreen(),
    );
  }
}
