import 'package:flutter/material.dart';
// import 'package:gocorona/allCountry_data.dart';
import 'package:gocorona/service/gocorona.dart';
import './table.dart';
// import 'package:dio/dio.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Covid-19',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.greenAccent[700],
          primaryTextTheme:
              TextTheme(title: TextStyle(color: Colors.white, fontSize: 26))),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Covid-19"),
          elevation: 0.0,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Icon(
                Icons.translate,
                color: Colors.white,
                size: 40,
              ),
            )
          ],
        ),
        backgroundColor: Colors.greenAccent[700],
        body: Homepage(),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              title: Text('dashboard'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              title: Text('map'),
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), title: Text('setting'))
          ],
        ),
      ),
    );
  }
}

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  Key _tableKey = new GlobalKey();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: GoCorona().fetchCoronaData("all") ?? null,
        builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.hasError) return Center(child: Text("Error occured !"));
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());
          // for (var item in snapshot.data["areas"]) {
          //   if (item["id"] == "nepal") nepalMap = item;
          //   else nepalMap= {'case': 567};
          // }
          return SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 26, horizontal: 26),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24.0),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26,
                              blurRadius: 20.5,
                              spreadRadius: 5.0,
                              offset: Offset(10.0, 10.0))
                        ]),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Card(
                            color: Colors.white70,
                            elevation: 5.0,
                            // margin: EdgeInsets.symmetric(vertical:20 , horizontal:5.0),
                            child: Row(
                              //1st row of 1st container
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Icon(
                                        Icons.language,
                                        size: 30,
                                      ),
                                      Text('Global')
                                    ],
                                  ),
                                ),
                                Column(
                                  children: <Widget>[
                                    Text("Cases"),
                                    Text("${snapshot.data["cases"]}"),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Text("Death"),
                                    Text("${snapshot.data["deaths"]}"),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Text("Recovered"),
                                    Text("${snapshot.data["recovered"]}"),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        //second row
                        FutureBuilder(
                            future:
                                GoCorona().fetchCoronaData("countries/nepal") ??
                                    null,
                            builder: (context, snapshot) {
                              if (snapshot.hasError)
                                return Center(child: Text("Error occured !"));
                              if (!snapshot.hasData)
                                return Center(
                                    child: CircularProgressIndicator());
                              // for (var item in snapshot.data["areas"]) {
                              //   if (item["id"] == "nepal") nepalMap = item;
                              //   else nepalMap= {'case': 567};
                              // }
                              return Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Card(
                                  color: Colors.white70,
                                  elevation: 5.0,
                                  // margin: EdgeInsets.symmetric(vertical:20 , horizontal:5.0),
                                  child: Row(
                                    //1st row of 1st container
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Icon(
                                              Icons.location_city,
                                              size: 30,
                                            ),
                                            Text(
                                                "Nepal")
                                          ],
                                        ),
                                      ),
                                      Column(
                                        children: <Widget>[
                                          Text("Cases"),
                                          Text(
                                              "${snapshot.data["cases"]}"),
                                        ],
                                      ),
                                      Column(
                                        children: <Widget>[
                                          Text("Death"),
                                          Text(
                                              "${snapshot.data["deaths"]}"),
                                        ],
                                      ),
                                      Column(
                                        children: <Widget>[
                                          Text("Recovered"),
                                          Text(
                                              "${snapshot.data["recovered"]}"),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                        // 3rd row of 1st container
                        Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DataTableExample(key: _tableKey,)));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Chip(label: Text("View all countries >>")),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Card(
                            color: Colors.white70,
                            elevation: 5.0,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Icon(Icons.tv),
                                      Text("News"),
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Icon(Icons.receipt),
                                      Text("Blogs"),
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Icon(Icons.insert_link),
                                      Text("Links"),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("I'm safe"),
                              Switch(
                                  value: false,
                                  activeColor: Colors.green,
                                  onChanged: (bool state) {
                                    print(state);
                                  })
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // second card where user profile is setup

                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 26),
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26,
                              blurRadius: 20.0,
                              spreadRadius: 5.0,
                              offset: Offset(10.0, 10.0))
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24.0)),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Basic-Info",
                            style: TextStyle(fontSize: 27.0),
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            // Image.asset("assets/image/nirajan.jpg",height: 100, width:100,),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              child: CircleAvatar(
                                backgroundImage:
                                    AssetImage("assets/image/corona-virus-getty.jpg")
                                ,radius: 45.0,
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(2.5),
                              child: Column(
                                //  mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: <Widget>[
                                  Text(
                                    "Sci-Name:",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic),
                                  ),
                                  Text("Family:",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic)),
                                  Text("Size:",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic)),
                                  Text("First case",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic)),
                                ],
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(7.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Covid-19"),
                                  Text("Coronaviridae"),
                                  Text("Avg.140nm"),
                                  Text("Nov17,2019"),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
