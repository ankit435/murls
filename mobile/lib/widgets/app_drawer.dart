import 'package:flutter/material.dart';
import 'package:murls/screens/home.dart';
import 'package:murls/screens/listed_url_screen.dart';

import 'package:murls/screens/profile.dart';
import 'package:murls/Auth/services/auth_service.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[
                AppBar(
                  title: Text('Hello Friend!'),
                  automaticallyImplyLeading: false,
                ),
                Divider(),
                Theme(
                  data: ThemeData(
                    highlightColor: Colors.red,
                  ),
                  child: ListTile(
                    leading: Icon(Icons.list),
                    title: Text('All URLS'),
                    onTap: () {
                      Navigator.of(context)
                          .pushReplacementNamed(listed_url.routeName);
                    },
                  ),
                ),
                Divider(),
                Theme(
                  data: ThemeData(
                    highlightColor: Colors.red,
                  ),
                  child: ListTile(
                    leading: Icon(Icons.notifications),
                    title: Text('Notification'),
                    onTap: () {
                      // Navigator.of(context)
                      //     .pushReplacementNamed(listed_url.routeName);
                    },
                  ),
                ),
                Divider(),
                Theme(
                  data: ThemeData(
                    highlightColor: Colors.red,
                  ),
                  child: ListTile(
                    leading: Icon(Icons.person),
                    title: Text('Profile'),
                    onTap: () {
                      // Navigator.of(context)
                      //     .pushReplacementNamed(listed_url.routeName);
                      Navigator.of(context)
                          .pushReplacementNamed(ProfileScreen.routeName);
                      // Navigator.of(context)
                      //     .pushReplacementNamed(HomeScreen.routeName);
                    },
                  ),
                ),
                Divider(),
                Theme(
                  data: ThemeData(
                    highlightColor: Colors.red,
                  ),
                  child: ListTile(
                    leading: Icon(Icons.list),
                    title: Text('login page'),
                    onTap: () {
                      // Navigator.of(context)
                      //     .pushReplacementNamed(LoginScreen.routeName);
                    },
                  ),
                ),
              ],
            ),
          ),
          Divider(),
          Container(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: ListTile(
                leading: Icon(
                  Icons.logout,
                ),
                title: Text(
                  'log Out',
                ),
                onTap: () async {
                  await AuthService.instance.logout();
                  Navigator.of(context)
                      .pushReplacementNamed(HomeScreen.routeName);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
