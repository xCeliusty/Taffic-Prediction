import 'package:fastroute/drawer/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';

import 'package:csv/csv.dart';
import 'package:provider/provider.dart';
//assets/cairo-uberboundaries-2019-1-WeeklyAggregate.csv"


class ReadFeaturesCsv extends StatefulWidget {
  static const routeName = "/statistics";

  @override
  _ReadFeaturesCsvState createState() => _ReadFeaturesCsvState();
}

class _ReadFeaturesCsvState extends State<ReadFeaturesCsv> {
 
 List<List<dynamic>> data = [];

 loadAsset() async {
    final myData = await rootBundle.loadString("assets/cairo-uberboundaries-2019-1-WeeklyAggregate.csv");
    List<List<dynamic>> csvTable = CsvToListConverter().convert(myData);

    data = csvTable;
    print('the data is ${data}');
 }
  

  List<List<dynamic>> _data = [];

  //This function is triggered when the floating button is pressed
  void _loadCSV() async {
    final _rawData = await rootBundle.loadString("assets/cairo-uberboundaries-2019-1-WeeklyAggregate.csv");
    List<List<dynamic>> _listData =
        const CsvToListConverter().convert(_rawData);
    setState(() {
      _data = _listData;
    });
  }

  

// void _loadCSV() async {
//  //  String imageData = await rootBundle.loadString('packages/myAppName/assets/images/ReceiptRaw_1.jpg');
//   //Image _receiptImage = await decodeImage(new File(imageData).readAsBytesSync());



//   // final  _receiptImage = rootBundle.loadString('assets/csv_file.txt');
//  // final csvToLIst = CsvToListConverter(eol: '\n\r', fieldDelimiter: '\t').convert(_receiptImage);

//  final csvFile = await rootBundle.loadString('packages/myAppName/assets/images/ReceiptRaw_1.jpg');
// //final csvToLIst = CsvToListConverter(eol: '\n\r', fieldDelimiter: '\t').convert(csvFile);
// }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       floatingActionButton:FloatingActionButton( child: const Icon(Icons.add),onPressed: () { 
         _loadCSV();
     
  },

       ) ,
      appBar: AppBar(
        title: const Text('Statistics'),
      ),
      
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: _data.length,
        itemBuilder: (_, index) {
          return Card(
            margin: const EdgeInsets.all(3),
            color: index == 0 ? Colors.amber : Colors.white,
            child: ListTile(
              leading: Text(_data[index][0].toString()),
              title: Text(_data[index][1].toString()),
              trailing: Text(_data[index][2].toString()),
            ),
          );
        },
      ),
    );
  }



  


}/////////////


