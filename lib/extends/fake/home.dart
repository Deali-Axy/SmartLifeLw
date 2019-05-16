import 'package:flutter/material.dart';

class FakeHome extends StatefulWidget {
  @override
  _FakeHomeState createState() => _FakeHomeState();
}

class _FakeHomeState extends State<FakeHome> {
  final fakeImages = [
    'images/fake/1.png',
    'images/fake/2.png',
    'images/fake/3.png',
    'images/fake/4.png',
    'images/fake/5.png',
  ];

  var index = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        child: Image.asset(
          fakeImages[index],
          fit: BoxFit.cover,
        ),
        onTap: () {
          if (index < fakeImages.length - 1)
            setState(() {
              index++;
            });
          else
            setState(() {
              index = 0;
            });
        },
      ),
    );
  }
}
