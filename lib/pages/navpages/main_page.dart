import 'package:flutter/material.dart';
import 'package:matp/pages/navpages/products_page.dart';
import 'package:matp/pages/navpages/search_page.dart';
import 'package:matp/pages/navpages/settings_page.dart';

import 'home_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List Pages = [
    HomePage(),
    //SearchPage(),
    ProductsPage(),
    //SettingsPage(),
  ];

  int currentIndex = 1;
  void onTap(int index) {
setState(() {
  currentIndex = index;
});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        //backgroundColor: Colors.,
        onTap: onTap,
        currentIndex: currentIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          //BottomNavigationBarItem(
            //icon: Icon(Icons.search),
           // label: 'Search',
         // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.view_list),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
