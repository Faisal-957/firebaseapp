import 'package:flutter/material.dart';

class Appbarscreen extends StatefulWidget {
  const Appbarscreen({super.key});

  @override
  State<Appbarscreen> createState() => _AppbarscreenState();
}

class _AppbarscreenState extends State<Appbarscreen> {
  final List<String> name = [
    "faisal",
    "khan ",
    "wahab",
    "zakir"
        "faisal",
    "khan ",
    "wahab",
    "zakir"
        "faisal",
    "khan ",
    "wahab",
    "zakir",
  ];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        title: const Text('My App'),
        backgroundColor: Colors.blue,
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
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,

              itemCount: name.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  height: 100,
                  width: 200,
                  child: Card(
                    child: ListTile(
                      leading: Icon(Icons.person),

                      title: Text(name[index]),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: GridView.builder(
              itemCount: 8,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(color: Colors.green),
                );
              },
            ),
          ),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black54,
        backgroundColor: Colors.blue,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },

        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
