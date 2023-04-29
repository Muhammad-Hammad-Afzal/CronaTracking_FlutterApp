import 'package:covid19/detail_screen.dart';
import 'package:covid19/services/fetch_data.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AllCountries extends StatefulWidget {
  const AllCountries({Key? key}) : super(key: key);

  @override
  State<AllCountries> createState() => _AllCountriesState();
}

class _AllCountriesState extends State<AllCountries> {
  TextEditingController controller = TextEditingController();
  Fetching_data_Api fetching_data_api = Fetching_data_Api();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child
          : Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: controller,
                onChanged: (value){
                  setState(() {

                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search country',
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                  )
                  ),
                ),
            ),
            Expanded(
                child: FutureBuilder(
                  future: fetching_data_api.GetAllCountries(),
                    builder: (context ,AsyncSnapshot<List<dynamic>> snapshot){
                      if(!snapshot.hasData){
                        return ListView.builder(
                            itemCount: 4,
                            itemBuilder: (Context , index){
                              return Shimmer.fromColors(
                                  period : Duration(seconds: 5),
                                  baseColor: Colors.grey.shade800,
                                  highlightColor: Colors.grey.shade200,
                                child: Column(
                                  children: [
                                    ListTile(
                                      subtitle: Container(height: 10, width: 89, color: Colors.black),
                                      title: Container(height: 10, width: 89, color: Colors.black),
                                      leading: Container(height: 50, width: 850, color: Colors.black),
                                    )
                                  ],
                                ),
                              );
                            });
                      }else{
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (Context , index){
                              String name = snapshot.data![index]['country'];

                              if(controller.text.isEmpty){
                                return Column(
                                  children: [
                                    InkWell(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => Detail_Screen(
                                            name: snapshot.data![index]['country'],
                                            image: snapshot.data![index]['countryInfo']['flag'],
                                            totalcases: snapshot.data![index]['cases'],
                                            totaldeaths: snapshot.data![index]['deaths'],
                                            active: snapshot.data![index]['active'],
                                            critical: snapshot.data![index]['critical'],
                                            todayrecovery: snapshot.data![index]['todayRecovered'],
                                            test: snapshot.data![index]['tests']))
                                        );
                                      },
                                      child: ListTile(
                                        subtitle: Text(snapshot.data![index]['cases'].toString()),
                                        title: Text(snapshot.data![index]['country']),
                                        leading: Image(
                                          height:  50,
                                          width: 50,
                                          image: NetworkImage(snapshot.data![index]['countryInfo']['flag']),),
                                      ),
                                    )
                                  ],
                                );
                              }
                              else if(name.toLowerCase().contains(controller.text.toLowerCase())){
                                return Column(
                                  children: [
                                    InkWell(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => Detail_Screen(
                                            name: snapshot.data![index]['country'],
                                            image: snapshot.data![index]['countryInfo']['flag'],
                                            totalcases: snapshot.data![index]['cases'],
                                            totaldeaths: snapshot.data![index]['deaths'],
                                            active: snapshot.data![index]['active'],
                                            critical: snapshot.data![index]['critical'],
                                            todayrecovery: snapshot.data![index]['todayRecovered'],
                                            test: snapshot.data![index]['tests']))
                                        );
                                      },
                                      child: ListTile(
                                        subtitle: Text(snapshot.data![index]['cases'].toString()),
                                        title: Text(snapshot.data![index]['country']),
                                        leading: Image(
                                          height:  50,
                                          width: 50,
                                          image: NetworkImage(snapshot.data![index]['countryInfo']['flag']),),
                                      ),
                                    )
                                  ],
                                );
                              }
                              else{
                                return Container();
                              }
                            });

                      }
                    })
            )
          ],
        ),
      ),
    );
  }
}
