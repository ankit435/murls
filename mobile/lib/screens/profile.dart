import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:murls/screens/home.dart';

import 'package:murls/Auth/models/auth0_user.dart';
import 'package:murls/Auth/services/auth_service.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = 'ProfileScreen';
  static Route<ProfileScreen> route() {
    return MaterialPageRoute<ProfileScreen>(
      settings: RouteSettings(name: routeName),
      builder: (BuildContext context) => ProfileScreen(),
    );
  }

  Auth0User? profile = AuthService.instance.profile;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Center(
          child: Column(
            children: <Widget>[
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '${profile?.email.toUpperCase()}   ',
                      //style: ktext,
                    ),
                    TextSpan(
                      // text: 'Sign up',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: FlatButton(
            onPressed: () async {
              await AuthService.instance.logout();
              Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
            },
            child: Text(
              'Logout',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ),
      ],
    );
  }
}
