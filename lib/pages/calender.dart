import 'package:flutter/material.dart';
import 'package:nepali_utils/nepali_utils.dart';

import 'package:busgo/modes/calendar_date_picker_widget.dart';
import 'package:busgo/modes/calendar_date_range_picker_widget.dart';
import 'package:busgo/modes/date_picker_widget.dart';
import 'package:busgo/modes/date_range_picker_widget.dart';

class Calender extends StatefulWidget {
  @override
  State<Calender> createState() => CalenderState();
  //State<FromTo> createState() => MapFromToState();
} 

class CalenderState extends State<Calender> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      title: 'Nepali Date Picker Demo',
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Nepali Date Picker"),
            centerTitle: true,
            bottom: TabBar(
              isScrollable: true,
              tabs: [
                Tab(text: 'Date Picker'),
                Tab(text: 'Calendar'),
                Tab(text: 'Date Range Picker'),
                Tab(text: 'Calendar Range'),
              ],
            ),
            actions: [
              IconButton(
                icon: Text(
                  NepaliUtils().language == Language.english ? 'ने' : 'En',
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      ?.copyWith(color: Colors.white),
                ),
                onPressed: () {
                  NepaliUtils().language =
                      NepaliUtils().language == Language.english
                          ? Language.nepali
                          : Language.english;
                  setState(() {});
                },
              ),
            ],
          ),
          body: TabBarView(
            children: [
              DatePickerWidget(),
              CalendarDatePickerWidget(),
              DateRangePickerWidget(),
              CalendarDateRangePickerWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
