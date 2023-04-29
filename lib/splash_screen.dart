import 'dart:async';

import 'package:covid19/overall_record.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{

  late final AnimationController _controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this)..repeat();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 5), () {
      Navigator.push(context, MaterialPageRoute(builder: (context) =>OverallRecord()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedBuilder(
              animation: _controller,
              child: Container(
                height: 200,
                width: 200,
                child: Center(child: Image(image: AssetImage('images/virus.jpg'),)),
              ),
              builder: (BuildContext context , Widget? child){
                return Transform.rotate(
                    angle: _controller.value * 2.0 * math.pi,
                    child: child);
              }),
          SizedBox(height: 30,),
          Align(
            alignment: Alignment.center,
            child: Text('Covid-19\nTracker',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),textAlign: TextAlign.center,),
          )
        ],
      ),
    );
  }
}
