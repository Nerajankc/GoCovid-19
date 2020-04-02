import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
// import './service/gocorona.dart';

// Adapted from the data table demo in offical flutter gallery:
// https://github.com/flutter/flutter/blob/master/examples/flutter_gallery/lib/demo/material/data_table_demo.dart
class DataTableExample extends StatefulWidget {
  const DataTableExample({Key key}) : super(key: key);

  @override
  _DataTableExampleState createState() => _DataTableExampleState();
}

class _DataTableExampleState extends State<DataTableExample> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  Future<dynamic> fetchCoronaData() async {
    try {
      print("called Okkay");
      var url = "https://corona.lmao.ninja/countries";
      var response = await http.get("$url");
      print(response.statusCode);
      if (response.statusCode == 200) {
        print("hello");
        var responseList = json.decode(response.body);
        return responseList;
      } else {
        print("failed");
        return json.decode(response.body);
      }
    } catch (err) {
      throw err;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Country> countries = [];
    int count = 0;
    return Scaffold(
          body: FutureBuilder(
          future: fetchCoronaData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) return Center(child: Text("Error occured !"));
            if (!snapshot.hasData)
              return Center(child: CircularProgressIndicator());
            // if(snapshot.hasData){
            //   print(snapshot.data[0]);
            // }
            for (var item in snapshot.data) {
              count++;
              countries.add(Country(
                  count,
                  item["country"],
                  item["cases"],
                  item["todayCases"],
                  item["deaths"],
                  item["todayDeaths"],
                  item["recovered"],
                  item["active"],
                  item["critical"]));
            }
            return SingleChildScrollView(
              child: PaginatedDataTable(
                dataRowHeight: kToolbarHeight,
                header: Text('Covid-19'),
                rowsPerPage: _rowsPerPage,
                availableRowsPerPage: <int>[10, 50, 100],
                onRowsPerPageChanged: (int value) {
                  setState(() {
                    _rowsPerPage = value;
                  });
                },
                columns: kTableColumns,
                source: CountryDataSource(countries),
              ),
              
            );
          }),
    );
  }
}

////// Columns in table.
const kTableColumns = <DataColumn>[
   DataColumn(
    label: const Text('S.No.'),
  ),
  DataColumn(
    label: const Text('Country'),
  ),
  DataColumn(
    label: const Text('Cases'),
    numeric: true,
  ),
  DataColumn(
    label: const Text('Today Cases'),
    numeric: true,
  ),
  DataColumn(
    label: const Text('Deaths'),
    numeric: true,
  ),
  DataColumn(
    label: const Text('Today Deaths'),
    numeric: true,
  ),
  DataColumn(
    label: const Text('Recovered'),
    numeric: true,
  ),
  DataColumn(
    label: const Text('Active'),
    numeric: true,
  ),
  DataColumn(
    label: const Text('Critical'),
    numeric: true,
  ),
];

////// Data class.
class Country {
  Country(this.sn,this.name, this.cases, this.todayCases, this.deaths, this.todayDeaths,
      this.recovered, this.active, this.critical);
  final int sn;
  final String name;
  final int cases;
  final int todayCases;
  final int deaths;
  final int todayDeaths;
  final int recovered;
  final int active;
  final int critical;
  bool selected = false;
}

////// Data source class for obtaining row data for PaginatedDataTable.
class CountryDataSource extends DataTableSource {
  final List<Country> _countries;

  CountryDataSource(this._countries);

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= _countries.length) return null;
    final Country country = _countries[index];
    return DataRow.byIndex(
        index: index,
        // selected: country.selected,
        // onSelectChanged: (bool value) {
        //   if (country.selected != value) {
        //     _selectedCount += value ? 1 : -1;
        //     assert(_selectedCount >= 0);
        //     country.selected = value;
        //     notifyListeners();
        //   }
        // },
        cells: <DataCell>[
          DataCell(Text('${country.sn}')),
          DataCell(Text('${country.name}')),
          DataCell(Text('${country.cases}')),
          DataCell(Text('${country.todayCases}')),
          DataCell(Text('${country.deaths}')),
          DataCell(Text('${country.todayDeaths}')),
          DataCell(Text('${country.recovered}')),
          DataCell(Text('${country.active}')),
          DataCell(Text('${country.critical}')),
        ]);
  }

  @override
  int get rowCount => _countries.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
