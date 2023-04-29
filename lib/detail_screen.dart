import 'package:covid19/overall_record.dart';
import 'package:flutter/material.dart';

class Detail_Screen extends StatefulWidget {
  String name;
  String image;
  int totalcases, totaldeaths, active, critical, todayrecovery, test;
  Detail_Screen({Key? key,
    required this.name,
    required this.image,
    required this.totalcases,
    required this.totaldeaths,
    required this.active,
    required this.critical,
    required this.todayrecovery,
    required this.test,
  }) : super(key: key);

  @override
  State<Detail_Screen> createState() => _Detail_ScreenState();
}

class _Detail_ScreenState extends State<Detail_Screen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.name),

        ),
        body: Column(
          children: [
            Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * .29),
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .04),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          userowagain(title: 'Total cases', value: widget.totalcases.toString()),
                          userowagain(title: 'Total Deaths', value: widget.totaldeaths.toString()),
                          userowagain(title: 'Active', value: widget.active.toString()),
                          userowagain(title: 'Crital', value: widget.critical.toString()),
                          userowagain(title: 'Recovery', value: widget.todayrecovery.toString()),
                          userowagain(title: 'TOtal Test', value: widget.test.toString()),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * .4,
                      top: MediaQuery.of(context).size.height * .15),
                  child: CircleAvatar(
                    maxRadius: 40,
                    backgroundImage: NetworkImage(widget.image),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

