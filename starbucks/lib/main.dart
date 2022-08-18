import 'package:flutter/material.dart';
import 'package:starbucks/starbucks.dart';

import 'miso.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AppListPage(),
    );
  }
}

class AppListPage extends StatelessWidget {
  const AppListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            //Miso Button
            TextButton(
              style: TextButton.styleFrom(
                primary: Color.fromARGB(255, 89, 144, 245),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Miso()),
                );
              },
              child: Text("Miso", style: TextStyle(fontSize: 24)),
            ),

            TextButton(
              style: TextButton.styleFrom(
                primary: Color.fromARGB(255, 3, 96, 14),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Starbucks()),
                );
              },
              child: Text("StarBucks", style: TextStyle(fontSize: 24)),
            ),

            /// Miso
            ListTile(
              title: Text("1. Miso", style: TextStyle(fontSize: 24)),
              // 미소로 넘어가는 것
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => Miso()),
              ),
            ),

            /// Starbucks
            ListTile(
              title: Text("2. StarBucks", style: TextStyle(fontSize: 24)),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => Starbucks()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
