import 'package:flutter/material.dart';
import 'package:star_chart/star_chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: RadarScreen(),
    );
  }
}

class RadarScreen extends StatefulWidget {
  static const routeName = "/radar";
  final List<double> values;

  const RadarScreen({Key key, this.values}) : super(key: key);

  @override
  _RadarScreenState createState() => _RadarScreenState();
}

class _RadarScreenState extends State<RadarScreen> {
  int _sides;
  static const int minimum = 2;
  static const int maximum = 40;
  @override
  void initState() {
    super.initState();
    _sides = 6;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Star chart"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StarChart(sides: _sides, percent: [0.1,0.3,0.6],),
            Slider(
              value: _sides.toDouble(),
              onChanged: (value) {
                setState(() {
                  _sides = value.round();
                });
              },
              min: minimum.toDouble(),
              max: maximum.toDouble(),
              divisions: maximum - minimum + 1,
              label: _sides.toString(),
            ),
          ],
        ),
      ),
    );
  }
}
