import 'package:flutter/material.dart';

class AllCountryData extends StatelessWidget {
  final Map<dynamic, dynamic> globalData;
  const AllCountryData(this.globalData, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<dynamic> globalList = globalData["areas"]??[];
    return Scaffold(
      appBar: AppBar(title: Text("Global Data")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
            itemCount: globalList.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Text("${globalList[index]["displayName"]??"Null"}"),
                  subtitle: Column(children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Total Confirmed"),
                        Text("${globalList[index]["totalConfirmed"]??0}")
                      ],
                    ),Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Total Deaths"),
                        Text("${globalList[index]["totalDeaths"]??0}")
                      ],
                    ),Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Total Recovered"),
                        Text("${globalList[index]["totalRecovered"]??0}")
                      ],
                    )
                  ]),
                ),
              );
            }),
      ),
    );
  }
}
