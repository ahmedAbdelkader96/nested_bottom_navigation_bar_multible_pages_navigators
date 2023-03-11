import 'package:flutter/material.dart';
import 'package:nested_bottom_navigation_bar_multible_pages_navigators/home/screens/home.dart';
import 'package:nested_bottom_navigation_bar_multible_pages_navigators/keys.dart';
import 'package:nested_bottom_navigation_bar_multible_pages_navigators/settings/screens/settings.dart';





class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  List<GlobalKey<NavigatorState>> _navigatorKeys = [
    Keys.bookNavigatorKey,
    Keys.coffeeNavigatorKey,
  ];

  Future<bool> _systemBackButtonPressed() async{

    final isFirstRouteInCurrentTab =
    !await _navigatorKeys[_selectedIndex].currentState!.maybePop();
    if (isFirstRouteInCurrentTab) {
      // if not on the 'main' tab
      if (_selectedIndex != 0) {
        // select 'main' tab
        setState(() {
          _selectedIndex = 0;
        });
        // back button handled by app
        return false;
      }else{
        return true;
      }
  }
    return false;

  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _systemBackButtonPressed,
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home_filled),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: "Settings",
              )
            ],
            currentIndex: _selectedIndex,
            onTap: (int index) {
              setState(() {
                _selectedIndex = index;
              });
              print("_selectedIndex is : "+_selectedIndex.toString());
            }),
        body: SafeArea(
          top: false,
          child: IndexedStack(
            index: _selectedIndex,
            children: <Widget>[
              HomeNavigator(),
              SettingsNavigator(),
            ],
          ),
        ),
      ),
    );
  }
}