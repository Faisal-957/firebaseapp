import 'package:flutter/material.dart';
import 'package:widgets_practicing/Api/weatherapp.dart';
import 'package:widgets_practicing/authscreen/homescreen.dart';
import 'package:widgets_practicing/noteapp/noteapp.dart';
import 'package:widgets_practicing/student_data.dart/student.dart';

class Appbarscreen extends StatefulWidget {
  const Appbarscreen({super.key});

  @override
  State<Appbarscreen> createState() => _AppbarscreenState();
}

class _AppbarscreenState extends State<Appbarscreen> {
  final List<Widget> screens = [
    const HomeScreen(),
    const Notehome(),
    const WeatherScreen(),
    const StudentScreen(),
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'SAVO ',
          style: TextStyle(color: Colors.green, fontSize: 30),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: Icon(Icons.menu),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Handle search action
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Handle notifications action
            },
          ),
        ],
      ),
      body: screens[selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        iconSize: 40,
        backgroundColor: Colors.white,
        currentIndex: selectedIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.black54,

        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },

        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.note_add),
            label: 'Add Note',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.cloud), label: 'Weather'),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_a_photo),
            label: 'Student Records',
          ),
        ],
      ),
    );
  }
}
