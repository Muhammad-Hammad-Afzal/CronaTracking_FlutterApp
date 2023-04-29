import 'package:covid19/Modals/ApisModal.dart';
import 'package:covid19/services/fetch_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

import 'all_country.dart';


class OverallRecord extends StatefulWidget {
  const OverallRecord({Key? key}) : super(key: key);

  @override
  State<OverallRecord> createState() => _OverallRecordState();
}

class _OverallRecordState extends State<OverallRecord> with TickerProviderStateMixin{
  late final AnimationController _controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this)..repeat();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  Fetching_data_Api fetching_data_api = Fetching_data_Api();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
        child: Column(
          children: [
            FutureBuilder(
              future: fetching_data_api.GetAllData(),
                builder: (context ,AsyncSnapshot<ApisModal> snapshot){
                  if(!snapshot.hasData){
                    return Expanded(
                      flex: 1,
                      child: SpinKitFadingCircle(
                        color: Colors.black,
                        size: 50,
                        controller: _controller,
                      ),
                    );
                  }else{
                    return Column(
                      children: [
                        PieChart(
                          dataMap:{
                            "Total": double.parse(snapshot.data!.cases.toString()),
                            "Recoverd": double.parse(snapshot.data!.recovered.toString()),
                            "Deaths": double.parse(snapshot.data!.deaths.toString()),
                          },
                          chartValuesOptions: ChartValuesOptions(
                            showChartValuesInPercentage: true,
                          ),
                          legendOptions: LegendOptions(
                            legendPosition: LegendPosition.left,
                          ),
                          animationDuration: Duration(seconds: 2),
                          chartType: ChartType.ring,
                          chartRadius: MediaQuery.of(context).size.width/3.2,
                          colorList: [Colors.blue, Colors.green, Colors.red],
                        ),
                        SizedBox(height: 50),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Column(
                              children: [
                                userowagain(title: 'Total cases', value: snapshot.data!.cases.toString()),
                                userowagain(title: 'Recovered', value: snapshot.data!.recovered.toString()),
                                userowagain(title: 'Deaths', value: snapshot.data!.deaths.toString()),
                                userowagain(title: 'ActiveCases', value: snapshot.data!.active.toString()),
                                userowagain(title: 'Today Recovery', value: snapshot.data!.todayRecovered.toString()),
                                userowagain(title: 'Totay Cases', value: snapshot.data!.todayCases.toString()),
                              ],
                            ),
                          ),
                        ),

                      ],
                    );
                  }
                }),

            SizedBox(height: 29),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => AllCountries()));
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(child: Text('Track Country', style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold, color: Colors.white),
                    textAlign: TextAlign.center),),
              ),
            )


          ],
        ),
      )
    );
  }
}

class userowagain extends StatelessWidget {
   String title, value;
  userowagain({Key? key, required this.title, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:  10, right: 10, top: 10, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value),
        ],
      ),
    );

  }
}

