import 'package:auto_scroll_widget/auto_scroll_widget.dart';
import 'package:flutter/material.dart';

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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey blueKey = GlobalKey();
  final GlobalKey blackKey = GlobalKey();
  final GlobalKey redKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final AutoScrollController controller =
        AutoScrollController([blueKey, blackKey, redKey]);
    return Scaffold(
        appBar: AppBar(
          title: Text('Auto Scroll Widget'),
        ),
        body: AutoScrollWidget(
          controller: controller,
          child: Column(
            children: [
              RaisedButton(
                  color: Colors.blue,
                  onPressed: () =>
                      controller.scrollToKeyByKeyIndex(0, context)),
              RaisedButton(
                  color: Colors.black,
                  onPressed: () =>
                      controller.scrollToKeyByKeyIndex(1, context)),
              RaisedButton(
                  color: Colors.red,
                  onPressed: () =>
                      controller.scrollToKeyByKeyIndex(2, context)),
              Container(
                key: blueKey,
                color: Colors.blue,
                height: 300,
              ),
              Container(
                key: blackKey,
                color: Colors.black,
                height: 700,
              ),
              Container(
                key: redKey,
                color: Colors.red,
                height: 300,
              ),
            ],
          ),
        ));
  }
}
