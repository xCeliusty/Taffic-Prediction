import 'package:fastroute/drawer/drawer.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:csv/csv.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';


class Statistics extends StatefulWidget {
  static const routeName = "/statistics";

  @override
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  List<List<dynamic>> _dataset = [];
  List<_SalesData> data = [];
   TimeOfDay selectedTime = TimeOfDay.now();
  late String selectDate, selectDay;
  late int selected;
  var Date =DateTime(2022, 5, 27);

  void _loadCSV() async {
    final _rawData = await rootBundle
        .loadString("assets/cairo-uberboundaries-2019-1-WeeklyAggregate.csv");
    List<List<dynamic>> _listData =
        const CsvToListConverter().convert(_rawData);
    setState(() {
      _dataset = _listData;
      // print(_listData);
      // print(_dataset[1][4].toString());
      // for (int i = 1; i < 50; i++) {
      //   print(_listData[i][4]);
      //   data.add(_SalesData(_dataset[i][3], _dataset[i][4]));
      // }
    });
  }

  

  late TooltipBehavior _tooltip;

  @override
  void initState() {
    data = [
      _SalesData("Day", 41),
      _SalesData("Year", 36),
      _SalesData("3", 20),
      _SalesData("4", 14),
      _SalesData("5", 56),
      _SalesData("6", 74),
    ];

    _loadCSV();
    

    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistics'),
      ),
      drawer: AppDrawer(),
      body: ListView(
        children: [
          Column(
            children: [
            //Initialize the chart widget
            Container(
               decoration: BoxDecoration(
         // borderRadius: BorderRadius.circular(10),
          //color: Colors.lightBlue,
          
          ),
              child: SfCartesianChart(
               
                borderColor:Color.fromARGB(255, 191, 235, 255),
                borderWidth :5,

                  primaryXAxis: CategoryAxis(),
//axes: labels,
                title: ChartTitle(text: 'Statistics'),
                
                  primaryYAxis:
                      NumericAxis(minimum: 0, maximum: 80, interval: 10),
                  isTransposed: true,
                  
                  tooltipBehavior: _tooltip,
                  series: <ChartSeries<_SalesData, String>>[
                    BarSeries<_SalesData, String>(
                        dataSource: data,
                        xValueMapper: (_SalesData data, _) => data.year,
                        yValueMapper: (_SalesData data, _) => data.sales,
                        name: '',
                       
                        color: Color.fromRGBO(8, 142, 255, 1))
                  ]),
            ),
   Row(children: [
        ElevatedButton(
          
                onPressed: () {
                 // var timeText='';
                  _selectTime(context);
                },
              child:  Text("time-selected: ${selectedTime.hour}:${selectedTime.minute}"),
            ),
 ///Text('Selected date: $_selectedDate')    selected == null ? 'No select date' :'Selecte date $selectDate - $selectDay'
            //   ElevatedButton(
            //     onPressed: () {
            //      // var timeText='';
            //       _selectTime(context);
            //     },
            //   child:  Text('Selected date: ${_selectedDate}', style: TextStyle(fontStyle: FontStyle.italic),),
            // ),
         ElevatedButton(
    onPressed: () {
        DatePicker.showDatePicker(context,
                              //showTitleActions: true,
                              minTime: DateTime(2022, 5, 27),
                              maxTime: DateTime(2022, 7, 30), onChanged: (date) {
                               Date=date;
                                // Date=date==null ?  "Today" : Date;
                             //  date='2019-01-12';
                             if(Date==null){
                               Date=DateTime(2022, 5, 27);
                             }
                            print('change $date');
                          }, onConfirm: (date) {
                            Date=date;
                           
                            print('confirm $date.day');
                          }, currentTime: DateTime.now(), locale: LocaleType.en);
    },
    child: Text('${Date}',
       // 'data${Date}'  
       // ,
        style: TextStyle(color: Colors.white),
    )),

            
           // Text("${selectedTime.hour}:${selectedTime.minute}"),
        
      //       showTimePicker(
      //   context: context,
      //   initialTime: selectedTime,
      //   initialEntryMode: TimePickerEntryMode.input,
      //   confirmText: "CONFIRM",
      //   cancelText: "NOT NOW",
      //     helpText: "BOOKING TIME",
      // ),
          ],),

            
          ]),
        ],
      ),
    );
  }



  _selectTime(BuildContext context) async {
      final TimeOfDay? timeOfDay = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        initialEntryMode: TimePickerEntryMode.dial,

      );
      if(timeOfDay != null && timeOfDay != selectedTime)
        {
          setState(() {
            selectedTime = timeOfDay;
          });
        }
  }


}/////////////

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
