import 'package:flutter/material.dart';

import '../popular_items/popular_imports.dart';
import 'home_imports.dart';

class BottomScreen extends StatefulWidget {
  static const routeName = '/BottomScreen';

  const BottomScreen({Key? key}) : super(key: key);

  @override
  State<BottomScreen> createState() => _BottomScreenState();
}

class _BottomScreenState extends State<BottomScreen> {
  int currentNav = 0;

  reBuild() {
    setState(() {
      currentNav = 0;
    });
  }

  Future<bool> showExitPopup() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Exit?'),
            content: const Text('Are you sure, You want to exit?'),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(false),
                style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor),
                //return false when click on "NO"
                child: const Text('No'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                ),
                //return true when click on "Yes"
                child: const Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = <Widget>[
      const HomeViews(),
      const PopularItemsViews()
    ];
    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        body: Center(
          child: _pages.elementAt(currentNav), //New
        ),
        bottomNavigationBar: SizedBox(
          child: BottomNavigationBar(
            backgroundColor: Colors.green,
            selectedItemColor: Colors.white,
            unselectedItemColor:
                Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
            showUnselectedLabels: true,
            showSelectedLabels: true,
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: TextStyle(color: Colors.white),
            unselectedLabelStyle: TextStyle(
                color: Theme.of(context)
                    .bottomNavigationBarTheme
                    .unselectedItemColor),
            currentIndex: currentNav,
            elevation: 2.0,
            items: [
              BottomNavigationBarItem(
                label: "Home",
                icon: Icon(
                  Icons.home,
                  color: Theme.of(context)
                      .bottomNavigationBarTheme
                      .unselectedItemColor,
                ),
              ),
              BottomNavigationBarItem(
                  label: "Orders",
                  icon: Icon(
                    Icons.playlist_add_check_outlined,
                    size: 30,
                    color: Theme.of(context)
                        .bottomNavigationBarTheme
                        .unselectedItemColor,
                  )),
            ],
            onTap: (index) {
              setState(() {
                currentNav = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
