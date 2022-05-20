import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddPackagesScreen extends StatefulWidget {
  const AddPackagesScreen({Key? key}) : super(key: key);

  @override
  _AddPackagesScreenState createState() => _AddPackagesScreenState();

}

class _AddPackagesScreenState extends State<AddPackagesScreen>
{
  TextEditingController companyController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TimeOfDay selectedTime1 = TimeOfDay.now();
  TimeOfDay selectedTime2 = TimeOfDay.now();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Packages'),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add New Packages',
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
                        // setState(() {
                        //   companyController.text = value!;
                        //
                        // });
                      },
                      onChanged: (value) {
                        // setState(() {
                        //   companyController.text = value;
                        //
                        // });
                      },
                    ),
                    SizedBox(height: 16.0,),
                    TextFormField(
                      controller: descriptionController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(0.0),
                          child: Icon(
                            Icons.description,
                            color: Colors.black,
                          ), // icon is 48px widget.
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Description is Required';
                        }
                      },
                      onSaved: (value) {
                        // descriptionController.text = value!;
                      },
                      onChanged: (value) {
                        // descriptionController.text = value;
                      },
                    ),

                    const SizedBox(height: 16.0,),

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


                    SizedBox(height: 32.0,),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(

                        onPressed: () {
                          // _selectTime1(context);

                          if(_formKey.currentState!.validate()){
                            CollectionReference trips = FirebaseFirestore.instance.collection('packages');
                            trips.add({
                              'company_name':companyController.text,
                              'description':descriptionController.text.toString(),
                              'price' : priceController.text.toString(),
                            }).then((value) {
                              Navigator.pop(context);
                              // print("sasas");
                            }).onError((error, stackTrace) {

                              print(error);
                            });
                          }},
                        child: const Text("Add Packages"),
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
