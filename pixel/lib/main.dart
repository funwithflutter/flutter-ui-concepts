import 'package:flutter/material.dart';
import 'package:pixel/pixel.dart';
import 'styles.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pixel',
      theme: ThemeData(
          backgroundColor: Color.fromARGB(255, 57, 57, 58),
          textTheme: textTheme,
          fontFamily: 'Silkscreen'),
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: <Widget>[
            PixelNoise(color: Theme.of(context).backgroundColor),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "images/pixel_flutter.png",
                    width: 200,
                  ),
                  Container(
                    color: Theme.of(context).backgroundColor,
                    width: double.infinity,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Text('Flutter is down',
                              style: Theme.of(context).textTheme.display2),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text('for maintenance',
                              style: Theme.of(context).textTheme.display1),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("It's not you, it's me."),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
