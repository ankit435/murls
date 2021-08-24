import 'package:flutter/material.dart';
import 'package:murls/Auth/services/auth_service.dart';
import 'profile.dart';

import 'listed_url_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:murls/utilities/styles.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = 'homeScreen';
  static Route<HomeScreen> route() {
    return MaterialPageRoute<HomeScreen>(
      settings: RouteSettings(name: routeName),
      builder: (BuildContext context) => HomeScreen(),
    );
  }

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isProgressing = false;
  bool isLoggedIn = false;
  String errorMessage = '';
  String? name;

  @override
  void initState() {
    initAction();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            FittedBox(
              child: Image.asset(
                "assets/images/logo1.png",
                height: 150,
                width: 150,
                cacheHeight: 150,
                cacheWidth: 150,
              ),
            ),
            SvgPicture.asset(
              "assets/images/hangout.svg",
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width,
              semanticsLabel: 'Urls',
              fit: BoxFit.fitWidth,
            ),
            Text(
              "Get the best Urls!",
              style: Theme.of(context).textTheme.headline2,
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (isProgressing)
                  CircularProgressIndicator()
                else if (!isLoggedIn)
                  CommonButton(
                    onPressed: loginAction,
                    text: 'Login | Register',
                  )
                else
                  Text('Welcome $name'),
              ],
            ),
            if (errorMessage.isNotEmpty) Text(errorMessage),
          ],
        ),
      ),
    );
  }

  setSuccessAuthState() async {
    setState(() {
      isProgressing = false;
      isLoggedIn = true;
      name = AuthService.instance.idToken?.name;
      Navigator.of(context).pushReplacementNamed(listed_url.routeName);
    });
    ProfileScreen();
  }

  setLoadingState() {
    setState(() {
      isProgressing = true;
      errorMessage = '';
    });
  }

  Future<void> loginAction() async {
    setLoadingState();
    final message = await AuthService.instance.login();
    print(message);
    if (message == 'Success') {
      print('hi');
      setSuccessAuthState();
    } else {
      setState(() {
        isProgressing = false;
        errorMessage = message;
      });
    }
  }

  initAction() async {
    setLoadingState();
    final bool isAuth = await AuthService.instance.init();
    if (isAuth) {
      setSuccessAuthState();
    } else {
      setState(() {
        isProgressing = false;
      });
    }
  }
}
