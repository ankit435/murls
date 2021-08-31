import 'package:flutter/material.dart';

Color kblue = Color(0xFF4756DF);
Color kwhite = Color(0xFFFFFFFF);
Color kblack = Color(0xFF000000);
Color kbrown300 = Color(0xFF8D6E63);
Color kbrown = Color(0xFF795548);
Color kgrey = Color(0xFFC0C0C0);

final kTitleStyle = TextStyle(
  color: Colors.white,
  fontFamily: 'CM Sans Serif',
  fontSize: 26.0,
  height: 1.5,
);

final kSubtitleStyle = TextStyle(
  color: Colors.black,
  fontSize: 18.0,
  height: 1.2,
);
final klabelStyle =
    TextStyle(color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.bold);
final kboxdecoration = BoxDecoration(
  gradient: LinearGradient(
    colors: [Color(0xFF61A3FE), Color(0xFF63FFD5)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  ),
);
final kalaisdecor = InputDecoration(
  hintText: 'Alias',
  filled: true,
  hoverColor: Colors.blue.shade100,
  border: OutlineInputBorder(),
);

final ktext =
    TextStyle(color: Colors.white, fontSize: 15.0, fontWeight: FontWeight.bold);
final kcontainerboxdecor = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xff73Aef5),
      Color(0xff61A4F1),
      Color(0xff478DE0),
      Color(0xff398Ae5),
    ],
    stops: [0.1, 0.4, 0.7, 0.9],
  ),
);

final kappbartext =
    TextStyle(color: Colors.white, fontSize: 15.0, fontWeight: FontWeight.bold);

final kurlsdecor = InputDecoration(
  hintText: 'Urls',
  filled: true,
  hoverColor: Colors.blue.shade100,
  border: OutlineInputBorder(),
);

final kelevated = ElevatedButton.styleFrom(
  primary: Colors.brown,
  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
  textStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
);

class CommonButton extends StatelessWidget {
  const CommonButton({
    Key? key,
    this.onPressed,
    this.text,
    this.child,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final String? text;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: key,
      onPressed: onPressed,
      child: child != null
          ? child ?? SizedBox()
          : Text(
              text ?? '',
            ),
    );
  }
}
