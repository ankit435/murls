import 'package:flutter/material.dart';
import 'package:murls/screens/home.dart';
import 'package:murls/screens/listed_url_screen.dart';

import 'package:murls/Auth/services/auth_service.dart';
import 'package:murls/Auth/models/auth0_user.dart';
import 'package:murls/screens/recycle.dart';
import '../utilities/styles.dart';

Auth0User? profile = AuthService.instance.profile;

class AppDrawer extends StatelessWidget {
  Padding _avatar(Auth0User? profile) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FittedBox(
        fit: BoxFit.cover,
        child: ClipRRect(
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.all(Radius.circular(600)),
          child: Container(
            child: _avatarPhoto(profile),
          ),
        ),
      ),
    );
  }

  Widget _avatarPhoto(Auth0User? profile) {
    return profile != null && profile.hasImage
        ? Image.network(
            profile.picture,
            width: 20,
            height: 20,
          )
        : Container(
            width: 20,
            height: 20,
            child: Center(
              child: Text('${profile?.name[0].toUpperCase()}'),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color(0xFF242634),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[
                  AppBar(
                    //  leading: Icon(Icons.account_circle),
                    leading: _avatar(profile),
                    title: Text('${profile?.name.toUpperCase()}'),
                    automaticallyImplyLeading: false,
                  ),
                  Divider(),
                  Theme(
                    data: ThemeData(
                      highlightColor: Colors.red,
                    ),
                    child: ListTile(
                      leading: Icon(
                        Icons.list,
                        color: Colors.white,
                      ),
                      title: Text(
                        'All URLS',
                        style: kappbartext,
                      ),
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
                      leading: Icon(
                        Icons.admin_panel_settings,
                        color: Colors.white,
                      ),
                      title: Text('Admin page', style: kappbartext),
                      onTap: () {
                        // Navigator.of(context)
                        //     .pushReplacementNamed(LoginScreen.routeName);
                      },
                    ),
                  ),
                  Theme(
                    data: ThemeData(
                      highlightColor: Colors.red,
                    ),
                    child: ListTile(
                      leading: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                      title: Text('Recycle', style: kappbartext),
                      onTap: () {
                        Navigator.of(context)
                            .pushReplacementNamed(recycle_urls.routeName);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            Container(
              child: Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: ListTile(
                    leading: Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                    title: Text(
                      'Log Out',
                      style: kappbartext,
                    ),
                    onTap: () async {
                      await AuthService.instance.logout();
                      Navigator.of(context)
                          .pushReplacementNamed(HomeScreen.routeName);
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
