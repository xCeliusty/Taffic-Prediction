

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddTripScreen extends StatefulWidget {
  const AddTripScreen({Key? key}) : super(key: key);

  @override
  _AddTripScreenState createState() => _AddTripScreenState();

}

class _AddTripScreenState extends State<AddTripScreen>
{
  TextEditingController companyController = TextEditingController();
  TextEditingController firstdestController = TextEditingController();
  TextEditingController lastdestController = TextEditingController();

  TextEditingController priceController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TimeOfDay selectedTime1 = TimeOfDay.now();
  TimeOfDay selectedTime2 = TimeOfDay.now();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Trip'),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add New Trip',
                style: TextStyle(fontSize: 26.0,fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       TextFormField(
                         controller: companyController,
                         keyboardType: TextInputType.text,
                         decoration: const InputDecoration(
                           labelText: 'Company Name',
                           prefixIcon: Padding(
                             padding: EdgeInsets.all(0.0),
                             child: Icon(
                               Icons.add_business,
                               color: Colors.black,
                             ), // icon is 48px widget.
                           ),
                         ),
                         validator: (value) {
                           if (value!.isEmpty) {
                             return 'Company Name is Required';
                           }
                         },
                         onSaved: (value) {
                           // companyController.text = value!;
                         },
                         onChanged: (value) {
                           // companyController.text = value;
                         },
                       ),
                       SizedBox(height: 16.0,),
                       TextFormField(
                         controller: firstdestController,
                         keyboardType: TextInputType.text,
                         decoration: const InputDecoration(
                           labelText: 'First Destination',
                           prefixIcon: Padding(
                             padding: EdgeInsets.all(0.0),
                             child: Icon(
                               Icons.directions_bus,
                               color: Colors.black,
                             ), // icon is 48px widget.
                           ),
                         ),
                         validator: (value) {
                           if (value!.isEmpty) {
                             return 'First Destination is Required';
                           }
                         },
                         onSaved: (value) {
                           // firstdestController.text = value!;
                         },
                         onChanged: (value) {
                           // firstdestController.text = value;
                         },
                       ),

                       SizedBox(height: 16.0,),
                       TextFormField(
                         controller: lastdestController,
                         keyboardType: TextInputType.text,
                         decoration: const InputDecoration(
                           labelText: 'Last Destination',
                           prefixIcon: Padding(
                             padding: EdgeInsets.all(0.0),
                             child: Icon(
                               Icons.directions_bus,
                               color: Colors.black,
                             ), // icon is 48px widget.
                           ),
                         ),
                         validator: (value) {
                           if (value!.isEmpty) {
                             return 'First Destination is Required';
                           }
                         },
                         onSaved: (value) {
                           // lastdestController.text = value!;
                         },
                         onChanged: (value) {
                           // lastdestController.text = value;
                         },
                       ),

                       SizedBox(height: 16.0,),
                       TextFormField(
                         controller: priceController,
                         keyboardType: TextInputType.number,
                         decoration: const InputDecoration(
                           labelText: 'Price',
                           prefixIcon: Padding(
                             padding: EdgeInsets.all(0.0),
                             child: Icon(
                               Icons.money,
                               color: Colors.black,
                             ), // icon is 48px widget.
                           ),
                         ),
                         validator: (value) {
                           if (value!.isEmpty) {
                             return 'Price is Required';
                           }
                         },
                         onSaved: (value) {
                           // priceController.text = value!;
                         },
                         onChanged: (value) {
                           // priceController.text = value;
                         },
                       ),

                       SizedBox(height: 16.0,),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              _selectTime1(context);
                            },
                            child: Text("Choose Departure Time"),
                          ),
                          SizedBox(width: 20.0,),
                          Text("${selectedTime1.hour}:${selectedTime1.minute}",style: TextStyle(fontSize: 18.0),),
                        ],
                      ),
                       SizedBox(height: 16.0,),
                       Row(
                         children: [
                           ElevatedButton(
                             onPressed: () {
                               _selectTime2(context);
                             },
                             child: Text("Choose Arrival Time"),
                           ),
                           SizedBox(width: 20.0,),
                           Text("${selectedTime2.hour}:${selectedTime2.minute}",style: TextStyle(fontSize: 18.0),),
                         ],
                       ),
                       SizedBox(height: 32.0,),
                       Container(
                         width: double.infinity,
                         child: ElevatedButton(

                           onPressed: () {
                             // _selectTime1(context);

                             if(_formKey.currentState!.validate()){
                             CollectionReference trips = FirebaseFirestore.instance.collection('trips');
                             trips.add({
                               'company_name':companyController.text,
                               'first_dest':firstdestController.text.toString(),
                               'first_time':"${selectedTime1.hour}:${selectedTime1.minute}",
                               'last_time':"${selectedTime2.hour}:${selectedTime2.minute}",
                               'last_dest':lastdestController.text.toString(),
                               'price' : priceController.text.toString(),
                             }).then((value) {
                               Navigator.pop(context);
                               print("sasas");
                             }).onError((error, stackTrace) {

                               print(error);
                             });
                           }},
                           child: Text("Add Trip"),
                         ),
                       ),
                     ],

                ),
              ),

            ],
          ),
        ),
      ),
    );
  }


  _selectTime1(BuildContext context) async {
    final TimeOfDay timeOfDay = (await showTimePicker(
      context: context,
      initialTime: selectedTime1,
      initialEntryMode: TimePickerEntryMode.dial,

    ))!;
    if(timeOfDay != null && timeOfDay != selectedTime1)
    {
      setState(() {
        selectedTime1 = timeOfDay;
      });
    }
  }

  _selectTime2(BuildContext context) async {
    final TimeOfDay timeOfDay = (await showTimePicker(
      context: context,
      initialTime: selectedTime2,
      initialEntryMode: TimePickerEntryMode.dial,

    ))!;
    if(timeOfDay != null && timeOfDay != selectedTime2)
    {
      setState(() {
        selectedTime2 = timeOfDay;
      });
    }
  }


}
