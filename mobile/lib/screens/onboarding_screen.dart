import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:murls/screens/home.dart';
import 'package:murls/utilities/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final int _numPages = 4;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Color(0xFF7B51D3),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  _storeOnboardInfo() async {
    int isViewed = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('onBoard', isViewed);
    print(prefs.getInt('onBoard'));
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData _mediaQueryData = MediaQuery.of(context);
    var widths = _mediaQueryData.size.width;
    var heights = _mediaQueryData.size.height;

    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.1, 0.4, 0.7, 0.9],
              colors: [
                Color(0xFF3594DD),
                Color(0xFF4563DB),
                Color(0xFF5036D5),
                Color(0xFF5B16D0),
              ],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // Container(
                //   alignment: Alignment.centerRight,
                //   child: FlatButton(
                //     onPressed: () {
                //       _storeOnboardInfo();
                //       Navigator.pushReplacement(
                //           context,
                //           MaterialPageRoute(
                //               builder: (context) => HomeScreen()));
                //     },
                //     child: Text(
                //       'Skip',
                //       style: TextStyle(
                //         color: Colors.white,
                //         fontSize: 20.0,
                //       ),
                //     ),
                //   ),
                // ),
<<<<<<< HEAD
                SizedBox(
                  height: 20,
                ),
=======
>>>>>>> 3ef9ff93bcae616a8a21232ce64ae77e3e8eb881
                Container(
                  height: heights * .75,
                  child: PageView(
                    physics: ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: <Widget>[
                      // Padding(
                      //   padding: EdgeInsets.all(heights * .04),
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: <Widget>[
                      //       Center(
                      //         child: FittedBox(
                      //           child: Image(
                      //             image: AssetImage(
                      //               'assets/images/onboarding0.png',
                      //             ),
                      //             fit: BoxFit.cover,
                      //             height: heights / 2,
                      //             width: widths,
                      //           ),
                      //         ),
                      //       ),
                      //       SizedBox(height: heights * .02),
                      //       Align(
                      //         alignment: Alignment.center,
                      //         child: Text(
                      //           'Connect people around the world',
                      //           style: kTitleStyle,
                      //           textAlign: TextAlign.center,
                      //         ),
                      //       ),
                      //       SizedBox(height: heights * .02),
                      //     ],
                      //   ),
                      // ),

                      Padding(
                        padding: EdgeInsets.all(heights * .06),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: FittedBox(
                                child: Image(
                                  image: AssetImage(
                                    'assets/images/onboarding-page1.png',
                                  ),
                                  fit: BoxFit.cover,
                                  height: heights / 2,
                                  width: widths,
                                ),
                              ),
                            ),
                            SizedBox(height: heights * .06),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                //'Live your life with smarter URLS!',
                                'Welcome to Murls Mobile',
                                style: kTitleStyle,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(height: heights * .02),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(heights * .06),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: FittedBox(
                                child: Image(
                                  image: AssetImage(
                                    'assets/images/onboarding-page2.png',
                                  ),
                                  fit: BoxFit.cover,
                                  height: heights / 2,
                                  width: widths,
                                ),
                              ),
                            ),
                            SizedBox(height: heights * .06),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Free and Hostable ',
                                style: kTitleStyle,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(height: heights * .02),
                            // Text(
                            //   'Lorem ipsum dolor sit amet, consect adipiscing elit, sed do eiusmod tempor incididunt ut labore et.',
                            //   style: kSubtitleStyle,
                            // ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(heights * .03),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: FittedBox(
                                // child: Image(
                                //   image: AssetImage(
                                //     'assets/images/logo.svg',
                                //   ),
                                child: SvgPicture.asset(
                                  "assets/images/logo.svg",
                                  fit: BoxFit.cover,
                                  height: 150,
                                  width: 150,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 80,
                            ),
                            Center(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.blue,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 20),
                                  textStyle: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                child: Text(
                                  'JOIN YOUR OWN SERVER',
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                onPressed: () {},
                              ),
                            ),
                            SizedBox(
                              height: 100,
                            ),
                            Center(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.orange,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 20),
                                  textStyle: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                ),
                                child: Text(
                                  'JOIN YOUR OPEN MURLS SERVER',
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                onPressed: () {
                                  _storeOnboardInfo();
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomeScreen()));
                                },
                              ),
                            )
                            // SizedBox(height: heights * .02),
                            // Align(
                            //   alignment: Alignment.center,
                            //   child: Text(
                            //     'Get a new experience of imagination',
                            //     style: kTitleStyle,
                            //     textAlign: TextAlign.center,
                            //   ),
                            // ),
                            // SizedBox(height: heights * .02),
                            // Text(
                            //   'Lorem ipsum dolor sit amet, consect adipiscing elit, sed do eiusmod tempor incididunt ut labore et.',
                            //   style: kSubtitleStyle,
                            // ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(heights * .03),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: FittedBox(
                                // child: Image(
                                //   image: AssetImage(
                                //     'assets/images/logo.svg',
                                //   ),
                                child: SvgPicture.asset(
                                  "assets/images/logo.svg",
                                  fit: BoxFit.cover,
                                  height: 150,
                                  width: 150,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 80,
                            ),
                            Center(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.blue,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 20),
                                  textStyle: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                child: Text(
                                  'JOIN YOUR OWN SERVER',
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                onPressed: () {},
                              ),
                            ),
                            SizedBox(
                              height: 100,
                            ),
                            Center(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.orange,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 20),
                                  textStyle: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                ),
                                child: Text(
                                  'JOIN YOUR OPEN MURLS SERVER',
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                onPressed: () {
                                  _storeOnboardInfo();
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomeScreen()));
                                },
                              ),
                            )
                            // SizedBox(height: heights * .02),
                            // Align(
                            //   alignment: Alignment.center,
                            //   child: Text(
                            //     'Get a new experience of imagination',
                            //     style: kTitleStyle,
                            //     textAlign: TextAlign.center,
                            //   ),
                            // ),
                            // SizedBox(height: heights * .02),
                            // Text(
                            //   'Lorem ipsum dolor sit amet, consect adipiscing elit, sed do eiusmod tempor incididunt ut labore et.',
                            //   style: kSubtitleStyle,
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),
                _currentPage != _numPages - 1
                    ? Expanded(
                        child: Align(
                          alignment: FractionalOffset.bottomRight,
                          child: FlatButton(
                            onPressed: () {
                              _pageController.nextPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease,
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  'Next',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22.0,
                                  ),
                                ),
                                SizedBox(width: heights * .014),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                  size: 30.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Text(''),
              ],
            ),
          ),
        ),
      ),
      // bottomSheet: _currentPage == _numPages - 1
      //     ? Container(
      //         height: heights / 10,
      //         width: double.infinity,
      //         color: Colors.white,
      //         child: GestureDetector(
      //           onTap: () {
      //             _storeOnboardInfo();
      //             Navigator.pushReplacement(context,
      //                 MaterialPageRoute(builder: (context) => HomeScreen()));
      //           },
      //           child: Center(
      //             child: Padding(
      //               padding: EdgeInsets.only(bottom: heights * .01),
      //               child: Text(
      //                 'Get started',
      //                 style: TextStyle(
      //                   color: Color(0xFF5B16D0),
      //                   fontSize: 20.0,
      //                   fontWeight: FontWeight.bold,
      //                 ),
      //               ),
      //             ),
      //           ),
      //         ),
      //       )
      //     : Text(''),
    );
  }
}
