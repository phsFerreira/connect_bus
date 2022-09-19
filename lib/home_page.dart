// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(32),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://img.freepik.com/free-vector/isometric-vehicle_24877-50903.jpg?w=2000'),
                    fit: BoxFit.cover,
                  ),
                ))
          ],
        ),
      )),
    );
  }
}
