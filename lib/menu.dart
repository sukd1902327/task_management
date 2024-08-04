import 'package:flutter/material.dart';
import 'package:vita_app/pages/home/home_page.dart';
import 'pages/calendar_page.dart';
import 'pages/profile_page.dart';
import 'pages/tasks_page.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {

  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //here we have PageView that shows 4 pages based on user's selection
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        //the default page is HomePage which index is 0
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        //here are the 4 pages, each page has an index
        //HomePage index 0, CalendarPage index 1, and so on ...
        children: [
          HomePage(),
          const CalendarPage(),
          const TasksPage(),
          const ProfilePage(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.green)
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedIconTheme: const IconThemeData(color: Colors.green, size: 28),
          selectedItemColor: Colors.green,
          currentIndex: _selectedIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (int newIndex) {
            setState(() {
              _pageController.jumpToPage(newIndex);
            });
          },
          //the items are the label & icon of each page
          //you can change the label & icon of each item
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month),
              label: 'Calendar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.task),
              label: 'Tasks',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}